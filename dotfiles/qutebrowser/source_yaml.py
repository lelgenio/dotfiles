#!/bin/env python
# {{@@ header() @@}}
#   ___        _       _
#  / _ \ _   _| |_ ___| |__  _ __ _____      _____  ___ _ __
# | | | | | | | __/ _ \ '_ \| '__/ _ \ \ /\ / / __|/ _ \ '__|
# | |_| | |_| | ||  __/ |_) | | | (_) \ V  V /\__ \  __/ |
#  \__\_\\__,_|\__\___|_.__/|_|  \___/ \_/\_/ |___/\___|_|


import yaml

from qutebrowser.config.configfiles import ConfigAPI   # type: ignore


def dict_attrs(obj, path=''):
    if isinstance(obj, dict):
        for k, v in obj.items():
            yield from dict_attrs(v, '{}.{}'.format(path, k) if path else k)
    else:
        yield path, obj


def source_yaml(config: ConfigAPI, filename: str):

    with (config.configdir / filename).open() as f:
        yaml_data = yaml.safe_load(f)

    for k, v in dict_attrs(yaml_data):
        config.set(k, v)
