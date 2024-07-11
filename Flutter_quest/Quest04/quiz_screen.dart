import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // For File type

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.yellow,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: Text('사진 출제'),
                      ),
                      Text(
                        '교과서 사진을 찍으면 인공지능이 문제를 내줘요!',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      if (_image != null) Image.file(_image!),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 252, 190, 185),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('교재 출제'),
                      ),
                      Text(
                        '교과서를 선택하면 인공지능이 문제를 내줘요',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// class QuizScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           // appBar: AppBar(
//           //   title: Text('QuizScreen'),
//           // ),
//           body: Container(
//               color: Colors.white,
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                       child: Container(
//                           color: Colors.yellow,
//                           padding: EdgeInsets.all(10),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 ElevatedButton(
//                                   onPressed: () {},
//                                   child: Text('사진 출제'),
//                                 ),
//                                 Text(
//                                   '교과서 사진을 찍으면 인공지능이 문제를 내줘요!',
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 13),
//                                 ),
//                               ]))),
//                   Expanded(
//                       child: Container(
//                           color: const Color.fromARGB(255, 252, 190, 185),
//                           padding: EdgeInsets.all(10),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 ElevatedButton(
//                                   onPressed: () {},
//                                   child: Text('교재 출제'),
//                                 ),
//                                 Text(
//                                   '교과서를 선택하면 인공지능이 문제를 내줘요',
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 13),
//                                 ),
//                               ]))),
//                   // Expanded(
//                   //     child: Container(
//                   //   color: Colors.grey,
//                   // )),
//                 ],
//               )
//               // child: Center(
//               //     child: Column(
//               //   mainAxisAlignment: MainAxisAlignment.center,
//               //   children: [
//               //     Text(
//               //       '쪽지 시험 출제!',
//               //       style: TextStyle(color: Colors.black, fontSize: 30),
//               //     ),
//               //     ElevatedButton(
//               //       onPressed: () {},
//               //       // async {
//               //       //   final result = await Navigator.pushNamed(context, '/two',
//               //       //       arguments: {
//               //       //         "arg1": 10,
//               //       //         "arg2": "hello",
//               //       //         "arg3": User('kkang', 'seoul')
//               //       //       });

//               //       //   print('result:${(result as User).name}');
//               //       // },
//               //       child: Text('사진 찍으러 가기'),
//               //     ),
//               //     SizedBox(height: 20.0),
//               //     // ElevatedButton(
//               //     //   onPressed: () {
//               //     //     if (Navigator.canPop(context)) {
//               //     //       Navigator.pop(context, 1);
//               //     //     }
//               //     //   },
//               //     //   // async {
//               //     //   //   final result = await Navigator.pushNamed(context, '/two',
//               //     //   //       arguments: {
//               //     //   //         "arg1": 10,
//               //     //   //         "arg2": "hello",
//               //     //   //         "arg3": User('kkang', 'seoul')
//               //     //   //       });

//               //     //   //   print('result:${(result as User).name}');
//               //     //   // },
//               //     //   child: Text('Pop'),
//               //     // ),
//               //   ],
//               // )),
//               ),
//         ));
//   }
// }
