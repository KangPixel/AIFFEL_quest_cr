import 'dart:async';

void main() {
  PomodoroTimer pomodoro = PomodoroTimer();
  pomodoro.start();
}

class PomodoroTimer {
  // static const int workDuration = 25 * 60; // 25 분 -> 초
  static const int workDuration = 5;

  // static const int shortBreakDuration = 5 * 60; // 5 분 -> 초
  static const int shortBreakDuration = 2;

  // static const int longBreakDuration = 15 * 60; // 15 분 -> 초
  static const int longBreakDuration = 3;

  int currentTime = workDuration;
  int pomodoroCount = 0;
  bool isWorking = true; // 일 하는 시간 체크
  Timer? timer;

  void start() {
    print('flutter: Pomodoro 타이머를 시작합니다.');
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (currentTime > 0) {
        currentTime--;
        printTime();
      } else {
        if (isWorking) {
          pomodoroCount++;
          if (pomodoroCount % 4 == 0) {
            // 4 회차엔 15분 휴식 
            print('flutter: 작업시간이 종료되었습니다. 휴식 시간을 시작합니다. 좀 길게 쉬어볼 까요?(15분)');
            currentTime = longBreakDuration;
          } else {
            // 5분 휴식
            print('flutter: 작업시간이 종료되었습니다. 휴식 시간을 시작합니다.');
            currentTime = shortBreakDuration;
          }
        } else {
          print('flutter: 휴식 시간이 종료되었습니다. 작업 시간을 시작합니다.');
          currentTime = workDuration;
        }
        isWorking = !isWorking;
      }
    });
  }

  void printTime() {
    int minutes = currentTime ~/ 60;
    int seconds = currentTime % 60;
    String formattedTime = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    print(isWorking ? 'flutter: 작업 시간:  $formattedTime' : 'flutter: 휴식 시간: $formattedTime');  // 작업 시간과 휴식시간을 알아보기 편하게 따로 체크
  }
}


/* 1초 간격으로 반복되는 타이머 생성
  Timer.periodic(const Duration(seconds: 1), (t) {
    // 현재 시간을 출력
    print("Current time: ${DateTime.now()}");
    if (Random().nextInt(10) > 7) {
      print("Randomlly Delayed");
      for (var i = 0; i < 10000000000; ++i) {}
    }
  });*/
/*
  기본기를 가지고 만들 수는 있었지만.....
  구조를 만드는 부분에서 머리가 멈추다 못해 하얘졌고
  이 부분은 어떻게 활용할 수 있는 것인가 의문도 많아지는 하루였습니다...
*/
