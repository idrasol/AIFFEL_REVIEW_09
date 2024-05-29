# Character.py

from abc import ABCMeta, abstractmethod
from random import randint


class CharacterBase(metaclass = ABCMeta):
  """
     Character Class 기본 요구 사항

  """

  @abstractmethod
  def __str__(self): pass

  @abstractmethod
  def is_alive(self): pass

  @abstractmethod
  def take_damage(self, damage): pass  # 본인의 방어력이 데메지보다 크면 체력 감소 없음    
  
  @abstractmethod              # 데미지는 1부터 공격력 사이의 랜덤한 정수
  def attack_target(self): pass




class Character(CharacterBase):
  
  # 캐릭터 속성 초기화
  def __init__(self, name, level = 1, strength = 0, aggressive = 0, defensive = 0, ):
    self.name       = name              # 캐릭터명
    self.level      = level             # 레벨
    self.strength   = strength          # 체력
    self.aggressive = aggressive        # 공격력
    self.defensive  = defensive         # 방어력


  def __repr__(self):
    return (f'{self.__class__}, {self.name}: 레벨 {self.level}, 체력: {self.strength}, 공격력 {self.aggressive}, 방어력 {self.defensive}\n')


  def __str__(self):
    return (f'{self.name}: 레벨 {self.level}, 체력: {self.strength}, 공격력 {self.aggressive}, 방어력 {self.defensive}')

  
  def is_alive(self):
    if self.strength > 0: return True
    else                : return False


  def take_damage(self, damage):   # 본인의 방어력이 데메지보다 크면 체력 감소 없음
    if self.defensive > damage:
      return 0
    else:
      self.strength -= (damage - self.defensive)
      if self.strength <= 0: self.strength = 0
      return damage - self.defensive
  

  def attack_target(self, enemy):  # 데미지는 1부터 공격력 사이의 랜덤한 정수
    return enemy.take_damage(randint(1, self.aggressive))




class Player(Character):
    def __init__(self, name):
      super(Player, self).__init__(name, level = 1, strength = 100, aggressive = 25, defensive = 5)
      self.exp = 0


    def __enter__(self):
      print(f'환영합니다. {self.name}!')
      return self


    def __exit__(self, exc_type, exc_val, exc_tb):
      print(f'\n\n{self.name}, 플레이 해주셔서 감사합니다.!')


    def gain_experience(self):
      match self.level:
        case 1: self.exp += 50; print('경험치를 50만큼 얻었습니다.\n')
        case 2: self.exp += 20; print('경험치를 20만큼 얻었습니다.\n')
        case 3: self.exp += 10; print('경험치를 10만큼 얻었습니다.\n')
        case _: self.exp += 5 ; print('경험치를 5만큼 얻었습니다.\n') 
        
      self.level_up()
      
      
    def level_up(self):
      if self.exp >= 50:
        self.level      += 1
        self.strength    = 100 * self.level
        self.aggressive += 10
        self.defensive   = 5
        self.exp = 0
          
        print('\n                  **레벨업!**\n')
        print(self)
        print('\n')




class Monster(Character):   # Character 클래스 상속
  #monsters     = []       # 몬스터 정보 리스트
  # monster_nums = len(monsters)
  def __init__(self, name, level):
    super(Monster, self).__init__(name ,
                                  level,
                                  strength = randint(1, 10) * level,
                                  aggressive = randint(1, 10) * level,
                                  defensive  = randint(1, 10) * level)


