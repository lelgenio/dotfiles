import os
from subprocess import check_output
import re


def parent_dir(path):
    return os.path.split(path)[0]


def rclone_obscure(pass_name):
    try:
        fPath = os.path.expanduser("~/.config/rclone/rclone.conf")
        t = open(fPath, 'r').read()

        PASSWORD_PATTERN = r'^pass *= *(.*)$'
        password = re.search(PASSWORD_PATTERN, t, re.M).group(1)
        return password
    except Exception:
        pass

    def sh(*args):
        return check_output(args).decode().strip()

    return sh("rclone", "obscure", sh("_pass_get", pass_name))


def var(to_escape: str):
    return " ".join(["{{@@", to_escape, "@@}}"])


def non_templated(path):
    with open(path, "r") as f:
        res = []
        in_dotdrop = False
        for line in f:
            line = line.strip()
            if line == "##### Dotdrop-start #####":
                in_dotdrop = True
            if line == "##### Dotdrop-end #####":
                in_dotdrop = False
            if not in_dotdrop:
                res.append(line)
    return "\n".join(res)


####################################################################
# color
####################################################################

def split_hex(e):
    e = e.lstrip("#").lower()
    return e[0:2], e[2:4], e[4:6]


def hex2rgb(e):
    return ", ".join([str(int(s, base=16))
                      for s in split_hex(e)])


def color_mult(e: str, amount: float):
    """\
    Multiply e hex rgb colorCode with amount number
    Usefull for lightening/darkening
    """

    def segment(s):
        base256 = int(s, base=16)
        result_val = base256 * amount

        # normalize between 0 and 255
        result_val = min(255, max(0, result_val))

        hex_result = hex(int(result_val))[2:]

        return hex_result.zfill(2)

    prefix = "#" * e.startswith("#")
    return prefix + "".join(map(segment, split_hex(e)))


####################################################################
# Filters
####################################################################

def darker(arg1, amount=0.5):
    return color_mult(arg1, amount)


def lighter(arg1, amount=1.25):
    return color_mult(arg1, amount)


def as_hex(in_number):
    return hex(int(in_number))[2:]


def clamp_to_hex(in_number):
    return as_hex(in_number * 255)
