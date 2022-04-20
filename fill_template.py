#!/bin/python

import yaml
import sys
from jinja2 import Environment, FileSystemLoader

if __name__ == "__main__":
    if (len(sys.argv) < 3):
        print("Usage: ./%s FILE DEVICE\n  FILE: path to jinja2 file\n  DEVICE: arch | think\n" %(sys.argv[0]))
        sys.exit(1)

    yaml_file = open('./_profiles/' + sys.argv[2] + '.yaml')
    yaml_vars = yaml.safe_load(yaml_file)

    env = Environment(loader = FileSystemLoader('./'), trim_blocks=True, lstrip_blocks=True)
    template = env.get_template(sys.argv[1])

    print(template.render(yaml_vars))

    yaml_file.close()
