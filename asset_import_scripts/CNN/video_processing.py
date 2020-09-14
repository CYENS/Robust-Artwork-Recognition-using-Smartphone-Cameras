from pathlib import Path

import cv2
import skvideo.io

video_files_dir = "/home/marios/Downloads/contemporary_art_video_files"


def get_video_files(video_dir: str):
    """  Gets paths of video files at provided directory.

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


def extract_video_frames(video_path: str):
    count = 0
    vidcap = cv2.VideoCapture(video_path)
    success, image = vidcap.read()
    while success:
        # cv2.imwrite("s.jpg", image)
        success, image = vidcap.read()
        count += 1
    return count


def video_processing():
    # count = 0
    # for f in get_video_files():
    #     rotation = get_video_rotation(str(f))
    #     print(rotation, type(rotation))
    #     # if count == 0: break
    print(sum(extract_video_frames(str(v)) for v in get_video_files()))


if __name__ == '__main__':
    video_processing()
