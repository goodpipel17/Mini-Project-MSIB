import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe_app/Screens/input_recipe.dart';

class gambar with ChangeNotifier {
  bool _isclear = true;
  bool get isclear => _isclear;
  set isclear(bool velue) {
    _isclear = velue;
    notifyListeners();
  }

  // File get imageurl => (_isclear) ? imageURl == null : imageURl == null;
}
