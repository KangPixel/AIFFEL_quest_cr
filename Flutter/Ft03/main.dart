import 'package:flutter/material.dart';
import 'package:flutter_10_18/ch14_1_navigation/HomeScreen.dart';
import 'package:flutter_10_18/ch14_1_navigation/DetailScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(is_cat: true),
    );
  }
}

/*
  이미지를 아이콘 버튼을 사용하려다가 실패했다.
  아이콘을 새로 import하는 과정에서 시간이 오래 걸렸다...
  여러 위젯의 사용법을 다져야겠다.
*/