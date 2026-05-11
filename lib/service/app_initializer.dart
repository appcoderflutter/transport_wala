// import 'package:country_codes/country_codes.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:live_app/helpers/applog.dart';
// import 'package:live_app/utility/const.dart';
// import '../prefs/prefs.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:live_app/helpers/applog.dart';
// import 'package:live_app/utility/const.dart';
// import '../prefs/prefs.dart';
//
// class AppInitializer {
//   static Future<void> init() async {
//     try {
//       // Run in sequence to avoid hidden errors inside Future.wait
//       await _initStorage();
//       _initFonts();
//       await _initPrefs();
//       await CountryCodes.init();
//       AppLogger.info("App initialized successfully", from: 'AppInitializer');
//     } catch (e, s) {
//       AppLogger.error("Init error: $e", from: 'AppInitializer');
//       AppLogger.error("Stack: $s", from: 'AppInitializer');
//     }
//   }
//
//   /// Initialize GetStorage
//   static Future<void> _initStorage() async {
//     try {
//       await GetStorage.init(Consts.storageName);
//       AppLogger.info("Storage initialized", from: 'AppInitializer');
//     } catch (e) {
//       AppLogger.error("Storage init failed: $e", from: 'AppInitializer');
//     }
//   }
//
//   /// Configure Google Fonts (no runtime network call)
//   static void _initFonts() {
//     try {
//       GoogleFonts.config.allowRuntimeFetching = false;
//       AppLogger.info("Fonts configured", from: 'AppInitializer');
//     } catch (e) {
//       AppLogger.error("Font config error: $e", from: 'AppInitializer');
//     }
//   }
//
//   /// Initialize Prefs safely
//   static Future<void> _initPrefs() async {
//     try {
//       final box = GetStorage(Consts.storageName);
//       if (box.getKeys().isEmpty) {
//         AppLogger.info("Storage empty (fresh install)", from: 'Prefs');
//         return;
//       }
//       Prefs.initListeners();
//
//       AppLogger.info("Prefs initialized", from: 'AppInitializer');
//     } catch (e) {
//       AppLogger.error("Prefs init error: $e", from: 'Prefs');
//     }
//   }
// }
//
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

import '../helpers/applog.dart';
import '../network_call/dio_helper/dio_helper.dart';
import '../prefs/prefs.dart';
import '../utility/const.dart';

class AppInitializer {
  /// 🔥 CRITICAL INIT (Run BEFORE runApp)
  static Future<void> initCritical() async {
    try {
      await GetStorage.init(Consts.storageName);
      await Firebase.initializeApp();
      AppLogger.info(
        'Critical initialization completed',
        from: 'AppInitializer',
      );
    } catch (e, s) {
      AppLogger.error('Critical init error: $e', from: 'AppInitializer');
      AppLogger.error('Stack: $s', from: 'AppInitializer');
    }
  }

  /// ⚡ BACKGROUND INIT (Run AFTER runApp)
  static Future<void> initBackground() async {
    try {
      await Future.wait([_initPrefs(), DioHelper.init()]);

      AppLogger.info(
        'Background initialization completed',
        from: 'AppInitializer',
      );
    } catch (e, s) {
      AppLogger.error('Background init error: $e', from: 'AppInitializer');
      AppLogger.error('Stack: $s', from: 'AppInitializer');
    }
  }

  /// Initialize Prefs safely
  static Future<void> _initPrefs() async {
    try {
      final box = GetStorage(Consts.storageName);

      if (box.getKeys().isEmpty) {
        AppLogger.info('Fresh install detected', from: 'Prefs');
        return;
      }

      Prefs.initListeners();
      AppLogger.info('Prefs initialized', from: 'AppInitializer');
    } catch (e) {
      AppLogger.error('Prefs init error: $e', from: 'Prefs');
    }
  }
}
