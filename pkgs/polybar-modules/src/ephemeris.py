import ephem
from datetime import datetime

sun = ephem.Sun()

me = ephem.Observer()
# Christchurch, New Zealand
me.lat = "-43.525650"
me.lon = "172.639847"
# Set date to midnight
now = ephem.Date(datetime.utcnow())
me.date = now
me.date = me.previous_antitransit(sun)

# Compute important times of day
me.horizon = '-18'
dawn = me.next_rising(sun, use_center=True)
dusk = me.next_setting(sun, use_center=True)
me.horizon = '0'
sunrise = me.next_rising(sun)
noon = me.next_transit(sun)
sunset = me.next_setting(sun)

def time_of_day():
    me.date = now
    me.horizon = '-18'
    if now < dawn:
        previous_dusk = me.previous_setting(sun, use_center=True)
        return "🌌", (now - previous_dusk) / (dawn - previous_dusk)
    elif now < sunrise:
        return "🌄", (now - dawn) / (sunrise - dawn)
    elif now < sunset:
        return "🌞", (now - sunrise) / (sunset - sunrise)
    elif now < dusk:
        return "🌅", (now - sunset) / (dusk - sunset)
    else:
        next_dawn = me.next_rising(sun, use_center=True)
        return "🌌", (now - dusk) / (next_dawn - dusk)
