#!/usr/bin/env python3

import time
import sys
import os
import datetime

from common import *

dismissed_path = os.path.join(polybar_config, 'reminder-dismissed')

reminders_path = os.path.join(polybar_config, 'reminders')
if not os.path.exists(reminders_path):
    with open(reminders_path, 'x') as f:
        pass

f = open(os.path.join(polybar_config, 'reminders')).read()

if f.strip() == '':
    sys.exit()

current_date = datetime.datetime.now() - datetime.timedelta(hours=6)
if len(sys.argv) > 1 and sys.argv[1] == 'dismiss':
    f = open(dismissed_path, 'w')
    f.write(current_date.strftime('%Y-%m-%d'))
    f.close()

if os.path.exists(dismissed_path) and open(dismissed_path).read().strip() == current_date.strftime('%Y-%m-%d'):
    sys.exit(1)

good_colour = '%{F${colors.foreground}'
bad_colour = '%{F${colors.foreground-alt}'

now = datetime.datetime.now()
colour = [good_colour, bad_colour][now.hour >= 19]

print('%{T0}' + colour + f)
