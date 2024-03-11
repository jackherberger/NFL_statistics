from bs4 import BeautifulSoup
import time
import requests
import csv
import sys
import pandas as pd
import re
import numpy as np


def read_players_data(file_path):
   players_data = []
   with open(file_path, 'r') as file:
      reader = csv.reader(file)
      next(reader)
      for row in reader:
         players_data.append(row)
   return players_data


def generate_player_urls(player_data):
   first_name = player_data[1].lower().replace('.', '')
   last_name = player_data[2].lower().replace('.', '')
   last_name_first_5 = last_name[:5]
   first_name_first_2 = first_name[:2]
   player_url = f'https://www.footballdb.com/players/{last_name}-{first_name}-{last_name_first_5}{first_name_first_2}01'
   return player_url


def get_table_row(url, position):
   headers = {
      "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36"
   }
   response = requests.get(url, headers=headers)
   time.sleep(.2) # Be kind to the server

   if response.status_code != 200 or response.history:
      print(f"Failed to access {url}")
   
   soup = BeautifulSoup(response.text, 'html.parser')
   tables_names = soup.find_all('span', class_="hidden-xs hidden-sm")


   mt_pass = passing_df = pd.DataFrame([[np.nan]*21], columns=['Year', 'Team', 'League', 'G', 'GS', 'Pass_Att', 'Pass_Cmp', 'Pass_Pct', 'Pass_Yds', 'Pass_YPA', 'Pass_YPG', 'Pass_TD', 'Pass_T%', 'Pass_Int', 'Pass_I%', 'Pass_Lg', 'Pass_FD', 'Pass_20+', 'Sack', 'Loss', 'Rate'])
   mt_rush = rushing_df = pd.DataFrame([[np.nan]*13], columns=['Year', 'Team', 'League', 'G', 'GS', 'Rush_Att', 'Rush_Yds', 'Rush_Avg', 'Rush_YPG', 'Rush_Lg', 'Rush_TD', 'Rush_FD', 'Rec_10+'])
   mt_rec = recieving_df = pd.DataFrame([[np.nan]*15], columns=['Year', 'Team', 'League', 'G', 'GS', 'Rec', 'Rec_Yds', 'Rec_Avg', 'Rec_YPG', 'Rec_Lg', 'Rec_TD', 'Rec_FD', 'Rec_20+', 'Rec_Tar', 'Rec_YAC'])

   table_rows = soup.find_all('tr', class_='header right row_playerstats row_pro')

   for i in range(len(tables_names)):
      # print(tables_names[i].text)
      if tables_names[i].text == "Passing" or tables_names[i].text == "Pass":
         passing_row = table_rows[i * 3] if len(table_rows) > (i * 3) else None
         if passing_row:
            passing_data = [td.text for td in passing_row.find_all('td')]
            passing_df = pd.DataFrame([passing_data], columns=['Year', 'Team', 'League', 'G', 'GS', 'Pass_Att', 'Pass_Cmp', 'Pass_Pct', 'Pass_Yds', 'Pass_YPA', 'Pass_YPG', 'Pass_TD', 'Pass_T%', 'Pass_Int', 'Pass_I%', 'Pass_Lg', 'Pass_FD', 'Pass_20+', 'Sack', 'Loss', 'Rate'])

      
      elif tables_names[i].text == "Rushing" or tables_names[i].text == "Rush":
         rushing_row = table_rows[i * 3] if len(table_rows) > (i * 3) else None
         if rushing_row:
            rushing_data = [td.text for td in rushing_row.find_all('td')]
            rushing_df = pd.DataFrame([rushing_data],columns=['Year', 'Team', 'League', 'G', 'GS', 'Rush_Att', 'Rush_Yds', 'Rush_Avg', 'Rush_YPG', 'Rush_Lg', 'Rush_TD', 'Rush_FD', 'Rec_10+'])
      
         
      elif tables_names[i].text == "Receiving" or tables_names[i].text == "Rec":
         receiving_row = table_rows[i * 3] if len(table_rows) > (i * 3) else None
         if receiving_row:
            recieving_data = [td.text for td in receiving_row.find_all('td')]

            recieving_df = pd.DataFrame([recieving_data], columns=['Year', 'Team', 'League', 'G', 'GS', 'Rec', 'Rec_Yds', 'Rec_Avg', 'Rec_YPG', 'Rec_Lg', 'Rec_TD', 'Rec_FD', 'Rec_20+', 'Rec_Tar', 'Rec_YAC'])

  
   match = re.search(r'players/(.*)-', url)
   if match:
      player_name = match.group(1).replace('-', ' ')
   else:
      player_name = "Unknown"

   df = pd.concat([passing_df, rushing_df], axis=1)
   df = pd.concat([df, recieving_df], axis=1)

   df = df.loc[:,~df.columns.duplicated()]
   df['Player'] = player_name
   df.drop(columns=['Year', 'Team', 'League'], inplace=True)
   # print(df)


   return df




def main():

   url_replacements = {
      "https://www.footballdb.com/players/carr-derek-carrde01" : "https://www.footballdb.com/players/derek-carr-carrde03",
      "https://www.footballdb.com/players/o'connell-aidan-o'conai01" : "https://www.footballdb.com/players/aidan-oconnell-oconnai01",
      "https://www.footballdb.com/players/conner-james-conneja01" : "",
      "https://www.footballdb.com/players/mixson-joe-mixsojo01" : "https://www.footballdb.com/players/joe-mixon-mixonjo01",
      "https://www.footballdb.com/players/uzomah-c.j.-uzomac.01" : "https://www.footballdb.com/players/cj-uzomah-uzomacj01",
      "https://www.footballdb.com/players/o'neill-brian-o'neibr01" : "",
      "https://www.footballdb.com/players/motom-taylor-motomta01" : "https://www.footballdb.com/players/taylor-moton-motonta01",
      "https://www.footballdb.com/players/robinson-cam-robinca01" : "https://www.footballdb.com/players/cam-robinson-robinca04",
      "https://www.footballdb.com/players/walker-anthony-walkean01" : "https://www.footballdb.com/players/anthony-walker-walkean02",
      "https://www.footballdb.com/players/peterson-patrick-peterpa01" : "https://www.footballdb.com/players/patrick-peterson-peterpa02",
      "https://www.footballdb.com/players/davious white-tre-daviotr01" : "",
      "https://www.footballdb.com/players/jackson-j.c.-jacksj.01" : "https://www.footballdb.com/players/jc-jackson-jacksjc01",
      "https://www.footballdb.com/players/peters-marcus-peterma01" : "https://www.footballdb.com/players/marcus-peters-peterma02",
      "https://www.footballdb.com/players/dinwiddie-dandre-dinwida01" : "",
      "https://www.footballdb.com/players/coleman-justin-colemju01" : "https://www.footballdb.com/players/justin-coleman-colemju02",
      "https://www.footballdb.com/players/abram-johnathan-abramjo01" : "https://www.footballdb.com/players/johnathan-abram-abramjo02",
      "https://www.footballdb.com/players/scott-j.k.-scottj.01" : "https://www.footballdb.com/players/jk-scott-scottjk01",
      "https://www.footballdb.com/players/cole iii-a.j.-cole a.01" : "https://www.footballdb.com/players/aj-cole-coleaj01",
      "https://www.footballdb.com/players/lovelato-rick-lovelri01" : "",
      "https://www.footballdb.com/players/ogrady-cheyenne-ogradch01" : "",
      "https://www.footballdb.com/players/allen-josh-allenjo01" : "https://www.footballdb.com/players/josh-allen-allenjo06",
      "https://www.footballdb.com/players/love-jordan-lovejo01" : "https://www.footballdb.com/players/jordan-love-lovejo03",
      "https://www.footballdb.com/players/jackson-lamar-jacksla01" : "https://www.footballdb.com/players/lamar-jackson-jacksla06",
      "https://www.footballdb.com/players/smith-geno-smithge01" : "https://www.footballdb.com/players/geno-smith-smithge04", 
      "https://www.footballdb.com/players/young-bryce-youngbr01" : "https://www.footballdb.com/players/bryce-young-youngbr06",
      "https://www.footballdb.com/players/burrow-joe-burrojo01" : "https://www.footballdb.com/players/joe-burrow-burrojo02",
      "https://www.footballdb.com/players/wilson-zach-wilsoza01" : "https://www.footballdb.com/players/zach-wilson-wilsoza02",
      "https://www.footballdb.com/players/jones-mac-jonesma01" : "",
      "https://www.footballdb.com/players/taylor-tyrod-tayloty01" : "https://www.footballdb.com/players/tyrod-taylor-tayloty02",
      "https://www.footballdb.com/players/gibson-antonio-gibsoan01" : "https://www.footballdb.com/players/antonio-gibson-gibsoan02",
      "https://www.footballdb.com/players/harris-damien-harrida01": "https://www.footballdb.com/players/damien-harris-harrida11"
   }


   players_data = read_players_data(sys.argv[1])

   player_urls = [generate_player_urls(player) for player in players_data]
   urls = [url_replacements.get(url, url) for url in player_urls]
   positions = [player[-1] for player in players_data]
   # print(positions)
   all_data = pd.DataFrame()


   for i in range(len(urls)):
      if urls[i] != "":
         if urls[i] == "https://www.footballdb.com/players/hunter-danielle-hunteda01":
            break
         print(urls[i])
         table_row = get_table_row(urls[i], positions[i])
         all_data = all_data.append(table_row, ignore_index=True)

   print(all_data)
   all_data.to_csv('player_stats.csv', index=False)

if __name__ == "__main__":
   main()