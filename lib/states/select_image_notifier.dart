import 'dart:typed_data';

import 'package:blueberry/utils/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageNotifier extends ChangeNotifier {
  List<Uint8List> _images = [];

  Future setNewImages(List<XFile>? newImages) async {
    if (newImages != null && newImages.isNotEmpty) {
      _images.clear();

      for (int i = 0; i < newImages.length; i++) {
        _images.add(await newImages[i].readAsBytes());
        logger.d("add_$i");
      }
      logger.d("set images on the list!!");
      notifyListeners();
    }
  }

  void removeImage(int index) {
    if (_images.length >= index) {
      _images.removeAt(index);
      notifyListeners();
    }
  }

  List<Uint8List> get images => _images;
}
