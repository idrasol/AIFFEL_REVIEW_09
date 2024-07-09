import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'user.dart';

class HomeScreen extends StatelessWidget {
  bool is_cat = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('First Page'),
        leading: Icon(
          Icons.donut_large,
        ),
      ),
      body: Container(
        color: Colors.red,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   'First Page',
            //   style: TextStyle(color: Colors.white, fontSize: 30),
            // ),

            ElevatedButton(
              onPressed: () async {
                print('is_cat:$is_cat');

                final result = await Navigator.pushNamed(context, '/two');

                print('is_cat:${(result as User).is_cat}');
              },
              child: Text('Next'),
            ),
            SizedBox(height: 20.0),
            Stack(
              children: <Widget>[
                Container(
                  width: 300,
                  height: 300,
                  color: Colors.orange,
                  child: Image.network(
                    'https://i.redd.it/y5vsyfep0hrb1.jpg',
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
