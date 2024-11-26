import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,  // 조정민님이 이야기 해준 debug 띠 없애는 코드
    home: HomeScreen(),
  ));
}

// HomeScreen 홈(메인) 화면
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('계산 퀴즈', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(context, '퀴즈 풀기', QuizScreen()),
            SizedBox(height: 50),
            _buildButton(context, '랭킹 보기', LankScreen()),
          ],
        ),
      ),
    );
  }

  // 버튼 형식
  ElevatedButton _buildButton(BuildContext context, String text, Widget screen) {
    return ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 120, 207, 123),
        minimumSize: Size(200, 75),
      ),
      child: Text(text, style: TextStyle(fontSize: 20)),
    );
  }
}

// QuizScreen 불러오기
class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentScore = 0;      // 정답을 맞춘 수
  int _questionCount = 0;     // 문제 나온 횟수
  late int _num1;
  late int _num2;
  late String _operator;      // 계산식 부분 (사칙연산)
  late double _correctAnswer; // 나누셈을 위해 실수로 받음
  List<Map<String, dynamic>> _questions = []; // 문제와 제출한 답안을 저장하는 리스트

  final Random _random = Random();
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _generateQuestion();  // 호출시 문제로 나올 자료를 호출해 문제 작성
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  // 문제 자료
  void _generateQuestion() {
    _num1 = _random.nextInt(10) + 1;  // 1 ~ 10까지의 수 중 랜덤으로
    _num2 = _random.nextInt(10) + 1;  // 원래는 100을 넣어서 1 ~ 100 사이였지만 빠른 확인을 위해 10으로 낮춤
    int op = _random.nextInt(4);      // 사칙연산도 랜덤으로 나오게 함

    switch (op) {
      case 0:
        _operator = '+';
        _correctAnswer = _num1 + _num2.toDouble();  // 실수형으로 형변환
        break;
      case 1:
        _operator = '-';
        _correctAnswer = _num1 - _num2.toDouble();  // 실수형으로 형변환
        break;
      case 2:
        _operator = '*';
        _correctAnswer = _num1 * _num2.toDouble();  // 실수형으로 형변환
        break;
      case 3:
        _operator = '/';
        _num2 = _num2 == 0 ? 1 : _num2;
        _correctAnswer = (_num1 / _num2 * 100).round() / 100; // 소수점 둘째 자리 반올림
        break;
    }
  }

  // 답안 제출 부분
  void _submitAnswer() {
    double answer = double.tryParse(_answerController.text) ?? 0.0;
    if (answer == _correctAnswer) {
      _currentScore += 1;
    }

    _questions.add({
      'num1': _num1,
      'operator': _operator,
      'num2': _num2,
      'correctAnswer': _correctAnswer,
      'submittedAnswer': answer,
    });

    setState(() {
      _questionCount += 1;
      _answerController.clear();
      if (_questionCount < 5) {
        _generateQuestion();
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              score: _currentScore,
              questions: _questions,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퀴즈 풀기', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Center(
        child: _questionCount < 5
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '문제 ${_questionCount + 1}/5',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    '나누기는 소수점 셋째 자리에서 반올림 하세요.',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '$_num1 $_operator $_num2 = ?',
                    style: TextStyle(fontSize: 28),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextField(
                      controller: _answerController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '정답 입력',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitAnswer,
                    child: Text('제출'),
                  ),
                ],
              )
            : Center(
                child: Text(
                  '문제가 끝났습니다!\n총 점수: $_currentScore',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),
      ),
    );
  }
}

// ResultScreen 결과 창
class ResultScreen extends StatelessWidget {
  final int score;
  final List<Map<String, dynamic>> questions;

  ResultScreen({required this.score, required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퀴즈 결과'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '문제가 끝났습니다!',
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(height: 20),
            Text(
              '총 맞춘 정답 수: $score',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return ListTile(
                    title: Text(  // 이번에 나온 문제, 정답, 제출된 답안을 확인
                      '${question['num1']} ${question['operator']} ${question['num2']} = ${question['correctAnswer']}',
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      '제출한 답안: ${question['submittedAnswer']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: Text('홈 화면'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LankScreen()),
                    );
                  },
                  child: Text('랭킹 화면'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// LankScreen 랭킹 화면 미구현 상태
class LankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(  // 홈 화면으로 가기
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
        title: Text('랭킹 보기', textAlign: TextAlign.center),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
          '랭킹 화면입니다!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
/*
  처음과 달리 추가 및 삭제된 점:
    문제가 나와 답안을 작성하는 부분이 카카오톡 체팅마냥 하나씩 눈에 보이는 형식으로 쌓여가는 방향이였지만 문제 하나하나 보이고 마지막에 팝업창으로 결과창이 떴었음.
   그결과 정확히 어느 부분에서 틀렸는지 이해가 어렵게 됬음 > 팝업창이 아닌 따로 페이지를 추가해서 만듬
    결과창 페이지에서는 문제 맞춘 횟수(점수)와 나온 문제들, 해당 문제의 정답, 해당 문제에 제출한 답안이 보이도록 설계됨

  기능 추가해야 되는 점:
   - 랭킹 보기 말고 랭킹 등록하기 페이지가 따로 존재해야할 듯 함
   - 랭킹 등록하기로 가면 score 값을 받아와서 해당 유저의 이름을 입력해 서버에 올리는 형식
   - 다른 사람과 실시간으로 붙는 기능도 재밌을 것이라 생각함

  회고:
    - 시간이 이틀이 아닌 하루 안에 만들어 보느라 약간 급하게 만든감이 많았고, 원래 추가하고 싶었던 기능도 있으나 못만들어본게 아쉽다.
    - 막상 만들어보니 ai기능을 어느 부분에 투입해야 할지 바로 떠올리지 못 하겠다.
*/