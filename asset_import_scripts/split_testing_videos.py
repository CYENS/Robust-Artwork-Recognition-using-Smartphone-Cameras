import os
import subprocess
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
        notify("Clip type provided is not acceptable, should be one of [f, d, u, l, r]")
        raise SystemExit

    # TODO have dict with file-artwork name associations, so can append the artwork here

    # request to VLC
    r = requests.get("http://127.0.0.1:8080/requests/status.xml", auth=("", "abc"))
    if r.status_code != 200:
        notify(f"Problem requesting information from VLC, status code: {r.status_code}")
        raise SystemExit

    # return status information is in xml form
    root = ET.fromstring(r.text)

    video_name = ""  # filename of current video
    for i in root.find("information"):
        if i.attrib == {"name": "meta"}:
            video_name = i[0].text
            break
    if video_name == "":
        notify("Couldn't get current video filename!")
        raise SystemExit

    percent = root.find("position").text  # current position as a percentage
    vid_length = root.find("length").text  # length of the video in seconds
    timestamp = str(int(vid_length) * float(percent))

    info = [video_name, timestamp, percent, vid_length, clip_type]

    # resulting csv will be saved in the same folder as this script
    csv_path = get_script_path() / "positions.csv"
    if not csv_path.is_file():
        # create csv file and print header
        with open(csv_path, "a") as f:
            f.write("filename,timestamp,percent,vid_length,clip_type\n")

    with open(csv_path, "a") as f:
        f.write(",".join(info) + "\n")

    notify(f"Saved {round(float(timestamp), 2)} timestamp for {clip_type}-{video_name}")


def get_script_path():
    return Path(os.path.realpath(__file__)).parent


def change_current(option: str):
    if option not in ["distance", "artwork"]:
        raise SystemExit

    f_name = get_script_path() / f"{option}.txt"

    with open(f_name, "a+") as f:
        # increment file by one character, does not matter which
        f.write("0")
    notify(f"Current {option}: {get_current(option)}")


def get_current(option: str):
    distances = ["1m", "1.5m", "2.5m"]
    artworkIDs = ["2-3_sfikas", "armament_phinikarides", "ascent_ladommatos", "autumn_chrysochos", "crucified_savvides",
                  "game_of_shapes_chrysochos", "ground_plan_hadjida", "no_artwork", "presence_votsis",
                  "secession_bargilly", "the_cyclist_votsis", "the_great_greek_encyclopaedia_makrides",
                  "the_observer_kyriakou", "throne_ii_chrysochos", "untitled_hadjida", "untitled_kouroussis",
                  "untitled_votsis"]

    f_name = get_script_path() / f"{option}.txt"

    with open(f_name, "r") as f:
        current = f.read()
        if option == "distance":
            return distances[len(current) % len(distances)]
        elif option == "artwork":
            return artworkIDs[len(current) % len(artworkIDs)]


def notify(msg: str):
    subprocess.Popen(['notify-send', msg])


def main():
    parser = OptionParser()
    parser.add_option("-t",
                      dest="type",
                      help="Type of video clip the timestamp to be saved refers to; if artwork or distance is "
                           "specified, the corresponding variable is incremented.",
                      type="choice",
                      action="store",
                      choices=["f", "d", "u", "l", "r", "artwork", "distance"],
                      default="f"
                      )

    options, args = parser.parse_args()
    notify(options.type)
    if options.type in "fdulr":
        save_vlc_timestamp(options.type)
    elif options.type in ["artwork", "distance"]:
        change_current(options.type)


if __name__ == '__main__':
    main()
