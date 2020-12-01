import functools
import json
import pickle
import random
import subprocess
from collections import defaultdict, OrderedDict
from datetime import datetime
from pathlib import Path
from typing import Tuple

import cv2
import numpy as np
import pandas as pd
import seaborn as sn
import skvideo.io
import tensorflow as tf
from IPython.display import display, display_markdown
from PIL import Image, ImageEnhance
from matplotlib import pyplot as plt
from sklearn.metrics import classification_report, confusion_matrix
from tqdm import tqdm


def get_video_files(video_dir: str, video_ext=None):
    """ Gets paths of video files at provided directory.

    NOTE: returning simply ``Path(video_dir).glob(f"*.{video_ext}")`` may miss
    files depending on the capitalization of their extensions, at least on
    Linux.

    :param video_dir: path of dir with video files
    :param video_ext: the extension(s) of the required video files, can simply
     be a string (e.g. ".mp4"), or a list of string extensions
     (e.g. [".mp4", ".mov"], which is the default value); extensions MUST
     include leading dots
    :return: generator of Paths
    """

    if video_ext is None:
        video_ext = [".mp4", ".mov"]
    elif type(video_ext) is str:
        video_ext = [video_ext]
    else:
        raise TypeError("Inappropriate extension(s) provided")

    assert all(e.startswith(".") for e in video_ext)

    return (v for v in Path(video_dir).glob("*") if
            v.suffix.lower() in video_ext)


def get_video_rotation(video_path: str):
    """ Reads video rotation from video metadata using scikit-video.

    Works well with .mp4 files, but has trouble with .mov files due to
    different metadata structure; .mov files also often do not contain rotation
    information, but openCV seems to read frames from .mov files in the correct
    orientation, so things balance out.

    :param video_path: path to the video file
    :return: rotation of video in int degrees (e.g. 0, 90, 180)
    """
    orientation = 0
    try:
        metadata = skvideo.io.ffprobe(video_path)

        for tags in metadata["video"]["tag"]:
            # we get OrderedDicts here
            if tags["@key"] == "rotate":
                orientation = int(tags["@value"])

    except Exception:
        pass

    return orientation


def extract_video_frames(video_path: Path, rotate: bool = True,
                         resize: bool = True, frame_limiter: int = 1,
                         number_of_frames: int = None,
                         save_as_files: bool = False):
    """ Extracts all frames from the provided video, and optionally saves them
    as individual images in a directory with the same name as the video.

    :param frame_limiter: optional, an integer that limits the number of frames
     returned; e.g. if equal to 2, every second frame will be returned, etc.
    :param number_of_frames: optional, the total number of frames required; in
     case the video contains fewer frames than required, all available frames
     will be returned; careful when used in conjunction with frame_limiter
    :param video_path: path to the video file
    :param resize: optional, whether to resize frames
    :param rotate: optional, whether to rotate frames
    :param save_as_files: optional, whether to save extracted frames as
     individual image files
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
                cv2.imwrite(str(frame_dest / f"{video_path.stem}_{count}.jpg"),
                            frame)

            all_frames.append(np.copy(frame))

        success, frame = vidcap.read()  # read next frame

        count += 1

        if number_of_frames is not None:
            if number_of_frames >= count:
                break

    return all_frames


def rotate_frame(frame: np.ndarray, degrees: int):
    """ Rotates the provided frame 90, 180, or 270 degrees; any other value of
    degrees is ignored, and the original frame is returned un-rotated.

    :param frame: frame to be rotated
    :param degrees: degrees of rotation, must be either 90, 180, or 270,
     any other values are ignored
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
    """ Resizes the provided frame to a square with the provided dimension as
    its sides.

    :param frame: frame to be resized
    :param target_dim: the required side length of the resized frame (optional)
    :return: the resized frame
    """
    return cv2.resize(frame, (target_dim, target_dim),
                      interpolation=cv2.INTER_AREA)


def video_processing(video_files_dir: Path):
    dataset = pd.read_csv(video_files_dir / "description_export.csv")

    # dict with all artwork IDs, as well as a corresponding numerical value
    artwork_dict = {artwork_id: i for i, artwork_id in
                    enumerate(sorted(dataset["id"].unique()))}

    photos, labels = [], []
    t = tqdm(total=dataset.shape[0])
    total_frames = 0

    # process all video files
    for i in range(dataset.shape[0]):
        video_file_row = dataset.iloc[i]

        t.set_postfix_str(
            f"Processing file {video_file_row['file']} (total frames for far: "
            f"{total_frames})")

        video_frames = extract_video_frames(
            video_files_dir / video_file_row["file"])

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
        # skip video if dir with extracted frames already exists
        if not video_dir.is_dir():
            video_dir.mkdir()
            video_frames = extract_video_frames(
                video_files_dir / video_file_row["file"], resize=False,
                frame_limiter=8)

            for j, frame in enumerate(random.sample(video_frames, 50)):
                frame_path = video_dir / f"{i}_{j}.jpg"
                cv2.imwrite(str(frame_path), frame)


def unpickle():
    pickled = Path(
        "/home/marios/Downloads/contemporary_art_video_files/processed")
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
    """ Reads all video files in provided dir and returns the number of
    available frames for each artwork (i.e. frames from videos about the same
    artworks are aggregated).

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

        # NOTE: openCv by default reads in BGR
        # success, frame = cap.read()
        # fr = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        frame_count = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
        print(frame_count)
        count_dict[dataset.iloc[i]["id"]] += frame_count

    print(
        f"max frames: {max(count_dict.values())}, min frames: "
        f"{min(count_dict.values())}",
        "\n",
        json.dumps(count_dict, indent=2))

    return count_dict


def frame_generator(files_dir: Path, dataset_info: pd.DataFrame,
                    max_frames: int, generate_by: str = "artwork",
                    extract_every_n_frames: int = None):
    """
    Generator that extracts frames from the video files provided, and can be
    used as an input to create Tensorflow Datasets.

    Adapted from
    http://borg.csueastbay.edu/~grewe/CS663/Mat/LSTM/Exercise_VideoActivity_LSTM.html

    :param files_dir: path of the directory containing the videos
    :param dataset_info: pandas df containing the names of the videos and their
     corresponding labels
    :param max_frames: the total number of frames to extract; if fewer frames
     than requested are available, all frames for artwork/video will be
     extracted; if more are available, frames are extracted evenly from all
     frames available
    :param generate_by: whether to extract frames per artwork or per video,
     since an artwork may have multiple videos; should be either "artwork" or
     "video" only, any other value is ignored and the default value "artwork"
     is used
    :param extract_every_n_frames: optional - forces the extraction of frames
     to occur at the provided interval, until either max_frames is reached, or
     the available frames run out; can be used to simulate how the CNN analysis
     of frames occurs on mobile devices, where the currently available frame is
     send for analysis, and only when that analysis is finished the currently
     available frame is selected for analysis; the interval between two
     analyses can vary depending on device and the CNN used, but can be
     anywhere between 200ms to a few seconds; for example, if we assume
     30fps video and 200ms intervals for each analysis, only 1 out of every
     6 frames will be analysed, and so a value of 6 would be suitable for
     extract_every_n_frames in that case
    :return: frame generator of tuples (frame, label) when
     generate_by="artwork", else tuples of (frame, label, video_name)
     when generate_by="video"
    """
    if generate_by not in ["artwork", "video"]:
        generate_by = "artwork"

    artwork_list = [artwork_id for artwork_id in
                    sorted(dataset_info["id"].unique())]

    if generate_by == "artwork":
        for artwork_id in artwork_list:
            videos_for_artwork = \
                [files_dir / row["file"] for _, row in
                 dataset_info.loc[dataset_info["id"] == artwork_id].iterrows()]

            total_frames_for_artwork = sum(
                int(cv2.VideoCapture(str(v)).get(cv2.CAP_PROP_FRAME_COUNT)) for
                v in videos_for_artwork)

            # if extract_every_n_frames is not explicitly provided, calculate
            # it here based on total available frames and max_frames required
            extract_every_n_frames_artwork = extract_every_n_frames
            if extract_every_n_frames_artwork is None:
                extract_every_n_frames_artwork = \
                    max(1, total_frames_for_artwork // max_frames)

            # convert label to categorical array (of type tf.float32)
            label = tf.one_hot(artwork_list.index(artwork_id),
                               len(artwork_list))

            current_frame = 0
            max_fr = max_frames

            for video_file in videos_for_artwork:
                cap = cv2.VideoCapture(str(video_file))

                # read video orientation once, in case of error value will be 0
                orientation = get_video_rotation(str(video_file))
                # rot90() below rotates counter-clockwise, so by providing a
                # negative k the frames are rotated clockwise
                k = orientation // -90

                while max_fr > 0:
                    success, frame = cap.read()

                    if not success:
                        break

                    if current_frame % extract_every_n_frames_artwork == 0:
                        # openCv reads frames in BGR format, convert to RGB
                        frame = frame[:, :, ::-1]
                        # rotate frame according to video orientation
                        frame = tf.image.rot90(frame, k)

                        max_fr -= 1

                        yield tf.cast(frame, tf.float32), label

                    current_frame += 1

    elif generate_by == "video":
        for _, row in dataset_info.iterrows():
            video_name = row["file"]
            video_file = files_dir / video_name

            # label to categorical (type tf.float32)
            label = tf.one_hot(artwork_list.index(row["id"]), len(artwork_list))

            cap = cv2.VideoCapture(str(video_file))
            num_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))

            # if extract_every_n_frames is not explicitly provided, calculate
            # it here based on total available frames and max_frames required
            extract_every_n_frames_video = extract_every_n_frames
            if extract_every_n_frames_video is None:
                extract_every_n_frames_video = max(1, num_frames // max_frames)

            orientation = get_video_rotation(str(video_file))
            k = orientation // -90

            current_frame = 0
            max_fr = max_frames

            while True:
                success, frame = cap.read()
                if not success:
                    break

                if current_frame % extract_every_n_frames_video == 0:
                    # openCv reads frames in BGR format, convert to RGB
                    frame = frame[:, :, ::-1]
                    # rotate frame according to video orientation
                    frame = tf.image.rot90(frame, k)

                    max_fr -= 1

                    yield tf.cast(frame, tf.float32), label, video_name

                if max_fr == 0:
                    break

                current_frame += 1


def resize_and_rescale(img, fr_size: int, mean: float, std: float):
    """
    Resizes frames to the desired shape and scale. See
    https://stackoverflow.com/a/58096430 for scale conversion explanation.
    """
    img = tf.image.resize(img, (fr_size, fr_size))
    return (tf.cast(img, tf.float32) - mean) / std


def random_modifications(img, label):
    """
    Applies random modifications to the frame provided. The modifications may
    include variation in brightness, horizontal flipping, and random cropping
    (or none of the previous, in which case the frame will be returned
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
    Randomly crops 50% of the provided frames. The cropped frames will have a
    random size corresponding to 70-90% of their original height, and 70-90% of
    their original width (the 2 percentages are generated independently). The
    3rd axis of the frame tensor, i.e. the image channels, is not modified.

    NOTE the use of only tf.random functions below, regular Python
    random.random functions won't work with Tensorflow.

    :param img: the frame to be cropped
    :return: the cropped frame
    """
    # lambda function that returns a random boolean, so that random cropping
    # is only applied to 50% of the frames
    rnd_bool = lambda: tf.random.uniform(shape=[], minval=0, maxval=2,
                                         dtype=tf.int32) != 0

    # lambda function that returns a random float in the range 0.7-0.9
    rnd_pcnt = lambda: tf.random.uniform(shape=[], minval=0.7, maxval=0.9,
                                         dtype=tf.float32)

    h, w = int(float(tf.shape(img)[0]) * rnd_pcnt()), int(
        float(tf.shape(img)[1]) * rnd_pcnt())

    return tf.cond(rnd_bool(),
                   lambda: tf.image.random_crop(img, size=[h, w, 3]),
                   lambda: img)


def sort_dict_by_value(d: dict, reverse: bool = False):
    """
    Sorts the provided dictionary by its values, returning an OrderedDict.

    :param d: the dictionary to be sorted
    :param reverse: whether to reverse the order of values; if False, the
     values will be in ascending order, and if True the reverse
    """
    return OrderedDict(
        sorted(d.items(), key=lambda item: item[1], reverse=reverse))


def split_dataset(dataset: tf.data.Dataset, validation_data_fraction: float):
    """
    Splits a dataset of type tf.data.Dataset into a training and validation
    dataset using given ratio. Fractions are rounded up to two decimal places.
    From https://stackoverflow.com/a/59696126

    :param dataset: the input dataset to split
    :param validation_data_fraction: the fraction of the validation data as a
     float between 0 and 1
    :return: a tuple of two tf.data.Datasets as (training, validation)
    """
    validation_data_percent = round(validation_data_fraction * 100)
    if not (0 <= validation_data_percent <= 100):
        raise ValueError("validation data fraction must be ∈ [0,1]")

    dataset = dataset.enumerate()
    train_dataset = dataset.filter(
        lambda f, data: f % 100 > validation_data_percent)
    validation_dataset = dataset.filter(
        lambda f, data: f % 100 <= validation_data_percent)

    # remove enumeration
    train_dataset = train_dataset.map(lambda f, data: data)
    validation_dataset = validation_dataset.map(lambda f, data: data)

    return train_dataset, validation_dataset


def dataset_from_videos(files_dir: Path, dataset_csv_info_file: str,
                        max_frames: int = 750, batch_size: int = 128,
                        img_normalization_params: Tuple[float, float] = (
                                0.0, 255.0), frame_size: int = 224,
                        train_val_test_percentages: Tuple[int, int, int] = (
                                70, 30, 0)):
    """
    Generates train, validation and test tf.data.Datasets from the provided
    video files.

    :param files_dir: path of the directory containing the videos
    :param dataset_csv_info_file: name of csv file containing information about
     the videos, must be located in files_dir
    :param img_normalization_params: tuple of doubles (mean, standard_deviation)
     to use for normalizing the extracted frames, e.g. if (0.0, 255.0) is
     provided, the frames are normalized to the range [0, 1], see this comment
     for explanation of how to convert between the two
     https://stackoverflow.com/a/58096430
    :param max_frames: total number of frames to extract for each artwork
    :param frame_size: the size of the final resized square frames, this is
     dictated by the needs of the underlying NN that will be used
    :param train_val_test_percentages: tuple specifying how to split the
     generated dataset into train, validation and test datasets, the provided
     ints must add up to 100
    :param batch_size: batch size for datasets
    :return: a tuple of train, validation and test tf.data.Datasets, as well
     as a list of the artworks ids
    """
    assert sum(
        train_val_test_percentages) == 100, "Percentages must add up to 100!"

    dataset_info = pd.read_csv(files_dir / dataset_csv_info_file)

    # make sure all files in csv are present
    for _, row in dataset_info.iterrows():
        assert (files_dir / row[
            "file"]).is_file(), "One or more of the video files don't exist"

    # sort artwork ids in alphabetical order, this is important as it
    # determines how the CNN outputs its predictions
    artwork_dict = {artwork_id: i for i, artwork_id in
                    enumerate(sorted(dataset_info["id"].unique()))}
    artwork_list = list(artwork_dict.keys())

    # create dataset, output_shapes are set to (None, None, 3), since the
    # extracted frames are not initially resized,
    # to allow applying variations to the train dataset only below
    dt = tf.data.Dataset.from_generator(
        lambda: frame_generator(files_dir, dataset_info, max_frames),
        output_types=(tf.float32, tf.float32),
        output_shapes=((None, None, 3), (len(artwork_list))))

    # TODO calculate the datasets' sizes, perhaps print them, and also use them
    #  in the shuffling of the train dt below can be calculated like so:
    #  (num of classes * max_frames) * % of dataset

    # split into train, validation & test datasets
    train, val, test = train_val_test_percentages
    train_dataset, validation_and_test = split_dataset(dt, (val + test) / 100)
    validation_dataset, test_dataset = split_dataset(validation_and_test,
                                                     test / (val + test))

    mean, std = img_normalization_params

    # apply necessary conversions (normalization, random modifications,
    # batching & caching) to the created datasets
    # see https://www.tensorflow.org/datasets/keras_example for batching and
    # caching explanation
    AUTO = tf.data.experimental.AUTOTUNE  # auto-optimise dataset mapping below

    train_dataset = train_dataset \
        .map(random_modifications, num_parallel_calls=AUTO) \
        .map(lambda x, y: (
        resize_and_rescale(x, fr_size=frame_size, mean=mean, std=std), y),
             num_parallel_calls=AUTO) \
        .cache() \
        .shuffle(1000) \
        .batch(batch_size) \
        .prefetch(AUTO)

    validation_dataset = validation_dataset \
        .map(lambda x, y: (
        resize_and_rescale(x, fr_size=frame_size, mean=mean, std=std), y),
             num_parallel_calls=AUTO) \
        .batch(batch_size) \
        .cache() \
        .prefetch(AUTO)

    test_dataset = test_dataset \
        .map(lambda x, y: (
        resize_and_rescale(x, fr_size=frame_size, mean=mean, std=std), y),
             num_parallel_calls=AUTO) \
        .batch(batch_size) \
        .cache() \
        .prefetch(AUTO)

    return train_dataset, validation_dataset, test_dataset, artwork_list


def train_evaluate_save(model, model_name: str, files_dir: Path,
                        dataset_csv_info_file: str, max_frames: int = 750,
                        img_normalization_params: Tuple[float, float] = (
                                0.0, 255.0), frame_size: int = 224,
                        batch_size: int = 128,
                        train_val_test_percentages: Tuple[int, int, int] = (
                                70, 20, 10),
                        epochs=20):
    """
    Consolidates model training and evaluation, as well as presentation of the
    results. Additionally, the trained model is saved to disk, both in its
    original form, as well as converted to the Tensorflow Lite format. All
    relevant information about the model (evaluation results, plots, other
    stats) are saved to disk as well.

    :param model: the model to be trained
    :param model_name: the preferred name for the model, used for naming the
     folder where the training results are saved
    :param files_dir: path of the directory containing the videos
    :param dataset_csv_info_file: name of csv file containing information about
     the videos, must be located in files_dir
    :param max_frames: total number of frames to extract for each artwork
    :param img_normalization_params: tuple of doubles (mean, standard_deviation)
     to use for normalizing the extracted frames, e.g. if (0.0, 255.0) is
     provided, the frames are normalized to the range [0, 1], see this comment
     for explanation of how to convert between the two
     https://stackoverflow.com/a/58096430
    :param frame_size: the size of the final resized square frames, this is
     dictated by the needs of the underlying NN used
    :param batch_size: batch size for datasets
    :param train_val_test_percentages: tuple specifying how to split the
     generated dataset into train, validation and test datasets, the provided
     ints must add up to 100
    :param epochs: the number of epochs to train the model
    """
    pd.options.display.float_format = '{:,.2f}'.format

    # folder to save info about model
    info_dir = base_dir / model_name / "model_info"
    info_dir.mkdir(parents=True, exist_ok=True)

    print("Generating/splitting dataset...", "\n", flush=True)
    train_dt, val_dt, test_dt, artwork_list = dataset_from_videos(
        files_dir=files_dir, max_frames=max_frames,
        dataset_csv_info_file=dataset_csv_info_file,
        batch_size=batch_size, frame_size=frame_size,
        train_val_test_percentages=train_val_test_percentages,
        img_normalization_params=img_normalization_params)

    print("Creating model...", "\n", flush=True)
    model = model(len(artwork_list))

    # saves model train history logs, which can be visualised with TensorBoard
    log_dir = base_dir / "logs/fit" / f"{model_name}_" \
                                      f"{datetime.now().strftime('%Y%m%d%H%M')}"
    tb_callback = tf.keras.callbacks.TensorBoard(log_dir=log_dir,
                                                 histogram_freq=1)

    # train model
    print("Training model...", "\n", flush=True)
    model_train_info = model.fit(train_dt, epochs=epochs,
                                 validation_data=val_dt,
                                 callbacks=[tb_callback])
    print("Finished training!", "\n", flush=True)

    # save trained model to disk, also convert to Tensorflow Lite format
    save_model(model, model_name, artwork_list)

    # evaluation
    evaluation = model.evaluate(test_dt)
    eval_res = pd.DataFrame.from_dict(
        {k: [v] for k, v in zip(["Test loss", "Test accuracy"], evaluation)})
    eval_res.to_csv(info_dir / "evaluation_results.csv", index=False)
    display_markdown("### Evaluation results", raw=True)
    display(eval_res)

    # model predictions
    predicted_labels = model.predict(test_dt)
    predicted_labels = np.argmax(predicted_labels, axis=1)

    actual_labels = np.concatenate([label for _, label in test_dt], axis=0)
    # labels are in categorical form (one_hot), convert them back
    actual_labels = np.argmax(actual_labels, axis=1)

    # classification report
    report = classification_report(actual_labels, predicted_labels,
                                   target_names=artwork_list, output_dict=True)
    report = pd.DataFrame(report)
    report.to_csv(info_dir / "classification_report.csv")
    display_markdown("### Classification report", raw=True)
    display(report)

    # plots
    display_markdown("### Training history plots & confusion matrix", raw=True)
    ep = np.array(model_train_info.epoch) + 1
    fig, axes = plt.subplots(3, 1, figsize=(5, 15))

    # training and validation accuracy plot
    axes[0].plot(ep, model_train_info.history['accuracy'], "bo",
                 label='Training accuracy')
    axes[0].plot(ep, model_train_info.history['val_accuracy'], "b",
                 label='Validation accuracy')
    axes[0].set_xlabel("Epochs")
    axes[0].set_ylabel("Training and validation accuracy")
    axes[0].set_title("Training and validation accuracy")
    axes[0].legend()
    axes[0].tick_params(axis='both', which='major')

    # training and validation loss plot
    axes[1].plot(ep, model_train_info.history['loss'], "bo",
                 label='Training loss', color="red")
    axes[1].plot(ep, model_train_info.history['val_loss'], "b",
                 label='Validation loss', color="red")
    axes[1].set_xlabel("Epochs")
    axes[1].set_ylabel("Training and validation loss")
    axes[1].set_title("Training and validation loss")
    axes[1].legend()
    axes[1].tick_params(axis='both', which='major')

    # confusion matrix
    cm = confusion_matrix(actual_labels, predicted_labels)
    df_cm = pd.DataFrame(cm, artwork_list, artwork_list)
    df_cm.to_csv(info_dir / "confusion_matrix.csv")
    sn.set(font_scale=.7)
    sn.heatmap(df_cm, ax=axes[2], vmin=0, annot=True, cmap="YlGnBu", fmt="d",
               linewidths=0.1, linecolor="black")

    # display and save plots to files
    fig.savefig(info_dir / "graphs.svg", bbox_inches="tight")
    fig.savefig(info_dir / "graphs.pdf", bbox_inches="tight")
    plt.show()

    # save training history
    with open(info_dir / "train_history.json", "w+") as f:
        json.dump(model_train_info.history, f, indent=4)

    # save a few other details about the model
    other_info = {
        "batch_size": batch_size,
        "epochs": epochs,
        "frame_size": frame_size,
        "img_normalization_params": img_normalization_params,
        "model_name": model_name,
        "train_val_test_percentages": train_val_test_percentages
    }
    with open(info_dir / "other_info.json", "w+") as f:
        json.dump(other_info, f, indent=4)


def save_model(trained_model, model_name: str, artwork_list: list):
    """
    Saves the provided model to disk, and also converts it to the Tensorflow
    Lite format.

    :param trained_model: the trained model
    :param model_name: name to be used when saving the model
    :param artwork_list: list containing the artwork ids sorted according to
     the model outputs
    """
    # save model
    print("Saving model to file...", flush=True)
    saved_model_path = base_dir / model_name / "saved_model"
    trained_model.save(saved_model_path)

    # Convert model to tflite
    # first convert to normal tflite
    converter = tf.lite.TFLiteConverter.from_saved_model(str(saved_model_path))
    tflite_model = converter.convert()

    # second convert to quantized tflite
    print("Converting to tflite format...", flush=True)
    converter.optimizations = [tf.lite.Optimize.DEFAULT]
    tflite_quant_model = converter.convert()

    tflite_dir = base_dir / model_name / "tflite"
    tflite_dir.mkdir(parents=True, exist_ok=True)

    with tf.io.gfile.GFile(str(tflite_dir / f"{model_name}.tflite"), "wb") as f:
        f.write(tflite_model)

    with tf.io.gfile.GFile(str(tflite_dir / f"{model_name}_quant.tflite"),
                           "wb") as f:
        f.write(tflite_quant_model)

    # save txt file with list of labels, ready for use in mobile device
    labels_file = tflite_dir / f"{model_name}_labels.txt"
    with open(labels_file, "w+") as f:
        for label in list(artwork_list):
            f.write(label + "\n")
    print("Done!", flush=True)


def remove_audio_from_videos(video_dir: Path, video_ext: str = ".mp4"):
    # for running in all files straight from cli
    # command = f'for file in {video_dir}; do ffmpeg -i "$file" -c:v copy
    # -an "$file_na.mp4"; done'
    for vid in video_dir.glob(f"*{video_ext}"):
        subprocess.call(
            f"ffmpeg -i {vid} -c:v copy "
            f"-an {Path(vid.parent / (vid.stem + '_na' + video_ext))}",
            shell=True)


@functools.lru_cache(maxsize=128)
def get_visitor_overlay():
    return Image.open(files_dir / "Xoio_people_0023.png")


def add_visitors(img, visitor_height: float):
    if type(img) is tf.python.framework.ops.EagerTensor:
        bg = Image.fromarray(img.numpy().copy().astype(np.uint8))
    elif type(img) is np.ndarray:
        bg = Image.fromarray(img.copy().astype(np.uint8))
    else:
        bg = img

    fg = get_visitor_overlay()
    # resize visitor image to a percentage of the provided img's height
    fg = fg.resize((int((bg.height / fg.height) * fg.width * visitor_height),
                    int(bg.height * visitor_height)))

    bg.paste(fg, (0, int(bg.height - fg.height)), fg.convert('RGBA'))

    return np.array(bg)


def vary_brightness(img, brightness_factor: float):
    assert brightness_factor >= 0, "brightness_factor should not be negative!"

    if type(img) is tf.python.framework.ops.EagerTensor:
        img = Image.fromarray(img.numpy().copy().astype(np.uint8))
    elif type(img) is np.ndarray:
        img = Image.fromarray(img.copy().astype(np.uint8))

    # adjust img brightness
    img_brightness_obj = ImageEnhance.Brightness(img)
    # here a factor of 1 returns the original image, 0 a black image
    img = img_brightness_obj.enhance(brightness_factor)

    return np.array(img)


if __name__ == '__main__':
    files_dir = Path("/home/marios/Downloads/contemporary_art_video_files")
    # processed = video_processing(files_dir)
    # with open(files_dir / "processed", "wb+") as f:
    #     pickle.dump(processed, f)
    # save_sample_frames(files_dir)
    # frame_counts(files_dir)
    # for v in get_video_files(files_dir / "not_artwork_videos"):
    #     print(v.name)
    # video_resolutions(files_dir)
    extract_video_frames(Path(
        "/home/marios/Downloads/contemporary_art_video_files/VID_20190523_140137.mp4"),
        resize=False, save_as_files=True, frame_limiter=10)
