import os
from subprocess import check_output
import re


def parent_dir(path):
    return os.path.split(path)[0]


def ordered_path():
    PATH = os.environ['PATH']

    newPATH = []
    for i in PATH.split(":"):
        if i not in newPATH:
            newPATH.append(i)

    return ':'.join(newPATH)


def hex2rgb(e):
    assert e.startswith("#")
    e = e.strip("#").lower()
    assert len(e) == 6
    for i in e:
        assert (i in "0123456789abcdef")

    def h2r(i):
        return str(eval('0x{}'.format(i)))

    r = e[0:2]
    g = e[2:4]
    b = e[4:6]

    return ", ".join([h2r(i) for i in (r, g, b)])


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

    return sh("rclone", "obscure", sh("_get-pass", pass_name))
