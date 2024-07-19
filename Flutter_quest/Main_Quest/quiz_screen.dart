import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'image_provider.dart';
import 'main.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        // 앱의 문서 디렉토리 가져오기
        final appDir = await getApplicationDocumentsDirectory();

        // 새로운 파일 이름 생성 (현재 시간을 사용하여 유니크한 이름 생성)
        String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

        // 새로운 파일 경로 생성
        final savedImage = File(path.join(appDir.path, fileName));

        // 이미지 파일 복사
        await File(pickedFile.path).copy(savedImage.path);

        // Provider를 통해 이미지 경로 저장
        Provider.of<ImageProviderModel>(context, listen: false)
            .addImage(savedImage);

        // 추가 촬영 여부를 묻는 다이얼로그 표시
        bool? shouldContinue = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('추가 촬영'),
              content: Text('추가 촬영을 하시겠습니까?'),
              actions: <Widget>[
                TextButton(
                  child: Text('예'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                TextButton(
                  child: Text('아니오'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        );

        if (shouldContinue == true) {
          _pickImage(context);
        } else {
          final myAppState = MainScreen.myAppKey.currentState;
          if (myAppState != null) {
            myAppState.setState(() {
              myAppState.selectedIndex = 2;
            });
          }
        }
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

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
                        onPressed: () => _pickImage(context),
                        child: Text('사진 출제'),
                      ),
                      Text(
                        '교과서 사진을 찍으면 인공지능이 문제를 내줘요!',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
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
                        onPressed: () => _showPreparingMessage(context),
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
