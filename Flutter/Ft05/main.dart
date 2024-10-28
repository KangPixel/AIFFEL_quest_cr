import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jellyfish Classifier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JellyfishClassifier(),
    );
  }
}

class JellyfishClassifier extends StatefulWidget {
  @override
  _JellyfishClassifierState createState() => _JellyfishClassifierState();
}

class _JellyfishClassifierState extends State<JellyfishClassifier> {
  String _result = '';

  Future<void> _predictClass() async {
    final url = Uri.parse('http://127.0.0.1:8000/predict');  // 서버 URL 입력 https://2268-211-210-116-230.ngrok-free.app/sample
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _result = '예측 클래스: ${json.decode(response.body)['class']}';
      });
    } else {
      setState(() {
        _result = '서버 오류가 발생했습니다.';
      });
    }
  }

  Future<void> _predictConfidence() async {
    final url = Uri.parse('http://127.0.0.1:8000/confidence'); // 서버 URL 입력
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _result = '예측 확률: ${json.decode(response.body)['confidence']}%';
      });
    } else {
      setState(() {
        _result = '서버 오류가 발생했습니다.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jellyfish Classifier'),
        leading: Icon(Icons.filter_vintage), // 해파리 모양의 대체 아이콘
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Center(child: Text('서버에 있는 이미지를 사용합니다')),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _predictClass,
                  child: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _predictConfidence,
                  child: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
