from pathlib import Path

import skvideo.io

video_files_dir = "/home/marios/Downloads/contemporary_art_video_files"


def get_video_files():
    return Path(video_files_dir).glob("*.mp4")


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
        metadata = skvideo.io.ffprobe(str(f))
        # print(json.dumps(metadata, indent=4))
        for tags in metadata["video"]["tag"]:
            # we get OrderedDicts here
            if tags["@key"] == "rotate":
                print(tags['@value'])
        if count == 0: break
        # print(json.dumps(metadata["video"]["tag"][0], indent=4))


if __name__ == '__main__':
    video_processing()
