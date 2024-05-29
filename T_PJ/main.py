# main.py
from Character import *
from battle import gen_monster, battle

monster_info = {'고블린':1, '오크':2, '오거':3}
#num_of_monster = len(monster_info)
user_name = input('플레이어의 이름: ')
stage_step = 1

with Player(user_name) as p:
  for monster_name, level in monster_info.items():
    print('\n\n<<', stage_step,'번째 스테이지 시작>>')
    for generated_monster in gen_monster(monster_name, level):
      try   : battle(p, generated_monster)
      except: break
    if p.is_alive():
      print('\n\n<<', stage_step,'번째 스테이지 종료>>')
      stage_step += 1
      continue
    else:
      print(user_name, '이 사망했습니다.\n\n')
      break
