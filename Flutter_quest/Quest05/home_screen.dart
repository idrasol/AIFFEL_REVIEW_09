import 'package:flutter/material.dart';
// import 'user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // User user = User(true);
  String predictionResult = '';
  String predictionProbability = '';

  Future<Map<String, dynamic>> fetchPrediction() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:5000/sample')); // 실제 에뮬레이터의 localhost 주소를 사용해야함
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load prediction');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Jellyfish Classifier'),
          leading: Icon(Icons.thunderstorm),
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      width: 300,
                      height: 300,
                      color: Colors.orange,
                      child: Image.asset(
                        'images/jellyfish.jpg',
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final prediction = await fetchPrediction();
                        setState(() {
                          predictionResult = prediction['predicted_label'];
                        });
                        print('$predictionResult');
                      },
                      child: Text('예측결과'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final prediction = await fetchPrediction();
                        setState(() {
                          predictionProbability =
                              prediction['prediction_score'].toString();
                        });
                        print('$predictionProbability');
                      },
                      child: Text('예측확률'),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                // Text('예측 결과: $predictionResult'),
                // Text('예측 확률: $predictionProbability'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
