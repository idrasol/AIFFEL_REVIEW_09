import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  void _showPreparingMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text('준비중입니다. 조금만 기다려주세요.'),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // appBar: AppBar(
          //   title: Text('SettingScreen'),
          // ),
          body: Container(
            color: Colors.white,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '(준비중))',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () => _showPreparingMessage(context),
                  // async {
                  //   final result = await Navigator.pushNamed(context, '/two',
                  //       arguments: {
                  //         "arg1": 10,
                  //         "arg2": "hello",
                  //         "arg3": User('kkang', 'seoul')
                  //       });

                  //   print('result:${(result as User).name}');
                  // },
                  child: Text('출제 설정'),
                ),
                SizedBox(height: 20.0),
                // ElevatedButton(
                //   onPressed: () {
                //     if (Navigator.canPop(context)) {
                //       Navigator.pop(context, 1);
                //     }
                //   },
                //   // async {
                //   //   final result = await Navigator.pushNamed(context, '/two',
                //   //       arguments: {
                //   //         "arg1": 10,
                //   //         "arg2": "hello",
                //   //         "arg3": User('kkang', 'seoul')
                //   //       });

                //   //   print('result:${(result as User).name}');
                //   // },
                //   child: Text('Pop'),
                // ),
              ],
            )),
          ),
        ));
  }
}
