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
          leading: Icon(Icons.home), // 좌측 상단에 아이콘 추가
          title: Text('플러터 앱 만들기'),
          backgroundColor: Colors.blue,
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
            width: 300,
            height: 300,
            child: Stack(
              children: List.generate(5, (index) {
                // 안쪽 가장 작은 박스부터 점점 커지도록 설정
                return Positioned(
                  left: 0.0,
                  top: 0.0,
                  child: Container(
                    width: 60.0 * (index + 1), // 크기를 점점 크게
                    height: 60.0 * (index + 1), // 크기를 점점 크게
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
