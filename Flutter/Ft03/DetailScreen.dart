// DetailScreen.dart
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_10_18/ch14_1_navigation/HomeScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // FontAwesome 추가

class DetailScreen extends StatelessWidget {
  final bool is_cat;

  DetailScreen({required this.is_cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
        leading: Icon(FontAwesomeIcons.dog),  // Icons에 개 아이콘이 없어서 가져옴
        centerTitle: true,  // Title을 중앙으로
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: (){
                // Navigator.popUntil(context, (route) => false); // 생성된 stack 삭제

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(is_cat: true),
                  ),
                );
              },
              child: Text('Back'),  // 이전 화면으로 이돌하는 버튼
            ),
            Image.asset(
              'images/dog.jpg', // 개 이미지
              width: 300,
              height: 300,
            ),
            IconButton( // 버튼 형식으로 시도 >> 사이즈 조절 실패
              onPressed: (){
                print(is_cat);  // 누를 시 is_cat 출력
              },
              icon: Image.asset(
                'images/dog.jpg',
                width: 300,
                height: 300,
              ),
            )
          ],
        ),
      ),
    );
  }
}