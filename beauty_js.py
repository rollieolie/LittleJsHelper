#!/usr/bin/python3

import requests,sys
from bs4 import BeautifulSoup


url = sys.argv[1]

r = requests.get(url)
soup = BeautifulSoup(r.content,'html.parser')
bob = soup.find_all('script')
for stuff in bob:
    if 'src' in stuff.attrs:
        bob = stuff.attrs['src']
        print(bob)
