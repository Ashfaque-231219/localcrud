import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'package:image_picker/image_picker.dart';

import '../constants/asset_const.dart';

Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
        height: MediaQuery.of(context).size.width * 0.05,
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.white])),
        child: Text(
          message, style: TextStyle(fontFamily: FontConst.MontserratFont, fontSize: 14, fontWeight: FontWeight.w600),
        )),
    padding: EdgeInsets.zero,
    duration: const Duration(milliseconds: 1300),
  ));
}

void printLog(String text) {
  debugPrint('\x1B[33m$text\x1B[0m');
}

void printError(String text) {
  debugPrint('\x1B[31m$text\x1B[0m');
}

Future<dynamic> pickImage() async {
  if (!kIsWeb) {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var selected = File(image.path);
      return selected;
      // setState(() {
      //   _pickedImage = selected;
      //   print("THe picked images if ${_pickedImage?.path}");
      // });
    } else {
      print('No image has been picked');
      return null;
    }
  } else if (kIsWeb) {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();
      return f;
      // setState(() {
      //   webImage = f;
      //   _pickedImage = File(image.path);
      // });
    } else {
      print('No image has been picked');
    }
  } else {
    print('Something went wrong');
  }
}
Future<dynamic> pickCImage() async {
  if (!kIsWeb) {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      var selected = File(image.path);
      return selected;
      // setState(() {
      //   _pickedImage = selected;
      //   print("THe picked images if ${_pickedImage?.path}");
      // });
    } else {
      print('No image has been picked');
      return null;
    }
  } else if (kIsWeb) {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();
      return f;
      // setState(() {
      //   webImage = f;
      //   _pickedImage = File(image.path);
      // });
    } else {
      print('No image has been picked');
    }
  } else {
    print('Something went wrong');
  }
}