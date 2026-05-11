import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static Future<bool> requestCamera() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  static Future<bool> requestGallery() async {
    if (Platform.isAndroid) {
      final photos = await Permission.photos.request();
      if (photos.isGranted) return true;

      final storage = await Permission.storage.request();
      return storage.isGranted;
    } else {
      final photos = await Permission.photos.request();
      return photos.isGranted;
    }
  }
}
