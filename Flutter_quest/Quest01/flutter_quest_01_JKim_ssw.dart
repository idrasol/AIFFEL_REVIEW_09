// 회고: 신승우, 기능별로 함수를 선언하여서 중복 작업에 대해서 효율적인 코드를 작성해보는 시간을 가질 수 있었다. 또한, duration 클래스의 기능을 사용해보는 기회를 가졌다.

import 'dart:async';

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
    print('작업 시간이 종료되었습니다. 휴식 시간을 시작합니다.'); // 최초에는 startTimer() 함수 if 문 안에서 메시지를 띄웠는데, 2번씩 반복해서 메시지가 출력되어서 startTimer() 함수 호출 전에 메시지 출력하는 것으로 해결함
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