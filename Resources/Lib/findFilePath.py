import os


def get_file_path():
    cpath = os.getcwd()
    return os.path.abspath(os.path.join(cpath, '..//..'))
