// 퀘스트팀: 김소영, 신승우
// 회고
// 1. 어려웠던 점
//    1) text 버튼을 눌렀을 때, debug console에 메시지를 띄우는 과정에서 MyApp에 구현했는데, 잘되지 않았음
//    2) body를 TestScreen 클래스로 호출하기 때문에 TestScreen에서 버튼을 구현하고, _handleButtonPress()함수를 매개변수로 전달해서 출력하게 함
// 2. 새로운 시도
//    1) 콘솔 박스뿐만 아니라, 앱 내에서도 메시지가 나올 수 있도록 기능을 추가해봄
//    2) 이를 위해서 TestScreen을 정적에서 동적으로 바꿔줌

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // void _handleButtonPress() {
  //   print('버튼이 눌렸습니다');
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true, // appBar title의 중앙정렬
          title: Text('플러터 앱 만들기'),
          leading: Icon(Icons.radar),
        ),
        body:
            TestScreen(), // 버튼 눌렀을 때 함수 호출 했었으나, 동적 함수로 호출하고자 _handleButtonPress 삭제
      ),
    );
  }
}

class TestScreen extends StatefulWidget {
  // 동적 화면으로 전환해줌
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  // final VoidCallback onPressed;

  // TestScreen(this.onPressed);

  // message 변수 String type 선언
  String message = '';

  void _handleButtonPress() {
    // 버튼이 눌렸을 때 message에 문장 입력해줌
    setState(() {
      message = '버튼이 눌렸습니다';
    });
    print('버튼이 눌렸습니다'); // Debug Console에 메시지 출력
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            // 버튼 추가
            onPressed: _handleButtonPress, // _handleButtonPress 호출
            child: Text('Text'),
          ),
          SizedBox(height: 20.0), // 버튼과 Stack 위젯 사이의 간격 추가
          Stack(
            // stack을 버튼과 간격 다음에 추가
            children: <Widget>[
              Container(
                // 정사각형들은 컨테이너로 중첩시킴
                width: 300,
                height: 300,
                color: Colors.orange,
              ),
              Container(
                // 사이즈는 60씩 감소
                width: 240,
                height: 240,
                color: Colors.greenAccent,
              ),
              Container(
                width: 180,
                height: 180,
                color: Colors.blue,
              ),
              Container(
                width: 120,
                height: 120,
                color: Colors.yellow,
              ),
              Container(
                width: 60,
                height: 60,
                color: Colors.purple,
              ),
            ],
          ),
          SizedBox(height: 20.0), // Stack 위젯과 메시지 사이의 간격 추가
          Text(message, style: TextStyle(fontSize: 13.0)), // 버튼을 누르면 메시지 표시
        ],
      ),
    );
  }
}
