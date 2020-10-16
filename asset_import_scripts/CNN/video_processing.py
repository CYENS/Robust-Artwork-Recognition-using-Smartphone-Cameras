import json
import pickle
import random
from collections import defaultdict
from pathlib import Path

import cv2
import numpy as np
import pandas as pd
import skvideo.io
from tqdm import tqdm


def get_video_files(video_dir: str, video_ext=None):
    """ Gets paths of video files at provided directory.

    NOTE: returning simply ``Path(video_dir).glob(f"*.{video_ext}")`` may miss files depending on the capitalization
    of their extensions, at least on Linux

    :param video_dir: path of dir with video files
    :param video_ext: the extension(s) of the required video files, can simply be a string (e.g. ".mp4"),
    or a list of string extensions (e.g. [".mp4", ".mov"], which is the default value); extensions MUST include
    leading dots
    :return: generator of Paths
    """

    if video_ext is None:
        video_ext = [".mp4", ".mov"]
    elif type(video_ext) is str:
        video_ext = [video_ext]
    else:
        raise TypeError("Inappropriate extension(s) provided")

    assert all(e.startswith(".") for e in video_ext)

    return (v for v in Path(video_dir).glob("*") if v.suffix.lower() in video_ext)


def get_video_rotation(video_path: str):
    """ Reads video rotation from video metadata.

    Works well with .mp4 files, has trouble with .mov files due to different metadata structure.

    :param video_path: path to the video file
    :return: rotation of video in int degrees (e.g. 90, 180)
    :raises AssertionError if rotation is not available, files doesn't exist, or file doesn't have metadata
    """
    metadata = skvideo.io.ffprobe(video_path)
    try:
        for tags in metadata["video"]["tag"]:
            # we get OrderedDicts here
            if tags["@key"] == "rotate":
                return int(tags["@value"])
        else:
            raise AssertionError(f"Couldn't get rotation for {video_path}, either file doesn't exist, does not contain "
                                 f"metadata, or rotation is not included in its metadata.")
    except Exception as e:
        raise e


def extract_video_frames(video_path: Path, rotate: bool = True, resize: bool = True, frame_limiter: int = 1,
                         number_of_frames: int = None, save_as_files: bool = False):
    """ Extracts all frames from the provided video, and optionally saves them as individual images in a directory with
    the same name as the video.

    :param frame_limiter: optional, an integer that limits the number of frames returned; e.g. if equal to 2,
     every second frame will be returned, if 3 every 3rd, etc
    :param number_of_frames: optional, the total number of frames required; in case the video contains fewer frames
     than required, all available frames will be returned; careful when used in conjunction with frame_limiter
    :param video_path: path to the video file
    :param resize: optional, whether to resize frames
    :param rotate: optional, whether to rotate frames
    :param save_as_files: optional, whether to save extracted frames as individual image files
    :return: list of extracted frames
    """
    frame_dest = ""
    if save_as_files:
        # create frame destination dir and make sure it exists
        frame_dest = video_path.parent / video_path.stem
        frame_dest.mkdir(exist_ok=True)

    video_rotation = 0
    try:
        video_rotation = get_video_rotation(str(video_path))
    except AssertionError as ex:
        print(ex)
    except Exception as ex2:  # catch any other exceptions
        print(ex2)

    count = 0

    vidcap = cv2.VideoCapture(str(video_path))
    success, frame = vidcap.read()  # read 1st frame

    all_frames = []

    while success:
        if count % frame_limiter == 0:  # limits the number of frames
            if rotate:
                if video_rotation != 0:
                    frame = rotate_frame(frame, video_rotation)

            if resize:
                frame = resize_frame(frame)

            if save_as_files:
                cv2.imwrite(str(frame_dest / f"{video_path.stem}_{count}.jpg"), frame)

            all_frames.append(np.copy(frame))

        success, frame = vidcap.read()  # read next frame

        count += 1

        if number_of_frames is not None:
            if number_of_frames >= count:
                break

    return all_frames


def rotate_frame(frame: np.ndarray, degrees: int):
    """ Rotates the provided frame 90, 180, or 270 degrees; any other value of degrees is ignored, and the original
    frame is returned un-rotated.

    :param frame: frame to be rotated
    :param degrees: degrees of rotation, must be either 90, 180, or 270, any other values are ignored
    :return: the rotated frame
    """
    if degrees == 90:
        return cv2.rotate(frame, cv2.ROTATE_90_CLOCKWISE)
    elif degrees == 180:
        return cv2.rotate(frame, cv2.ROTATE_180)
    elif degrees == 270:
        return cv2.rotate(frame, cv2.ROTATE_90_COUNTERCLOCKWISE)
    else:
        return frame


def resize_frame(frame: np.ndarray, target_dim: int = 224):
    """ Resizes the provided frame to a square with the provided dimension as its sides.

    :param frame: frame to be resized
    :param target_dim: the required side length of the resized frame (optional)
    :return: the resized frame
    """
    return cv2.resize(frame, (target_dim, target_dim), interpolation=cv2.INTER_AREA)


def video_processing(video_files_dir: Path):
    dataset = pd.read_csv(video_files_dir / "description_export.csv")

    # dict with all artwork IDs, as well as a corresponding numerical value
    artwork_dict = {artwork_id: i for i, artwork_id in enumerate(sorted(dataset["id"].unique()))}

    photos, labels = [], []
    t = tqdm(total=dataset.shape[0])
    total_frames = 0

    # process all video files
    for i in range(dataset.shape[0]):
        video_file_row = dataset.iloc[i]

        t.set_postfix_str(f"Processing file {video_file_row['file']} (total frames for far: {total_frames})")

        video_frames = extract_video_frames(video_files_dir / video_file_row["file"])

        frame_labels = [video_file_row["id"]] * len(video_frames)

        photos.extend(video_frames)
        labels.extend(frame_labels)

        total_frames += len(video_frames)
        t.update()

    t.close()

    # return results as a single dict
    return {"photos": photos, "labels": labels}


def save_sample_frames(video_files_dir: Path):
    dataset = pd.read_csv(video_files_dir / "description_export.csv")

    # make new dir to put samples in
    sample_dir = video_files_dir / "artwork_samples_100"
    sample_dir.mkdir(exist_ok=True)

    for i in range(dataset.shape[0]):
        video_file_row = dataset.iloc[i]
        print("extracting from:", video_file_row["id"])

        video_dir = sample_dir / video_file_row['id']
        if not video_dir.is_dir():  # skip video if dir with extracted frames already exists
            video_dir.mkdir()
            video_frames = extract_video_frames(video_files_dir / video_file_row["file"], resize=False,
                                                frame_limiter=8)

            for j, frame in enumerate(random.sample(video_frames, 50)):
                frame_path = video_dir / f"{i}_{j}.jpg"
                cv2.imwrite(str(frame_path), frame)


def unpickle():
    pickled = Path("/home/marios/Downloads/contemporary_art_video_files/processed")
    with open(pickled, "rb") as f:
        f.seek(0)
        dataset = pickle.load(f)


def frame_generator_by_artwork(video_files_dir: Path):
    max_frames_per_artwork = 20
    dataset = pd.read_csv(video_files_dir / "description_export2.csv")
    artwork_dict = {artwork_id: i for i, artwork_id in
                    enumerate(sorted(dataset["id"].unique()))}
    num_classes = len(artwork_dict)
    class_list = list(artwork_dict.keys())
    for artwork_id in class_list:
        print(artwork_id)
        videos_for_artwork = [files_dir / row["file"] for _, row in dataset.loc[dataset["id"] == artwork_id].iterrows()]

        assert all(v.is_file() for v in videos_for_artwork)

        total_frames_for_artwork = sum(
            int(cv2.VideoCapture(str(v)).get(cv2.CAP_PROP_FRAME_COUNT)) for v in videos_for_artwork)
        print("total", total_frames_for_artwork)

        sample_every_n_frame = max(1, total_frames_for_artwork // max_frames_per_artwork)

        current_frame = 0
        max_fr = max_frames_per_artwork

        for video_file in videos_for_artwork:
            print("video", video_file.name, int(cv2.VideoCapture(str(video_file)).get(cv2.CAP_PROP_FRAME_COUNT)))
            cap = cv2.VideoCapture(str(video_file))
            while True:
                success, frame = cap.read()

                if not success:
                    print("not success, breaking")
                    break

                if current_frame % sample_every_n_frame == 0:
                    # openCv reads frames in BGR format, convert to RGB
                    # frame = frame[:, :, ::-1]

                    # img = tf.image.resize(frame, (224,224))

                    max_fr -= 1

                    # yield  tf.cast(img, tf.float32) / 255., label
                    yield f"{max_fr} {current_frame} {video_file}"

                    if max_fr <= 0:
                        print("max_fr reached, breaking")
                        break

                current_frame += 1


def video_resolutions(video_files_dir: Path):
    dataset = pd.read_csv(video_files_dir / "description_export2.csv")

    for i in range(dataset.shape[0]):
        vid_path = video_files_dir / dataset.iloc[i]["file"]
        assert vid_path.is_file()

        cap = cv2.VideoCapture(str(vid_path))

        print({"video height": cap.get(cv2.CAP_PROP_FRAME_HEIGHT),
               "video width": cap.get(cv2.CAP_PROP_FRAME_WIDTH),
               "frame count": cap.get(cv2.CAP_PROP_FRAME_COUNT),
               "file": vid_path.name,
               "id": dataset.iloc[i]["id"]})


def frame_counts(video_files_dir: Path):
    """ Reads all video files in provided dir and returns the number of available frames for each artwork (i.e. frames
    from videos about the same artworks are aggregated).

    :param video_files_dir: path of dir with video files
    :return: dict with artwork ids as keys and number of frames as values
    """
    dataset = pd.read_csv(video_files_dir / "description_export2.csv")
    count_dict = defaultdict(int)

    for i in range(dataset.shape[0]):
        if dataset.iloc[i]["id"] == "no_artwork":
            continue
        vid_path = video_files_dir / dataset.iloc[i]["file"]
        print(vid_path)
        assert vid_path.is_file()

        cap = cv2.VideoCapture(str(vid_path))

        # NOTE: openCv by default reads in BGR, see link
        # https://docs.opencv.org/3.4/d8/d01/group__imgproc__color__conversions.html#ga397ae87e1288a81d2363b61574eb8cab
        # success, frame = cap.read()
        # fr = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        frame_count = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
        print(frame_count)
        count_dict[dataset.iloc[i]["id"]] += frame_count

    print(f"max frames: {max(count_dict.values())}, min frames: {min(count_dict.values())}", "\n",
          json.dumps(count_dict, indent=2))

    return count_dict


def dataset_from_videos(files_dir: Path, dataset_csv_info_file: str, img_normalization_params: tuple = (0.0, 255.0),
                        max_frames: int = 750, frame_size: int = 224, train_val_test_percentages: tuple = (70, 30, 0),
                        vary_train_dataset: bool = True):
    """
    Generates train, validation and test tf.data.Datasets from the provided video files.

    :param files_dir: path of the directory containing the videos
    :param dataset_csv_info_file: name of csv file containing information about the videos, must be located in files_dir
    :param img_normalization_params: tuple of doubles (mean, standard_deviation) to use for normalizing the extracted
     frames, e.g. if (0.0, 255.0) is provided, the frames are normalized to the range [0, 1], see this comment for
     explanation of how to convert between the two https://stackoverflow.com/a/58096430
    :param max_frames: total number of frames to extract for each artwork
    :param frame_size: the size of the final resized square frames, this is dictated by the needs of the underlying NN
     that will be used in the training
    :param train_val_test_percentages: tuple specifying how to split the generated dataset into train, validation and
     test datasets, the provided ints must add up to 100
    :param vary_train_dataset: whether to apply random variations to the frames of the train dataset (e.g. random
     crops, random flips left-right, etc.)
    :return: a tuple of train, validation and test tf.data.Datasets
    """
    assert sum(train_val_test_percentages) == 100, "Split percentages must add up to 100!"

    dataset_info = pd.read_csv(files_dir / dataset_csv_info_file)

    # make sure all files in csv are present
    for _, row in dataset_info.iterrows():
        assert (files_dir / row["file"]).is_file(), "One or more of the video files don't exist"

    # sort artwork ids in alphabetical order, this is important as it determines how the CNN outputs its predictions
    artwork_dict = {artwork_id: i for i, artwork_id in enumerate(sorted(dataset_info["id"].unique()))}
    artwork_list = list(artwork_dict.keys())

    # create dataset, output_shapes are set to (None, None, 3), since the extracted frames are not initially resized,
    # to allow applying variations to the train dataset only below
    dt = tf.data.Dataset.from_generator(lambda: frame_generator(files_dir, dataset_info, max_frames),
                                        output_types=(tf.float32, tf.float32),
                                        output_shapes=((None, None, 3), (len(artwork_list))))

    # split into train, validation & test datasets
    train, val, test = train_val_test_percentages
    train_dataset, validation_and_test = split_dataset(dt, (val + test) / 100)
    validation_dataset, test_dataset = split_dataset(validation_and_test, test / (val + test))

    # see https://www.tensorflow.org/datasets/keras_example
    # train_dataset = train_dataset.cache().shuffle(1000).batch(128).prefetch(tf.data.experimental.AUTOTUNE)
    # validation_dataset = validation_dataset.batch(128).cache().prefetch(tf.data.experimental.AUTOTUNE)
    # test_dataset = test_dataset.batch(128).cache().prefetch(tf.data.experimental.AUTOTUNE)

    return train_dataset, validation_dataset, test_dataset


def frame_generator(files_dir: Path, dataset_info: pd.DataFrame, max_frames: int, generate_by: str = "artwork"):
    """
    Extracts frames from the video files provided, and can be used as an input to create Tensorflow Datasets.

    Adapted from http://borg.csueastbay.edu/~grewe/CS663/Mat/LSTM/Exercise_VideoActivity_LSTM.html

    :param files_dir: path of the directory containing the videos
    :param dataset_info: pandas df containing the names of the videos and their corresponding labels
    :param max_frames: the total number of frames to extract; if fewer frames than requested are available,
     all frames for artwork/video will be extracted; if more are available, frames are extracted evenly from all
     frames available
    :param generate_by: whether to extract frames per artwork or per video, since an artwork may have multiple videos;
     should be either "artwork" or "video" only, any other value is ignored
    """
    if generate_by not in ["artwork", "video"]:
        generate_by = "artwork"

    artwork_list = [artwork_id for artwork_id in sorted(dataset_info["id"].unique())]

    if generate_by == "artwork":
        for artwork_id in artwork_list:
            videos_for_artwork = [files_dir / row["file"] for _, row in
                                  dataset_info.loc[dataset_info["id"] == artwork_id].iterrows()]

            total_frames_for_artwork = sum(
                int(cv2.VideoCapture(str(v)).get(cv2.CAP_PROP_FRAME_COUNT)) for v in videos_for_artwork)

            # convert label to categorical array (of type tf.float32)
            label = tf.one_hot(artwork_list.index(artwork_id), len(artwork_list))

            sample_every_n_frame = max(1, total_frames_for_artwork // max_frames)

            current_frame = 0
            max_fr = max_frames

            for video_file in videos_for_artwork:
                cap = cv2.VideoCapture(str(video_file))

                while True:
                    success, frame = cap.read()

                    if not success:
                        break

                    if current_frame % sample_every_n_frame == 0:
                        frame = frame[:, :, ::-1]  # openCv reads frames in BGR format, convert to RGB
                        max_fr -= 1
                        yield tf.cast(frame, tf.float32), label

                        if max_fr <= 0:
                            break

                    current_frame += 1

    elif generate_by == "video":
        for _, row in dataset_info.iterrows():
            video_file = files_dir / row["file"]

            # label to categorical (type tf.float32)
            label = tf.one_hot(artwork_list.index(row["id"]), len(artwork_list))

            cap = cv2.VideoCapture(str(video_file))
            num_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
            sample_every_n_frame = max(1, num_frames // max_frames)

            current_frame = 0
            max_fr = max_frames

            while True:
                success, frame = cap.read()
                if not success:
                    break

                if current_frame % sample_every_n_frame == 0:
                    frame = frame[:, :, ::-1]  # openCv reads frames in BGR format, convert to RGB
                    max_fr -= 1
                    yield tf.cast(frame, tf.float32), label

                if max_fr == 0:
                    break

                current_frame += 1


def split_dataset(dataset: tf.data.Dataset, validation_data_fraction: float):
    """
    Splits a dataset of type tf.data.Dataset into a training and validation dataset using given ratio. Fractions are
    rounded up to two decimal places. From https://stackoverflow.com/a/59696126

    :param dataset: the input dataset to split
    :param validation_data_fraction: the fraction of the validation data as a float between 0 and 1
    :return: a tuple of two tf.data.Datasets as (training, validation)
    """
    validation_data_percent = round(validation_data_fraction * 100)
    if not (0 <= validation_data_percent <= 100):
        raise ValueError("validation data fraction must be ∈ [0,1]")

    dataset = dataset.enumerate()
    train_dataset = dataset.filter(lambda f, data: f % 100 > validation_data_percent)
    validation_dataset = dataset.filter(lambda f, data: f % 100 <= validation_data_percent)

    # remove enumeration
    train_dataset = train_dataset.map(lambda f, data: data)
    validation_dataset = validation_dataset.map(lambda f, data: data)

    return train_dataset, validation_dataset


if __name__ == '__main__':
    files_dir = Path("/home/marios/Downloads/contemporary_art_video_files")
    # processed = video_processing(files_dir)
    # with open(files_dir / "processed", "wb+") as f:
    #     pickle.dump(processed, f)
    # save_sample_frames(files_dir)
    # frame_counts(files_dir)
    # for v in get_video_files(files_dir / "not_artwork_videos"):
    #     print(v.name)
    video_resolutions(files_dir)
