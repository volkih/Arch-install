import requests


CITY = "INSERT_YOUR_CITY"
API_KEY = "INSERT_YOUR_API_KEY"
UNITS = "Metric"
UNIT_KEY = "C"


try:
    REQ = requests.get("http://api.openweathermap.org/data/2.5/weather?id={}&appid={}&units={}".format(CITY,API_KEY,UNITS))
    if REQ.status_code == 200:
        # CURRENT = REQ.json()["weather"][0]['description'].capitalize()
        TEMP = round(REQ.json()["main"]["temp"],1)
        print(" {} °{}".format(TEMP, UNIT_KEY))
    else:
        print("Error: BAD HTTPS STATUS CODE")
except(ValueError,IOError, ConnectionError):
    print("Error: Unable print the data")
