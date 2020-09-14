import json
from pathlib import Path

import skvideo.io


def video_processing():
    video_path = Path("/home/marios/Downloads/VID_20190523_135937.mp4")
    count = 0
    # vidcap = cv2.VideoCapture(str(video_path))
    # success, image = vidcap.read()
    # while success:
    #     # cv2.imwrite("s.jpg", image)
    #     success, image = vidcap.read()
    #     print(count)
    #     count += 1
    metadata = skvideo.io.ffprobe(str(video_path))
    print(json.dumps(metadata["video"]["tag"], indent=4))


if __name__ == '__main__':
    video_processing()
