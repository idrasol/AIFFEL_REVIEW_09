// 회고:
// 어려웠던 점: Next button을 누르면 debug console에서 true값이 출력이 안되는 문제가 있었음
// 새로운 시도: router를 구현해서 화면 전환이 될 수 있도록 함

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'two_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/one',
      routes: {
        '/one': (context) => HomeScreen(),
        '/two': (context) => TwoScreen(),
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
