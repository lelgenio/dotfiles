import os


def parent_dir(path):
    return os.path.split(path)[0]


def ordered_path():
    PATH = os.environ['PATH']

    newPATH = []
    for i in PATH.split(":"):
        if i not in newPATH:
            newPATH.append(i)

    return ':'.join(newPATH)
