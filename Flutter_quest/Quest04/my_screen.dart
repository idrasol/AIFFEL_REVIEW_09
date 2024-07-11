import 'package:flutter/material.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // appBar: AppBar(
          //   title: Text('MyScreen'),
          // ),
          body: Container(
            color: Colors.white,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'My',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                ElevatedButton(
                  onPressed: () {},
                  // async {
                  //   final result = await Navigator.pushNamed(context, '/two',
                  //       arguments: {
                  //         "arg1": 10,
                  //         "arg2": "hello",
                  //         "arg3": User('kkang', 'seoul')
                  //       });

                  //   print('result:${(result as User).name}');
                  // },
                  child: Text('내가 저장해둔 출제문제'),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context, 1);
                    }
                  },
                  // async {
                  //   final result = await Navigator.pushNamed(context, '/two',
                  //       arguments: {
                  //         "arg1": 10,
                  //         "arg2": "hello",
                  //         "arg3": User('kkang', 'seoul')
                  //       });

                  //   print('result:${(result as User).name}');
                  // },
                  child: Text('Pop'),
                ),
              ],
            )),
          ),
        ));
  }
}
