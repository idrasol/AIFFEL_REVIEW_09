#Flutter Quest01
# AIFFEL Campus Code Peer Review
- 코더 : 신승우
- 리뷰어 : 서은재


# PRT(Peer Review Template)
- [o]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
    - 문제에서 요구하는 기능이 정상적으로 작동하는지? 정상적으로 작동합니다~
        - 해당 조건을 만족하는 부분의 코드 및 결과물을 근거로 첨부
```
class PomodoroTimer {
  final int workDuration = 25 * 60; // 초단위가 기본이어서 60을 곱해서 분으로 셋팅
  final int shortBreakDuration = 5 * 60; // 짧은 휴식
  final int longBreakDuration = 15 * 60; // 긴 휴식
  final int cyclesBeforeLongBreak = 4; // 4번째 사이클에서는 15분 휴식을 하도록 함

  int _currentCycle = 0; // 사이클 횟수 계산해주는 변수
  bool _isWorking = true; 
  Timer? _timer;
  int _secondsRemaining = 0;

  void start() {
    _startWork();
  }

  void _startWork() {
    _isWorking = true;
    _secondsRemaining = workDuration; // 작업 시간을 타이머에 넣어줌
    print('Pomodoro 타이머를 시작합니다.');
    _startTimer();
  }

  void _startShortBreak() {
    _isWorking = false;
    _secondsRemaining = shortBreakDuration; // 짧은 휴식 시간을 타이머에 넣어줌
    print('작업 시간이 종료되었습니다. 휴식 시간을 시작합니다.');
    _startTimer();
  }

  void _startLongBreak() {
    _isWorking = false;
    _secondsRemaining = longBreakDuration; // 긴 휴식 시간을 타이머에 넣어줌
    print('작업 시간이 종료되었습니다. 휴식 시간을 시작합니다.');
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) { // Duration 모듈, 1초마다 실행
      if (_secondsRemaining > 0) { // 남은 시간이 0 이상이면 계속 경과 시간 프린트
        _secondsRemaining--;
        _printTime(); // 프린트타임 함수로 출력
      } else {
        _timer?.cancel(); // 남은 시간이 0이 되면, 타이머 중단, 사이클 카운팅 실행
        if (_isWorking) {
          _currentCycle++;
          if (_currentCycle % cyclesBeforeLongBreak == 0) { // 4번째 사이클이면 긴 휴식 작동
            _startLongBreak();
          } else {
            _startShortBreak(); // 그 외에는 짧은 휴식 작동
          }
        } else {
          _startWork(); // 휴식이 끝나면 다시 작업 시작
        }
      }
    });
  }

  void _printTime() {
    int minutes = _secondsRemaining ~/ 60; // 남은 시간을 60으로 나눠서 소수점을 버리고 정수로 출력
    int seconds = _secondsRemaining % 60; // 남은 시간을 60으로 나눠서 나머지만 출력
    print('${_isWorking ? "Work" : "Break"} Time: $minutes:${seconds.toString().padLeft(2, '0')}');
  }

  void stop() {
    _timer?.cancel();
    print("Timer stopped.");
  }
}

void main() {
  PomodoroTimer pomodoroTimer = PomodoroTimer();
  pomodoroTimer.start();
}
```

- [o]  **2. 핵심적이거나 복잡하고 이해하기 어려운 부분에 작성된 설명을 보고 해당 코드가 잘 이해되었나요?**
    - 해당 코드 블럭에 doc string/annotation/markdown이 달려 있는지 확인
    - 해당 코드가 무슨 기능을 하는지, 왜 그렇게 짜여진건지, 작동 메커니즘이 뭔지 기술.
    - 주석을 보고 코드 이해가 잘 되었는지 확인 : 주석에 코드에 대한 설명이 잘 적혀있어 이해가 잘됩니다~
        - 잘 작성되었다고 생각되는 부분을 근거로 첨부합니다.
```
_timer = Timer.periodic(const Duration(seconds: 1), (timer) { // Duration 모듈, 1초마다 실행
      if (_secondsRemaining > 0) { // 남은 시간이 0 이상이면 계속 경과 시간 프린트
        _secondsRemaining--;
        _printTime(); // 프린트타임 함수로 출력
      } else {
        _timer?.cancel(); // 남은 시간이 0이 되면, 타이머 중단, 사이클 카운팅 실행
```
        
- [o]  **3. 에러가 난 부분을 디버깅하여 “문제를 해결한 기록”을 남겼나요? 또는
   “새로운 시도 및 추가 실험”을 해봤나요?**
    - 문제 원인 및 해결 과정을 잘 기록하였는지 확인 또는
    - 문제에서 요구하는 조건에 더해 추가적으로 수행한 나만의 시도, 실험이 기록되어 있는지 확인 : 기록되어 있습니다!
        - 잘 작성되었다고 생각되는 부분을 근거로 첨부합니다.
```
  void _startShortBreak() {
    _isWorking = false;
    _secondsRemaining = shortBreakDuration; // 짧은 휴식 시간을 타이머에 넣어줌
    print('작업 시간이 종료되었습니다. 휴식 시간을 시작합니다.'); // 최초에는 startTimer() 함수 if 문 안에서 메시지를 띄웠는데, 2번씩 반복해서 메시지가 출력되어서 startTimer() 함수 호출 전에 메시지 출력하는 것으로 해결함
    _startTimer();
  }
```
        
- [o]  **4. 회고를 잘 작성했나요?**
    - 프로젝트 결과물에 대해 배운점과 아쉬운점, 느낀점 등이 상세히 기록 되어 있나요? 잘 작성되어 있습니다.
```
// 회고: 신승우, 기능별로 함수를 선언하여서 중복 작업에 대해서 효율적인 코드를 작성해보는 시간을 가질 수 있었다. 또한, duration 클래스의 기능을 사용해보는 기회를 가졌다.
```

- [o]  **5. 코드가 간결하고 효율적인가요?**
    - 코드 중복을 최소화하고 범용적으로 사용할 수 있도록 모듈화(함수화) 했는지
        - 잘 작성되었다고 생각되는 부분을 근거로 첨부합니다. 기능별로 함수를 간결하게 구현했습니다.
```
 void _startWork() {
    _isWorking = true;
    _secondsRemaining = workDuration; // 작업 시간을 타이머에 넣어줌
    print('Pomodoro 타이머를 시작합니다.');
    _startTimer();
  }

  void _startShortBreak() {
    _isWorking = false;
    _secondsRemaining = shortBreakDuration; // 짧은 휴식 시간을 타이머에 넣어줌
    print('작업 시간이 종료되었습니다. 휴식 시간을 시작합니다.');
    _startTimer();
  }

  void _startLongBreak() {
    _isWorking = false;
    _secondsRemaining = longBreakDuration; // 긴 휴식 시간을 타이머에 넣어줌
    print('작업 시간이 종료되었습니다. 휴식 시간을 시작합니다.');
    _startTimer();
```

# 참고 링크 및 코드 개선
```
# 코드 리뷰 시 참고한 링크가 있다면 링크와 간략한 설명을 첨부합니다.
# 코드 리뷰를 통해 개선한 코드가 있다면 코드와 간략한 설명을 첨부합니다.
```
