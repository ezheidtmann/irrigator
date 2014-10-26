import csv
from datetime import datetime

params = {
    'roof_area': 500, # flat equivalent, square feet
    'irrigation_area': 80, # square feet
    'weekly_irrigation_depth': 1, # inches of water to apply to irrigated area
}

# initialize mary poppins rain barrel
stored = 0
class RainBarrel():
    def __init__(self, max_volume):
        self.max_volume = max_volume

    def add(self, volume):
        self.stored += volume
        self.stored = min(self.stored, self.max_volume)

    def drain(self, volume):
        if self.stored > volume:
            self.stored -= volume
            return volume
        else:
            return self.stored


#barrel = RainBarrel(params['storage_volume'])

# initialize inches of rain in the soil
soil_moisture = 1

streak_volume = 0
streak_net_drain = 0
max_streak_net_drain = 0

with open("US1ORMT0033.PRCP.csv", 'rb') as csvfile:
    reader = csv.reader(csvfile)
    for row in reader:
        date = datetime.strptime(row[1], "%Y%m%d")
        # precipitation data is in tenths of a millimeter
        inchesprecip = float(row[3]) / 254.0

        # fill up infinite storage device with rainwater
        stored += inchesprecip * params['roof_area']

        # stupid soil moisture model. drains 1/7th of an inch of water
        # every day; charges up only to 1 by rain
        soil_moisture -= 1/7.0
        soil_moisture = min(inchesprecip + soil_moisture, 1);

        # When do we recharge by irrigation? always!
        if soil_moisture < 1:
            topup_vertical = 1 - soil_moisture
            topup_volume = topup_vertical * params['irrigation_area'];
            stored -= topup_volume
            soil_moisture = 1
            print row[1] + " irrigated: " + str(topup_vertical)

            streak_volume += topup_volume
            streak_net_drain += topup_volume - (inchesprecip * params['roof_area'])
        else:
            print row[1] + " Last streak: " + str(streak_volume)
            print row[1] + " Streak net drain gallons: " + str(streak_net_drain * 0.623376623)
            max_streak_net_drain = max(max_streak_net_drain, streak_net_drain)
            streak_volume = 0
            streak_net_drain = 0

        print row[1] + " Stored: " + str(stored)



print "Minimum capacity to meet max need: " + str(max_streak_net_drain * 0.623376623) + " gallons"


