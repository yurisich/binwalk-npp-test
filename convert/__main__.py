import json
import pathlib
import sys

from google import genai

def generate_prompt(filename):
    file_bytes_as_text = pathlib.Path(filename).read_bytes()
    return f"""
I was given a very old document that I can't open. I was able to use binwalk to extract out some special formatted text that came from the original document. Try to convert it into markdown matching what the original looked like.

The output of your response is directly saved to the filesystem using pathlib's `.write_text()` function. Do not include any other output in your response other than the contents of the converted text requested. Thank you.

The file contents are listed below this line:
{file_bytes_as_text}
"""

if __name__ == '__main__':
    client = genai.Client(api_key=pathlib.Path(".gemini-api.key").read_text())
    for line in sys.stdin:
        zlib_file = pathlib.Path(line)
        print(zlib_file)
        raw_file = pathlib.Path(zlib_file.parent / zlib_file.stem)
        response = client.models.generate_content(
            model="gemini-2.0-flash", contents=generate_prompt(raw_file)
        )
        try:
            pathlib.Path(f"logs_{raw_file.stem}.txt").write_text(response.text)
        except:
            continue
        pathlib.Path(f"{raw_file}.md").write_text(response.text)
