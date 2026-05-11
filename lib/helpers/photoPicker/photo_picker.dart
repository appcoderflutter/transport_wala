// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';
//
// import '../../controllers/profile/edit_profile_controller.dart';
// import 'AppPermissions.dart';
//
// class PhotoPicker {
//   static final ImagePicker _picker = ImagePicker();
//
//   static void show(EditProfileController controller) {
//     Get.bottomSheet(
//       isScrollControlled: true,
//       SafeArea(
//         child: Container(
//           height: Get.height * 0.16,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: const Color(0xff1E1E1E),
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//           ),
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.camera_alt, color: Color(0xffFFFFFF)),
//                 title: const Text('Camera',
//                     style: TextStyle(color: Color(0xffFFFFFF))),
//                 onTap: () {
//                   Get.back();
//                   _pick(ImageSource.camera, controller);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo, color: Color(0xffFFFFFF)),
//                 title: const Text('Gallery',
//                     style: TextStyle(color: Color(0xffFFFFFF))),
//                 onTap: () {
//                   Get.back();
//                   _pick(ImageSource.gallery, controller);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   static Future<void> _pick(
//       ImageSource source, EditProfileController controller) async {
//     bool granted = source == ImageSource.camera
//         ? await AppPermissions.requestCamera()
//         : await AppPermissions.requestGallery();
//
//     if (!granted) return;
//
//     final XFile? picked = await _picker.pickImage(
//       source: source,
//       imageQuality: 90,
//     );
//
//     if (picked == null) return;
//
//     File? cropped = await _crop(File(picked.path));
//     if (cropped == null) return;
//
//     controller.setAvatar(cropped);
//   }
//
//   static Future<File?> _crop(File file) async {
//     final CroppedFile? croppedFile = await ImageCropper().cropImage(
//       sourcePath: file.path,
//       compressQuality: 90,
//       aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//       uiSettings: [
//         AndroidUiSettings(
//           toolbarTitle: 'Crop Image',
//           lockAspectRatio: true,
//           hideBottomControls: false,
//         ),
//         IOSUiSettings(
//           title: 'Crop Image',
//         ),
//       ],
//     );
//
//     if (croppedFile == null) return null;
//
//     return File(croppedFile.path);
//   }
// }
