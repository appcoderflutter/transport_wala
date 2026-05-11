// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
//
// import '../resources/res.dart';
//
// class Loader {
//   static BuildContext? _dialogContext;
//
//   // static void show({bool insideBottomSheet = false}) {
//   //   if (Get.isDialogOpen == true || _dialogContext != null) return;
//   //   final context =
//   //       insideBottomSheet ? Get.overlayContext ?? Get.context : Get.context;
//   //   if (context == null) return;
//   //
//   //   showDialog(
//   //     context: context,
//   //     barrierDismissible: false,
//   //     barrierColor: Colors.black26,
//   //     useRootNavigator: !insideBottomSheet,
//   //     builder: (ctx) {
//   //       _dialogContext = ctx;
//   //       return Center(
//   //         child: insideBottomSheet
//   //             ? Align(alignment: const Alignment(0, 0.2), child: _build())
//   //             : _build(),
//   //       );
//   //     },
//   //   );
//   // }
//
//   static void show({bool insideBottomSheet = false}) {
//     if (Get.isDialogOpen == true || _dialogContext != null) return;
//
//     final context = insideBottomSheet
//         ? Get.overlayContext // 👈 IMPORTANT
//         : Get.context;
//
//     if (context == null) return;
//
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       barrierColor: Colors.black26,
//       useRootNavigator: !insideBottomSheet, // 👈 KEY FIX
//       builder: (ctx) {
//         _dialogContext = ctx;
//         return Center(
//           child: insideBottomSheet
//               ? Align(
//             alignment: const Alignment(0, 0.3), // adjust position
//             child: _build(),
//           )
//               : _build(),
//         );
//       },
//     );
//   }
//   static Widget _build() {
//     return Material(
//       color: Colors.transparent,
//       child: IntrinsicWidth(
//         stepWidth: 200.w,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Transform.translate(
//               offset: const Offset(0, -4),
//               child: Lottie.asset(
//                 Res.loader_custome,
//                 width: 200.w,
//                 height: 200.w,
//                 fit: BoxFit.contain,
//                 repeat: true,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   static void hide() {
//     try {
//       if (_dialogContext != null) {
//         Navigator.of(_dialogContext!).pop();
//         _dialogContext = null;
//       } else if (Get.isDialogOpen == true) {
//         Get.back();
//       }
//     } catch (_) {
//       _dialogContext = null;
//     }
//   }
// }
//
// // normal screen
// // ElevatedButton(
// // onPressed: () async {
// // Loader.show();
// // await Future.delayed(Duration(seconds: 2));
// // Loader.hide();
// // },
// // child: Text("Show Loader (Normal Screen)"),
// // )
//
// //bottom sheet
// // ElevatedButton(
// // onPressed: () async {
// // Loader.show(
// // insideBottomSheet: true, // 👈 key flag
// // );
// // await Future.delayed(Duration(seconds: 2));
// // Loader.hide();
// // },

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../resources/res.dart';

class Loader {
  static BuildContext? _dialogContext;

  // static void show({
  //   bool insideBottomSheet = false,
  //   double? sheetHeight, // 👈 NEW PARAM
  // }) {
  //   if (Get.isDialogOpen == true || _dialogContext != null) return;
  //
  //   final context = insideBottomSheet ? Get.overlayContext : Get.context;
  //
  //   if (context == null) return;
  //
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     barrierColor: Colors.black26,
  //     useRootNavigator: !insideBottomSheet,
  //     builder: (ctx) {
  //       _dialogContext = ctx;
  //
  //       double alignmentY = 0;
  //
  //       /// 🔥 DYNAMIC ALIGNMENT
  //       if (insideBottomSheet && sheetHeight != null) {
  //         final screenHeight = Get.height;
  //
  //         /// calculate center of bottom sheet in screen
  //         alignmentY = 1 - (sheetHeight / screenHeight) / 2;
  //
  //         /// clamp safety
  //         if (alignmentY > 1) alignmentY = 0.9;
  //         if (alignmentY < -1) alignmentY = 0.0;
  //       }
  //
  //       return Material(
  //         color: Colors.transparent,
  //         child: Stack(
  //           children: [
  //             Container(color: Colors.black26),
  //             Align(
  //               alignment: insideBottomSheet
  //                   ? Alignment(0, alignmentY)
  //                   : Alignment.center,
  //               child: _build(),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  static void show({
    bool insideBottomSheet = false,
    double? sheetHeight,
  }) {
    // ✅ Always defer showDialog to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.isDialogOpen == true || _dialogContext != null) return;

      final context = insideBottomSheet ? Get.overlayContext : Get.context;
      if (context == null) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black26,
        useRootNavigator: !insideBottomSheet,
        builder: (ctx) {
          _dialogContext = ctx;

          double alignmentY = 0;
          if (insideBottomSheet && sheetHeight != null) {
            final screenHeight = Get.height;
            alignmentY = 1 - (sheetHeight / screenHeight) / 2;
            alignmentY = alignmentY.clamp(-1.0, 1.0);
          }

          return Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                Container(color: Colors.black26),
                Align(
                  alignment: insideBottomSheet
                      ? Alignment(0, alignmentY)
                      : Alignment.center,
                  child: _build(),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  static Widget _build() {
    return IntrinsicWidth(
      stepWidth: 200.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.translate(
            offset: const Offset(0, -4),
            child: Lottie.asset(
              Res.loader_custome,
              width: 180.w,
              height: 180.w,
              fit: BoxFit.contain,
              repeat: true,
            ),
          ),
        ],
      ),
    );
  }

  static void hide() {
    try {
      if (_dialogContext != null) {
        Navigator.of(_dialogContext!).pop();
        _dialogContext = null;
      } else if (Get.isDialogOpen == true) {
        Get.back();
      }
    } catch (_) {
      _dialogContext = null;
    }
  }
}
