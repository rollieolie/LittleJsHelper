#!/usr/bin/python3

import requests,sys
from bs4 import BeautifulSoup


url = sys.argv[1]

r = requests.get(url)
soup = BeautifulSoup(r.content,'html.parser')
bob = soup.find_all('script')
for stuff in bob:
    if 'src' in stuff.attrs:
        try:
            bob = stuff.attrs['src']
            b = requests.get(bob)
            bobn = b.status_code
            if bobn == 200:
                print(bob)
            else:
                tom = url + bob
                print(tom)
        except requests.exceptions.MissingSchema:
            try:
                b = requests.get('https:'+bob)
                bobn = b.status_code
                if bobn == 200:
                    print(bob)
                else:
                    tom = url + bob
                    print(tom)
            except requests.exceptions.InvalidURL:
                tom = url + bob
                print(tom)
