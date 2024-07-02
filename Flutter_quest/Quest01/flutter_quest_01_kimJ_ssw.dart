import 'dart:async';

class PomodoroTimer {
  final int workDuration = 25 * 60; // 25 minutes in seconds
  final int shortBreakDuration = 5 * 60; // 5 minutes in seconds
  final int longBreakDuration = 15 * 60; // 15 minutes in seconds
  final int cyclesBeforeLongBreak = 4;

  int _currentCycle = 0;
  bool _isWorking = true;
  Timer? _timer;
  int _secondsRemaining = 0;

  void start() {
    _startWork();
  }

  void _startWork() {
    _isWorking = true;
    _secondsRemaining = workDuration;
    _startTimer();
  }

  void _startShortBreak() {
    _isWorking = false;
    _secondsRemaining = shortBreakDuration;
    _startTimer();
  }

  void _startLongBreak() {
    _isWorking = false;
    _secondsRemaining = longBreakDuration;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        _printTime();
      } else {
        _timer?.cancel();
        if (_isWorking) {
          _currentCycle++;
          if (_currentCycle % cyclesBeforeLongBreak == 0) {
            _startLongBreak();
          } else {
            _startShortBreak();
          }
        } else {
          _startWork();
        }
      }
    });
  }

  void _printTime() {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
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
