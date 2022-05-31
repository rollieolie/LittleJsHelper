#!/usr/bin/python3

import requests,sys
try:
    url = sys.argv[1]
    r = requests.get(url, allow_redirects=True)
    if r.status_code == '403':
        print(' Sorry but ' + url + ' does not have status code of 200')
    else:
        print(r.text)

except KeyboardInterrupt:
    quit()
