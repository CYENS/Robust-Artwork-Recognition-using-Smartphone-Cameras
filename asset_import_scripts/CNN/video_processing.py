import json
import pickle
import random
from collections import defaultdict
from pathlib import Path
from typing import Tuple

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


def dataset_from_videos(files_dir: Path, dataset_csv_info_file: str, max_frames: int = 750, batch_size: int = 128,
                        img_normalization_params: Tuple[float, float] = (0.0, 255.0), frame_size: int = 224,
                        train_val_test_percentages: Tuple[int, int, int] = (70, 30, 0)):
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
    :param batch_size: batch size for datasets
    :return: a tuple of train, validation and test tf.data.Datasets, as well as a list of the artworks ids
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

    # TODO calculate the datasets' sizes, perhaps print them, and also use them in the shuffling of the train dt below
    #  can be calculated like so: (num of classes * max_frames) * % of dataset

    # split into train, validation & test datasets
    train, val, test = train_val_test_percentages
    train_dataset, validation_and_test = split_dataset(dt, (val + test) / 100)
    validation_dataset, test_dataset = split_dataset(validation_and_test, test / (val + test))

    mean, std = img_normalization_params

    # apply necessary conversions (normalization, random modifications, batching & caching) to the created datasets
    # see https://www.tensorflow.org/datasets/keras_example for batching and caching explanation
    AUTO = tf.data.experimental.AUTOTUNE  # allows TF decide how to optimise dataset mapping below

    train_dataset = train_dataset \
        .map(random_modifications, num_parallel_calls=AUTO) \
        .map(lambda x, y: (resize_and_rescale(x, fr_size=frame_size, mean=mean, std=std), y), num_parallel_calls=AUTO) \
        .cache() \
        .shuffle(1000) \
        .batch(batch_size) \
        .prefetch(AUTO)

    validation_dataset = validation_dataset \
        .map(lambda x, y: (resize_and_rescale(x, fr_size=frame_size, mean=mean, std=std), y), num_parallel_calls=AUTO) \
        .batch(batch_size) \
        .cache() \
        .prefetch(AUTO)

    test_dataset = test_dataset \
        .map(lambda x, y: (resize_and_rescale(x, fr_size=frame_size, mean=mean, std=std), y), num_parallel_calls=AUTO) \
        .batch(batch_size) \
        .cache() \
        .prefetch(AUTO)

    return train_dataset, validation_dataset, test_dataset, artwork_list


def resize_and_rescale(img, fr_size: int, mean: float, std: float):
    """
    Resizes frames to the desired shape and scale. See https://stackoverflow.com/a/58096430 for scale conversion
    explanation.
    """
    img = tf.image.resize(img, (fr_size, fr_size))
    return (tf.cast(img, tf.float32) - mean) / std


def random_modifications(img, label):
    """
    Applies random modifications to the frame provided. The modifications may include variation in brightness,
    horizontal flipping, and random cropping (or none of the previous, in which case the frame will be returned
    untouched).
    :param img: the frame to be modified
    :param label: the corresponding label of the frame, this is returned as is
    :return: the modified frame
    """
    img = random_random_crop(img)
    img = tf.image.random_brightness(img, 0.2)
    img = tf.image.random_flip_left_right(img)
    # img = tf.image.random_hue(img, 0.2)
    return img, label


def random_random_crop(img: tf.Tensor):
    """
    Randomly crops 50% of the provided frames. The cropped frames will have a random size corresponding to 70-90% of
    their original height, and 70-90% of their original width (the 2 percentages are generated independently). The 3rd
    axis of the frame tensor, i.e. the image channels, is not modified.

    NOTE the use of only tf.random functions below, regular Python random.random functions won't work with Tensorflow.

    :param img: the frame to be cropped
    :return: the cropped frame
    """
    # lambda function that returns a random boolean, so that random cropping is only applied to 50% of the frames
    rnd_bool = lambda: tf.random.uniform(shape=[], minval=0, maxval=2, dtype=tf.int32) != 0

    # lambda function that returns a random float in the range 0.7-0.9
    rnd_pcnt = lambda: tf.random.uniform(shape=[], minval=0.7, maxval=0.9, dtype=tf.float32)

    h, w = int(float(tf.shape(img)[0]) * rnd_pcnt()), int(float(tf.shape(img)[1]) * rnd_pcnt())

    return tf.cond(rnd_bool(), lambda: tf.image.random_crop(img, size=[h, w, 3]), lambda: img)


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
    :return: frame generator
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

                while max_fr > 0:
                    success, frame = cap.read()

                    if not success:
                        break

                    if current_frame % sample_every_n_frame == 0:
                        frame = frame[:, :, ::-1]  # openCv reads frames in BGR format, convert to RGB
                        max_fr -= 1
                        yield tf.cast(frame, tf.float32), label

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
