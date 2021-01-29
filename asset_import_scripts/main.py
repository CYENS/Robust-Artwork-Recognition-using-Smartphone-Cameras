import json
import re
from pathlib import Path

import requests

import constants


def get_json(sheet_number):
    url = "https://spreadsheets.google.com/feeds/list/" + \
          constants.GSHEET_URL_CODE + "/" + \
          str(sheet_number) + "/public/values?alt=json"
    return requests.get(url)


def get_json_assets():
    """
    Gets artwork and artist information from the Google sheet that contains the
    information. The information is saved as a JSON file in the app's asset
    folder, and is used to populated the app's database during first launch.
    The script processes the downloaded JSON file and removes personal
    information before saving it.
    """
    json_types, sheet_numbers = ["artworks", "artists"], [6, 7]

    for json_type, sheet_number in zip(json_types, sheet_numbers):
        gsheet_json = get_json(sheet_number)

        print(gsheet_json.text)

        # remove links to spreadsheet and personal information (email)
        pattern = re.compile(r'https://.+?\.google\.com/.+?\"|\"ms.+?ma@*')

        for i in re.findall(pattern, gsheet_json.text):
            print(i)

        sanitized_json = re.sub(pattern, repl='"', string=gsheet_json.text)
        sanitized_json = json.loads(sanitized_json)

        fpath = Path.cwd().parent / "assets" / "data" / f"{json_type}.json"

        with open(fpath, "w+") as f:
            json.dump(sanitized_json, f)


if __name__ == '__main__':
    get_json_assets()
