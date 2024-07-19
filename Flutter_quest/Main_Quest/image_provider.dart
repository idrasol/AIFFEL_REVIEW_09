import 'package:flutter/material.dart';
import 'dart:io';

class ImageProviderModel with ChangeNotifier {
  List<Map<String, String>> _images = [];

  List<Map<String, String>> get images => _images;

  void addImage(File image) {
    final String fileName = DateTime.now().toString();
    _images.add({'path': image.path, 'name': fileName});
    notifyListeners();
  }
}
