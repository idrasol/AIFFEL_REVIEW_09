// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'user.dart';

//생략...................
class TwoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Second Page'),
        leading: Icon(
          Icons.door_sliding,
        ),
      ),
      body: Container(
        color: Colors.green,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('TwoScreen',
            //     style: TextStyle(color: Colors.white, fontSize: 30)),
            // Text(
            //     'sendData:${args["arg1"]}, ${args["arg2"]}, ${(args["arg3"] as User).name}'),
            // ElevatedButton(
            //   onPressed: (){
            //     Navigator.pushNamed(context, '/three');
            //   },
            //   child: Text('Go Three'),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, User(false));
              },
              child: Text('Back'),
            ),
            SizedBox(height: 20.0),
            Stack(
              children: <Widget>[
                Container(
                  width: 300,
                  height: 300,
                  color: Colors.black,
                  child: Image.network(
                    'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQgByBT5IiAT_a2x9pUVb4VMoOrlzHH7Jrzj-HB5jzHlR4lNLMS',
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    ));
  }
}
