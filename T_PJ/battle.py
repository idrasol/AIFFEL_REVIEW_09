from random import randint
from Character import *

def gen_monster(monster_name, level):
  for i in range(randint(1, 3)):
    yield Monster(monster_name, level)


def battle(player, monster):
  BROKEN_LINE = '-' * 52

  print('\n\n')
  print('             <<전투가 시작되었습니다>>\n')
  print('********************[현재상태]********************')
  print(player)
  print(monster)
  print('*************************************************\n\n')

  while True:
    print(BROKEN_LINE)
    print(f'{player.name}  {monster.name}에게 {player.aggressive} 데미지의 공격')
    print(f'{monster.name}  {player.attack_target(monster)}만큼의 데미지를 입었다. {monster.name}의 남은 체력: {monster.strength}')
    print(BROKEN_LINE)
    print('\n')
    
    if monster.is_alive(): pass
    else:
      player.gain_experience()
      print('!!!!!!!!!!!!!!!!!!!전투 승리!!!!!!!!!!!!!!!!!!!')
      break

    print(BROKEN_LINE)
    print(f'{monster.name}  {player.name}에게 {monster.aggressive} 데미지의 공격')
    print(f'{player.name}  {monster.attack_target(player)}만큼의 데미지를 입었다. {player.name}의 남은 체력: {player.strength}')
    print(BROKEN_LINE)
    print('\n')

    if player.is_alive(): pass
    else:
      player.gain_experience()
      print('전투 패배...')
      print(BROKEN_LINE)
      break




