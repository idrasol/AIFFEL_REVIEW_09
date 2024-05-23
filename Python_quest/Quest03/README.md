# AIFFEL Campus Code Peer Review Templete
- 코더 : 신승우 님
- 리뷰어 : 이준오


# PRT(Peer Review Template)
- [x]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
- 문제에서 요구하는 기능이 정상적으로 작동하는지?
    - 네, 모두 정상적으로 잘 작동하며 추가적으로 작업한 내용도 잘 동작합니다.

* 문제 1. 최댓값과 최솟값 찾기
```python
def find_min_max(numbers):
    # min_value와 max_value 변수를 초기화
    # min_value는 양의 무한대(float('inf'))로 초기화하여 어떤 숫자보다도 큰 값으로 설정
    min_value = float('inf')
    # max_value는 음의 무한대(float('-inf'))로 초기화하여 어떤 숫자보다도 작은 값으로 설정
    max_value = float('-inf')

    def update_min_max(num):
        # 외부함수의 변수인 min_value, max_value 참조
        nonlocal min_value, max_value

        # 만약 num 값이 min_value보다 작다면 min_value를 num 값으로 변경
        if num < min_value :
            min_value = num

        # 만약 num 값이 max_value보다 크다면 max_value를 num 값으로 변경
        if num > max_value:
            max_value = num


    # numbers 리스트의 모든 값을 순환하며 최댓값과 최솟값 업데이트
    for num in numbers:
        update_min_max(num)

    # 최솟값을 반환하는 내부함수
    def get_min():
        return min_value

    # 최댓값을 반환하는 내부함수
    def get_max():
        return max_value

    # 외부함수는 내부함수(get_min()과 get_max())를 반환
    # 튜플형식으로 반환해야 추루 find_min, find_max와 일치시킬 수 있음
    return get_min, get_max

numbers = [10, 5, 8, 12, 3, 7]
find_min, find_max = find_min_max(numbers)

print("최솟값:", find_min())  # 3
print("최댓값:", find_max())  # 12
```

* 문제 2. 함수의 호출 횟수를 세는 데코레이터
```python
def counter(fn):            # 함수를 매개변수로 하는 counter함수(decorator) 생성
    count = 0               # count 변수 초기화
    def deco_counter():
        nonlocal count      # nonlocal 키워드를 사용하여 바깥 함수의 count 변수에 접근하기, 이를 통해 deco_counter()은 클로저 함수가 됨
        fn()                # 매개변수로 주어진 함수를 시행
        count += 1          # 클로저 함수는 이전의 값을 누적하여 기억함
        print(f"{fn.__name__} 실행횟수 : {count}")  # 실행 횟수 출력
    return deco_counter     # 데코레이터 함수를 반환

@counter                    # say_hello 함수를 시행할 때마다 counter 데코레이터가 작동하도록 적용
def say_hello():
    print("Hello Aiffel!")

for i in range(5):
    say_hello()             # say_hello 함수를 5번 호출
```
    
- [x]  **2. 핵심적이거나 복잡하고 이해하기 어려운 부분에 작성된 설명을 보고 해당 코드가 잘 이해되었나요?**
- 해당 코드 블럭에 doc string/annotation/markdown이 달려 있는지 확인
- 해당 코드가 무슨 기능을 하는지, 왜 그렇게 짜여진건지, 작동 메커니즘이 뭔지 기술.
- 주석을 보고 코드 이해가 잘 되었는지 확인
    - 네, 주석을 보고 코드가 잘 이해가 되었습니다.
```python
def counter(fn):            # 함수를 매개변수로 하는 counter함수(decorator) 생성
    count = 0               # count 변수 초기화
    def deco_counter():
        nonlocal count      # nonlocal 키워드를 사용하여 바깥 함수의 count 변수에 접근하기, 이를 통해 deco_counter()은 클로저 함수가 됨
        fn()                # 매개변수로 주어진 함수를 시행
        count += 1          # 클로저 함수는 이전의 값을 누적하여 기억함
        print(f"{fn.__name__} 실행횟수 : {count}")  # 실행 횟수 출력
    return deco_counter     # 데코레이터 함수를 반환

@counter                    # say_hello 함수를 시행할 때마다 counter 데코레이터가 작동하도록 적용
def say_hello():
    print("Hello Aiffel!")

for i in range(5):
    say_hello()             # say_hello 함수를 5번 호출
```
        
- [x]  **3. 에러가 난 부분을 디버깅하여 “문제를 해결한 기록”을 남겼나요? 또는 “새로운 시도 및 추가 실험”을 해봤나요?**
- 문제 원인 및 해결 과정을 잘 기록하였는지 확인
- 문제에서 요구하는 조건에 더해 추가적으로 수행한 나만의 시도, 실험이 기록되어 있는지 확인
    - 네, 회고 부분에서 자세히 잘 작성해주셨습니다. 다른 방법을 시도하셨고 코드도 첨부가 되어있습니다.
```python
# -- 같은 방법인데 @쓰지않고 적용시킨것 --

def counter(fn):
    count = 0
    def deco_counter():
        fn()
        nonlocal count
        count += 1
        print(f"{fn.__name__} 실행횟수 : {count}")
    return deco_counter

def say_hello():
    print("Hello Aiffel!")

deco_say_hello = counter(say_hello)

for i in range(5):
    deco_say_hello()

```

        
- [x]  **4. 회고를 잘 작성했나요?**
- 프로젝트 결과물에 대해 배운점과 아쉬운점, 느낀점 등이 상세히 기록 되어 있나요?
	- 네, 작성된 회고를 통해 작업 과정에서 어떤 고민이 있었고 어떻게 해결했는지 잘 기록되어있습니다.
```
## 회고
퍼실님이 제공해주신 주석 덕분에 첫번째 코드의 짜임을 어떻게 해야할 지 생각하는 단계를 생략하고 따라서 코드를 짜면 되어서 한결 수월했던 것 같습니다.

처음엔 함수의 return 값을

return min_value      
return max_value 
로 작성하였다가 에러가 나서 확인해보니 제공해주신 결괏값 출력 코드가
find_min, find_max = find_min_max(numbers) 즉, 튜플이여서 함수의 return 값을

return min_value, max_value 
로 튜플형식으로 수정하였습니다

@decorator의 원리가 조금 헷갈려서 사용하지 않은 버젼도 같이 만들어보니 @decorator가 붙은 함수는 매번 함수가 실행될 때마다 자동으로 데코레이터가 적용되어 훨씬 편하게 적용시킬 수 있다는 것을 배웠습니다.

힌트에 '함수.__name__으로 함수의 이름을 불러올 수 있다'고 되어있어 이게 왜있을까? 하고 봤더니 코드를 함수 이름 자체를 string으로
print(f"say_hello 실행횟수 : {count}") 라고 생각없이 짜 놓은것을 확인하였고, 수정하였습니다

데코레이터에서 매개변수 fn을 통해서 들어온 say_hello() 함수 인자를 중첩함수 deco_counter() 함수 안에서 다시 fn()을 통해서 시행을 해야한다는 점을 맨처음에는 이해하지 못했는데, 페어와 함께 논의하면서 이해를 하게되었습니다. @로 데코레이터를 사용하는경우 이어서 정의하는 함수는 자체적으로 시행되지 않고, 데코레이터의 대상이 되는 counter() 함수 안에서 호출해야지만 시행된다는 점입니다. 따라서 데코레이터를 사용할 경우에는 추후에 say_hello() 처럼 꾸며주는 함수?의 시행을 요구하는 코드를 데코레이터 함수에 선언하는 작업을 해야한다는 점입니다.
```
        
- [x]  **5. 코드가 간결하고 효율적인가요?**
- 파이썬 스타일 가이드 (PEP8)를 준수하였는지 확인
- 코드 중복을 최소화하고 범용적으로 사용할 수 있도록 모듈화(함수화) 했는지
    - 추가 시도를 하신 부분에서도 잘 작성하셨습니다.


# 참고 링크 및 코드 개선
```
# 코드 리뷰 시 참고한 링크가 있다면 링크와 간략한 설명을 첨부합니다.
# 코드 리뷰를 통해 개선한 코드가 있다면 코드와 간략한 설명을 첨부합니다.
```


