from pathlib import Path

import skvideo.io

video_files_dir = "/home/marios/Downloads/contemporary_art_video_files"


def get_video_files():
    return Path(video_files_dir).glob("*.mp4")


def get_video_rotation(file_path: str):
    metadata = skvideo.io.ffprobe(file_path)
    for tags in metadata["video"]["tag"]:
        # we get OrderedDicts here
        if tags["@key"] == "rotate":
            return tags['@value']
    else:
        raise AssertionError(f"Couldn't get rotation for {file_path}, either file doesn't exist, does not contain "
                             f"metadata, or rotation is not included in its metadata.")


def video_processing():
    count = 0
    # vidcap = cv2.VideoCapture(str(video_path))
    # success, image = vidcap.read()
    # while success:
    #     # cv2.imwrite("s.jpg", image)
    #     success, image = vidcap.read()
    #     print(count)
    #     count += 1
    for f in get_video_files():
        rotation = get_video_rotation(str(f))
        print(rotation, type(rotation))
        if count == 0: break


if __name__ == '__main__':
    video_processing()
