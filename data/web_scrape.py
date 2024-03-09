from bs4 import BeautifulSoup
import time
import requests
import csv
import sys
import pandas as pd
import re


def read_players_data(file_path):
   players_data = []
   with open(file_path, 'r') as file:
      reader = csv.reader(file)
      next(reader)
      for row in reader:
         players_data.append(row)
   return players_data

players_data = read_players_data(sys.argv[1])

def generate_player_urls(player_data):
    first_name = player_data[1].lower()
    last_name = player_data[2].lower()
    last_name_first_5 = last_name[:5]
    first_name_first_2 = first_name[:2]
    player_url = f'https://www.footballdb.com/players/{last_name}-{first_name}-{last_name_first_5}{first_name_first_2}01'
    return player_url

url_replacements = {
   "https://www.footballdb.com/players/stroud-c.j.-strouc.01": "https://www.footballdb.com/players/cj-stroud-stroucj01",
   "https://www.footballdb.com/players/carr-derek-carrde01" : "https://www.footballdb.com/players/derek-carr-carrde03",
   "https://www.footballdb.com/players/o'connell-aidan-o'conai01" : "https://www.footballdb.com/players/aidan-oconnell-oconnai01",
   "https://www.footballdb.com/players/conner-james-conneja01" : "",
   "https://www.footballdb.com/players/mixson-joe-mixsojo01" : "https://www.footballdb.com/players/joe-mixon-mixonjo01",
   "https://www.footballdb.com/players/dobbins-j.k.-dobbij.01" : "https://www.footballdb.com/players/jk-dobbins-dobbijk01",
   "https://www.footballdb.com/players/brown-a.j.-browna.01" : "https://www.footballdb.com/players/aj-brown-brownaj01",
   "https://www.footballdb.com/players/chark-d.j.-charkd.01" : "https://www.footballdb.com/players/dj-chark-charkdj01",
   "https://www.footballdb.com/players/hockenson-t.j.-hocket.01" : "https://www.footballdb.com/players/tj-hockenson-hocketj01",
   "https://www.footballdb.com/players/uzomah-c.j.-uzomac.01" : "https://www.footballdb.com/players/cj-uzomah-uzomacj01",
   "https://www.footballdb.com/players/o'neill-brian-o'neibr01" : "",
   "https://www.footballdb.com/players/motom-taylor-motomta01" : "https://www.footballdb.com/players/taylor-moton-motonta01",
   "https://www.footballdb.com/players/robinson-cam-robinca01" : "https://www.footballdb.com/players/cam-robinson-robinca04",
   "https://www.footballdb.com/players/watt-j.j.-wattj.01" : "https://www.footballdb.com/players/jj-watt-wattjj01",
   "https://www.footballdb.com/players/mosley-c.j.-moslec.01" : " https://www.footballdb.com/players/mosley-cj-moslecj01",
   "https://www.footballdb.com/players/watt-t.j.-wattt.01" : "https://www.footballdb.com/players/watt-tj-watttj01",
   "https://www.footballdb.com/players/walker-anthony-walkean01" : "https://www.footballdb.com/players/anthony-walker-walkean02",
   "https://www.footballdb.com/players/peterson-patrick-peterpa01" : "https://www.footballdb.com/players/patrick-peterson-peterpa02",
   "https://www.footballdb.com/players/terrell-a.j.-terrea.01" : "https://www.footballdb.com/players/aj-terrell-terreaj01",
   "https://www.footballdb.com/players/davious white-tre-daviotr01" : "",
   "https://www.footballdb.com/players/jackson-j.c.-jacksj.01" : "https://www.footballdb.com/players/jc-jackson-jacksjc01",
   "https://www.footballdb.com/players/peters-marcus-peterma01" : "https://www.footballdb.com/players/marcus-peters-peterma02",
   "https://www.footballdb.com/players/bouye-a.j.-bouyea.01" : "https://www.footballdb.com/players/bouye-aj-bouyeaj01",
   "https://www.footballdb.com/players/dinwiddie-dandre-dinwida01" : "",
   "https://www.footballdb.com/players/coleman-justin-colemju01" : "https://www.footballdb.com/players/justin-coleman-colemju02",
   "https://www.footballdb.com/players/abram-johnathan-abramjo01" : "https://www.footballdb.com/players/johnathan-abram-abramjo02",
   "https://www.footballdb.com/players/scott-j.k.-scottj.01" : "https://www.footballdb.com/players/jk-scott-scottjk01",
   "https://www.footballdb.com/players/cole iii-a.j.-cole a.01" : "https://www.footballdb.com/players/aj-cole-coleaj01",
   "https://www.footballdb.com/players/lovelato-rick-lovelri01" : "",
   "https://www.footballdb.com/players/ogrady-cheyenne-ogradch01" : "",
   "https://www.footballdb.com/players/jansen-j.j.-jansej.01" : "https://www.footballdb.com/players/jansen-jj-jansejj01",
   "https://www.footballdb.com/players/allen-josh-allenjo01" : "https://www.footballdb.com/players/josh-allen-allenjo06",
   "https://www.footballdb.com/players/love-jordan-lovejo01" : "https://www.footballdb.com/players/jordan-love-lovejo03",
   "https://www.footballdb.com/players/jackson-lamar-jacksla01" : "https://www.footballdb.com/players/lamar-jackson-jacksla06",
   "https://www.footballdb.com/players/smith-geno-smithge01" : "https://www.footballdb.com/players/geno-smith-smithge04", 
   "https://www.footballdb.com/players/young-bryce-youngbr01" : "https://www.footballdb.com/players/bryce-young-youngbr06",
   "https://www.footballdb.com/players/burrow-joe-burrojo01" : "https://www.footballdb.com/players/joe-burrow-burrojo02",
   "https://www.footballdb.com/players/wilson-zach-wilsoza01" : "https://www.footballdb.com/players/zach-wilson-wilsoza02",
   "https://www.footballdb.com/players/jones-mac-jonesma01" : "",
   "https://www.footballdb.com/players/taylor-tyrod-tayloty01" : "https://www.footballdb.com/players/tyrod-taylor-tayloty02",
   "https://www.footballdb.com/players/gibson-antonio-gibsoan01" : "https://www.footballdb.com/players/antonio-gibson-gibsoan02"
}

player_urls = [generate_player_urls(player) for player in players_data]

urls = [url_replacements.get(url, url) for url in player_urls]



def get_table_row(url):
   headers = {
      "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36"
   }
   response = requests.get(url, headers=headers)
   time.sleep(.2) # Be kind to the server

   if response.status_code != 200 or response.history:
      print(f"Failed to access {url}")
   
   soup = BeautifulSoup(response.text, 'html.parser')

   table_rows = soup.find_all('tr', class_='header right row_playerstats row_pro')
   passing_row = table_rows[0] if len(table_rows) > 0 else None
   rushing_row = table_rows[3] if len(table_rows) > 3 else None
   receiving_row = table_rows[6] if len(table_rows) > 6 else None


   passing_data = [td.text for td in passing_row.find_all('td')]
   passing_df = pd.DataFrame([passing_data], columns=['Year', 'Team', 'League', 'G', 'GS', 'Att', 'Cmp', 'Pct', 'Yds', 'YPA', 'YPG', 'TD', 'T%', 'Int', 'I%', 'Lg', 'FD', '20+', 'Sack', 'Loss', 'Rate'])

   rushing_data = [td.text for td in rushing_row.find_all('td')]
   rushing_df = pd.DataFrame([rushing_data], columns=['Year', 'Team', 'League', 'G', 'GS', 'Att', 'Yds', 'Avg', 'YPG', 'Lg', 'TD', 'FD', '10+'])
   
   #;recieving_data = [td.text for td in receiving_row.find_all('td')]
   #;recieving_df = pd.DataFrame([recieving_data], columns=['Year', 'Team', 'League', 'G', 'GS', 'Rec', 'Yds', 'Avg', 'YPG', 'Lg', 'TD', 'FD', '20+', 'Tar', 'YAC'])


   #;print(recieving_df)
   match = re.search(r'players/(.*)-', url)
   if match:
      player_name = match.group(1).replace('-', ' ')
   else:
      player_name = "Unknown"

   df = pd.concat([passing_df, rushing_df], axis=1)
   df = df.loc[:,~df.columns.duplicated()]
   df['Player'] = player_name
   df.drop(columns=['Year', 'Team', 'League'], inplace=True)
   # print(df)

   return df


# url = "https://www.footballdb.com/players/cj-stroud-stroucj01"
all_data = pd.DataFrame()

for url in urls:
   if url != "":
      table_row = get_table_row(url)
      all_data = all_data.append(table_row, ignore_index=True)

print(all_data)
all_data.to_csv('QB_stats.csv', index=False)



