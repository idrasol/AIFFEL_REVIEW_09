import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  // const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 221,
              height: 74,
              color: Colors.white,
              child: Image.asset(
                'images/big.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Text('내팝퀴즈',
                style: TextStyle(
                  fontSize: 55,
                  color: const Color.fromARGB(255, 3, 85, 6),
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 5.0),
            Text('세상에서 가장 쉬운 쪽지시험 출제앱',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                )),
          ],
        )));
  }
}
