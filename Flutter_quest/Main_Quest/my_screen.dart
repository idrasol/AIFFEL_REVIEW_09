import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'image_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  List<Map<String, String>> files = [
    {
      'name': '2024-07-17 11:11:11.111111',
      'path': 'images/textbook_sample.jpg'
    },
    {
      'name': '2024-07-17 12:12:12.121212',
      'path': 'images/textbook_sample_02.jpg'
    },
  ];

  String ocrResult = '';
  Set<String> selectedImages = {};

  Future<void> uploadImages() async {
    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('선택된 이미지가 없습니다.')),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('인공지능이 분석중입니다.'),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );

    // var url = Uri.parse('http://localhost:5000/upload');
    var url = Uri.parse('http://10.0.2.2:5000/upload');
    var request = http.MultipartRequest('POST', url);

    for (String path in selectedImages) {
      File fileToUpload;
      if (path.startsWith('images/')) {
        // Asset image
        final byteData = await rootBundle.load(path);
        final tempDir = await getTemporaryDirectory();
        fileToUpload = File('${tempDir.path}/${path.split('/').last}');
        await fileToUpload.writeAsBytes(byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      } else {
        // New image
        fileToUpload = File(path);
      }
      request.files
          .add(await http.MultipartFile.fromPath('files', fileToUpload.path));
    }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var results = jsonResponse['results'];
        setState(() {
          ocrResult = results
              .map((result) =>
                  "${result['filename']}: ${result['text'] ?? '인식된 text가 없습니다.'}")
              .join('\n\n');
        });
      } else {
        throw Exception('서버 에러: ${response.statusCode}');
      }
    } catch (e) {
      Navigator.of(context).pop();
      setState(() {
        ocrResult = '이미지 업로드 실패: $e';
      });
    }

    setState(() {
      selectedImages.clear();
    });
  }

  void _showPreparingMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text('인공지능이 인식한 문장으로 출제 시작!\n(준비중)'),
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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Consumer<ImageProviderModel>(
                      builder: (context, imageProvider, child) {
                        List<Map<String, dynamic>> allImages = [
                          ...imageProvider.images
                              .map((img) => {...img, 'isNew': true}),
                          ...files.map((file) => {...file, 'isNew': false}),
                        ];

                        allImages
                            .sort((a, b) => b['name']!.compareTo(a['name']!));

                        return GridView.builder(
                          itemCount: allImages.length,
                          itemBuilder: (context, index) {
                            final imageInfo = allImages[index];
                            return buildImageCard(
                              imageInfo['name']!,
                              imageInfo['path']!,
                              imageInfo['isNew'],
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: uploadImages,
            child: Text('선택한 이미지 인공지능 출제 시작'),
          ),
          if (ocrResult.isNotEmpty)
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'OCR 결과:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(ocrResult),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _showPreparingMessage(context),
                        // setState(() {
                        //   ocrResult = '';
                        // });
                        // },
                        child: Text('인공지능 인식 결과 확인'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildImageCard(String name, String path, bool isNewImage) {
    bool isSelected = selectedImages.contains(path);

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedImages.remove(path);
              } else {
                selectedImages.add(path);
              }
            });
          },
          child: Card(
            child: Container(
              color: Colors.yellow,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: isNewImage
                          ? Image.file(
                              File(path),
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              path,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Transform.scale(
                scale: 0.9,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedImages.add(path);
                      } else {
                        selectedImages.remove(path);
                      }
                    });
                  },
                  materialTapTargetSize:
                      MaterialTapTargetSize.shrinkWrap, // 탭 영역 축소
                ),
              ),
            )),
      ],
    );
  }
}
