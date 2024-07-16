// 회고
// 어려웠던 점: 웹 상에서의 결과 값이 나오는 localhost 주소와 앱 에뮬레이터 local host 주소가 다른 부분 때문에 어려움이 있었으나, 해결했음
// 새로운 시도: router 구조로 맵핑했음

import 'package:flutter/material.dart';
import 'home_screen.dart';
// import 'two_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/one',
      routes: {
        '/one': (context) => HomeScreen(), // 라우터 구조 유지
        // '/two': (context) => TwoScreen(),
        // '/three': (context) => ThreeScreen(),
        // '/four': (context) => FourScreen()
      },
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/three') {
      //     return MaterialPageRoute(
      //         builder: (context) => ThreeScreen(), settings: settings);
      //   } else if (settings.name == '/four') {
      //     return MaterialPageRoute(
      //         builder: (context) => FourScreen(), settings: settings);
      //   }
      // },
    );
  }
}
