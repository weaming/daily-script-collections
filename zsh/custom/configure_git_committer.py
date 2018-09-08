#!/usr/bin/env python3

import json
import os
import sys

config_path = '~/.dotfiles/git/committers.json'
config_path = os.path.expanduser(config_path)

example_config = [{
    "path": ["~/src/Personal", "~/go/src/github.com"],
    "name": "weaming",
    "email": "garden.yuen@gmail.com",
}]


def load_config():
    if os.path.isfile(config_path):
        with open(config_path) as f:
            cfg = json.load(f)
            return cfg
    else:
        print('{} do not exist'.format(config_path))
        sys.exit(1)


def write_example():
    config_dir = os.path.dirname(config_path)
    if not os.path.isdir(config_dir):
        os.makedirs(config_dir)

    with open(config_path, 'w') as f:
        f.write(json.dumps(example_config, indent=4))
        print('wrote {}'.format(config_path))


def print_all():
    cfg = load_config()
    print(json.dumps(cfg, indent=4))


def get_for_path(p):
    cfg = load_config()
    key = args[0] if len(args) else None
    for x in cfg:
        for x_path in x['path']:
            current = os.path.abspath(p)
            x_path_abs = os.path.abspath(os.path.expanduser(x_path))
            # print(current, x_path_abs)
            if current.startswith(x_path_abs):
                return x[key] if key else '<{}> {}'.format(
                    x['name'], x['email'])
    sys.exit(1)


def print_for_path(p):
    print(get_for_path(p))


def print_for_workdir():
    p = os.getcwd()
    print_for_path(p)


commands = {
    'all': print_all,
    'workdir': print_for_workdir,
    'write_example': write_example,
}

if __name__ == "__main__":
    if len(sys.argv) <= 1:
        print('missing command, avaliable {}'.format(list(commands)))
        sys.exit(1)

    args = sys.argv[1:]
    command, args = args[0], args[1:]

    commands[command]()
