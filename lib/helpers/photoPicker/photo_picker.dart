import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../resources/mColours.dart';
import '../../resources/mStrings.dart';
import 'AppPermissions.dart';

class PhotoPicker {
  static final ImagePicker _picker = ImagePicker();

  /// =========================
  /// SHOW BOTTOM SHEET
  /// =========================

  static void show({required Function(File file) onImageSelected}) {
    Get.bottomSheet(
      isScrollControlled: true,

      SafeArea(
        child: Container(
          height: 150.h,

          padding: EdgeInsets.all(16.w),

          decoration: BoxDecoration(
            color: MColors.black,

            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),

          child: Wrap(
            children: [
              /// CAMERA
              ListTile(
                leading: Icon(Icons.camera_alt, color: MColors.white),

                title: Text(
                  MString.camera,

                  style: TextStyle(color: MColors.white),
                ),

                onTap: () {
                  Get.back();

                  _pick(ImageSource.camera, onImageSelected);
                },
              ),

              /// GALLERY
              ListTile(
                leading: Icon(Icons.photo, color: MColors.white),

                title: Text(
                  MString.gallery,

                  style: TextStyle(color: MColors.white),
                ),

                onTap: () {
                  Get.back();

                  _pick(ImageSource.gallery, onImageSelected);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// =========================
  /// PICK IMAGE
  /// =========================

  static Future<void> _pick(
    ImageSource source,

    Function(File file) onImageSelected,
  ) async {
    bool granted = source == ImageSource.camera
        ? await AppPermissions.requestCamera()
        : await AppPermissions.requestGallery();

    if (!granted) return;

    final XFile? picked = await _picker.pickImage(
      source: source,

      imageQuality: 90,
    );

    if (picked == null) return;

    File? cropped = await _crop(File(picked.path));

    if (cropped == null) return;

    /// RETURN IMAGE

    onImageSelected(cropped);
  }

  /// =========================
  /// CROP IMAGE
  /// =========================

  static Future<File?> _crop(File file) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,

      compressQuality: 90,

      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),

      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: MString.cropImage,

          lockAspectRatio: true,

          hideBottomControls: false,
        ),

        IOSUiSettings(title: MString.cropImage),
      ],
    );

    if (croppedFile == null) {
      return null;
    }

    return File(croppedFile.path);
  }
}
