import os
import xml.etree.ElementTree as ET
from optparse import OptionParser
from pathlib import Path

import requests


def save_vlc_timestamp(clip_type: str):
    """
    Requests status information from VLC for current video, and saves timestamp information for later splitting of
    the video. This script was used to mark the positions of required clips from the testing videos, which was later
    used to automatically divide them in the desired clips with Ffmpeg.

    :param clip_type: the type of the clip the current timestamp refers to; in this case it should refer to Forward,
     Downward, Upward, Left, and Right with the corresponding letters [f, d, u, l, r]
    """
    if clip_type not in "fdulr":
        print("Clip type provided is not acceptable, should be one of [f, d, u, l, r]")
        raise SystemExit

    # TODO have dict with file-artwork name associations, so can append the artwork here

    # request to VLC
    r = requests.get("http://127.0.0.1:8080/requests/status.xml", auth=("", "abc"))
    # return status information is in xml form
    root = ET.fromstring(r.text)

    percent = root.find("position").text  # current position in percent
    length = root.find("length").text  # length of the video in seconds

    video_name = ""  # filename of current video
    for i in root.find("information"):
        if i.attrib == {'name': 'meta'}:
            video_name = i[0].text
            break
    if video_name == "":
        print("Couldn't get current video filename!")
        raise SystemExit

    info = [video_name, percent, length]

    cur_path = Path(os.path.realpath(__file__)).parent

    csv_path = cur_path / "positions.csv"
    if not csv_path.is_file():
        # create csv file and print header
        with open(csv_path, "a") as f:
            f.write("filename,start,end,artworkID,type\n")

    with open(csv_path, "a") as f:
        f.write(",".join(info) + "\n")
    # print(root[0].get("position"))
    # for i in root:
    #     print(i)
    print(os.path.realpath(__file__))


def main():
    parser = OptionParser()

    parser.add_option("-o",
                      dest="type",
                      help="Split or chunk size in bytes (approximate)",
                      type="choice",
                      action="store",
                      choices=["f", "d", "u", "l", "r"],
                      default="f"
                      )
    options, args = parser.parse_args()
    print(options)
    save_vlc_timestamp(options.type)
    # TODO just save times with one of the choices above, and then the lengths can be calculated by finding max and
    #  min of choice e.g. f


if __name__ == '__main__':
    main()
