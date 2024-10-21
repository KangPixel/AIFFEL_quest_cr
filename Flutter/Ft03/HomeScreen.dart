// HomeScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_10_18/ch14_1_navigation/DetailScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // FontAwesome 추가

class HomeScreen extends StatelessWidget {
  bool is_cat = true;

  HomeScreen({required this.is_cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
        leading: Icon(FontAwesomeIcons.cat),  // Icons에 고양이 아이콘이 없어서 가져옴
        centerTitle: true,  // Title을 중앙으로
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(is_cat: false),
                  ),
                );
              },
              child: Text('Next'), // 다음 화면으로 이동하는 버튼
            ),
            Image.asset(
              'images/cat.jpg', // 고양이 이미지
              width: 300,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}