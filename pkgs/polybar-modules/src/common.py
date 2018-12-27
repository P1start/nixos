#!/usr/bin/env python3

import os

config = os.environ.get('XDG_CONFIG_HOME') or os.path.join(os.environ['HOME'], '.config')
polybar_config = os.path.join(config, 'polybar')

if not os.path.exists(config):
    os.mkdir(config)
if not os.path.exists(polybar_config):
    os.mkdir(polybar_config)
