import pathlib
import sys

if __name__ == '__main__':
    for line in sys.stdin:
        filename, extensions_list = line.split(': ')
        extensions = extensions_list.strip().split('/')
        if not extensions:
            continue
        extension = extensions[0]
        fileobj = pathlib.Path(filename)
        if fileobj.suffix == extension:
            continue
        fileobj.rename(f"{fileobj.absolute()}.{extension}")

