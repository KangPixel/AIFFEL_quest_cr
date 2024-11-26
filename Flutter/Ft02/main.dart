import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.home), // 좌측 상단에 아이콘 추가 (홈 화면이여서 'home'아이콘으로 넣어 봄)
          title: Text('플러터 앱 만들기'),
          centerTitle: true,
          backgroundColor: Colors.blue, // appbar 색상을 'blue'로 지정
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              print("버튼이 눌렸습니다"); // 버튼 클릭 시 DEBUG CONSOLE에 출력
            },
            child: Text('Text'),
          ),
          SizedBox(height: 20), // 여백 추가
          Container(
            width: 300, // 가장 밖은 300, 300
            height: 300,
            child: Stack(
              children: List.generate(5, (index) {
                // 안쪽 가장 작은 박스부터 점점 커지도록 설정
                return Positioned(
                  left: 0.0,  // 왼쪽 위부터
                  top: 0.0,
                  child: Container(
                    width: 60.0 * (index + 1), // 크기를 점점 크게 60씩
                    height: 60.0 * (index + 1),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
/*
  회고
  누군가와 얘기없이 해보니 생각이 안날 때 막막해지는 시간이 좀 더 길어진 듯 했다.
  쳇 GPT를 이용하여 막히는 부분을 뚫어두고 코드의 어느 부분이 수정 되었고 왜 작동하는 지 알아보는 시간이 되었다.
*/