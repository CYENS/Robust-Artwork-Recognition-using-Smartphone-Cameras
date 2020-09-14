from pathlib import Path

import cv2
import numpy as np
import pandas as pd
import skvideo.io

video_files_dir = "/home/marios/Downloads/contemporary_art_video_files"


def get_video_files(video_dir: str):
    """ Gets paths of video files at provided directory.

    :param video_dir: path of dir with video files
    :return: generator of Paths
    """
    return Path(video_dir).glob("*.mp4")


def get_video_rotation(video_path: str):
    """ Reads video rotation from video metadata.

    :param video_path: path to the video file
    :return: rotation of video in int degrees (e.g. 90, 180)
    :raises AssertionError if rotation is not available, files doesn't exist, or file doesn't have metadata
    """
    metadata = skvideo.io.ffprobe(video_path)
    for tags in metadata["video"]["tag"]:
        # we get OrderedDicts here
        if tags["@key"] == "rotate":
            return int(tags['@value'])
    else:
        raise AssertionError(f"Couldn't get rotation for {video_path}, either file doesn't exist, does not contain "
                             f"metadata, or rotation is not included in its metadata.")


def extract_video_frames(video_path: Path, save_as_files: bool = False):
    """ Extracts all frames from the provided video, and optionally saves them as individual images in a directory with
    the same name as the video.

    :param video_path: path to the video file
    :param save_as_files: whether to save extracted frames as individual image files
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
    except AssertionError as e:
        print(e)

    count = 0

    vidcap = cv2.VideoCapture(str(video_path))
    success, frame = vidcap.read()

    all_frames = []

    while success:
        if video_rotation != 0:
            frame = rotate_frame(frame, video_rotation)

        frame = resize(frame)

        if save_as_files:
            cv2.imwrite(str(frame_dest / f"{video_path.stem}_{count}.jpg"), frame)

        all_frames.append(np.copy(frame))

        success, frame = vidcap.read()
        count += 1

    print(f"Extracted {count} frames from video {video_path.name}")

    return all_frames


def rotate_frame(frame: np.ndarray, degrees: int):
    if degrees == 90:
        return cv2.rotate(frame, cv2.ROTATE_90_CLOCKWISE)
    elif degrees == 180:
        return cv2.rotate(frame, cv2.ROTATE_180)
    elif degrees == 270:
        return cv2.rotate(frame, cv2.ROTATE_90_COUNTERCLOCKWISE)
    else:
        return frame


def resize(frame: np.ndarray, target_dim: int = 224):
    return cv2.resize(frame, (target_dim, target_dim), interpolation=cv2.INTER_AREA)


def video_processing():
    count = 0
    for f in get_video_files(video_files_dir):
        extract_video_frames(f)
        if count == 0:
            break
    # print(sum(extract_video_frames(str(v)) for v in get_video_files()))


if __name__ == '__main__':
    video_processing()
