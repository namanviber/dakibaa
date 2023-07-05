import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

//import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'image_picker_dialog.dart';

class ImagePickerHandler {
  late ImagePickerDialog imagePicker;
  AnimationController? _controller;
  ImagePickerListener _listener;

  ImagePickerHandler(this._listener, this._controller);

  /* openCamera() async {
    imagePicker.dismissDialog();
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _listener.userImage(image);
  }*/

  // openGallery() async {
  //   imagePicker.dismissDialog();
  //   var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  //   if (image != null ){
  //     _listener.userImage(File(image.path));
  //   }
  // }
  openGallery() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        _listener.userImage(File(value.path));
      }
    });
  }

  void init() {
    imagePicker = new ImagePickerDialog(this, _controller);
    imagePicker.initState();
  }

//  Future cropImage(File image) async {
//    File croppedFile = await ImageCropper.cropImage(
//      sourcePath: image.path,
//
//      maxWidth: 512,
//      maxHeight: 512,
//    );
//    _listener.userImage(croppedFile);
//  }
//
  showDialog(BuildContext context) {
    imagePicker.getImage(context);
  }
}

abstract class ImagePickerListener {
  userImage(File _image);
}
