#!/usr/bin/env python3

import os
import re
import shutil

from optparse import OptionParser
from pathlib import Path

def read_tool_versions():
    tuples = []
    with open(os.path.expanduser('~/.tool-versions')) as f:
        for line in f.readlines():
            splited = re.split('\s+', line.strip())
            for v in splited[1:]:
                tuples.append((splited[0], v))
    return tuples

def main():
    parser = OptionParser()
    parser.add_option('-f', '--force', help='Purge', action='store_true')
    (options, _args) = parser.parse_args()

    tuples = read_tool_versions()
    reserved_plugins = set(t[0] for t in tuples)
    for plugin_dir in Path(os.path.expanduser('~/.asdf/installs')).iterdir():
        plugin = os.path.basename(plugin_dir)
        if plugin not in reserved_plugins:
            print('- {}'.format(plugin_dir))
            if options.force:
                shutil.rmtree(plugin_dir)
        else:
            for version_dir in Path(plugin_dir).iterdir():
                version = os.path.basename(version_dir)
                if (plugin, version) not in tuples:
                    print('- {}'.format(version_dir))
                    if options.force:
                        shutil.rmtree(version_dir)


if __name__ == '__main__':
    main()
