import 'package:get/get.dart';

class TermsController
    extends GetxController {

  /// =========================
  /// TITLE
  /// =========================

  final title =
      "Terms & Conditions".obs;

  /// =========================
  /// UPDATED DATE
  /// =========================

  final updatedDate =
      "Updated on 12 June 2026".obs;

  /// =========================
  /// EXPANDED INDEX
  /// -1 = NOTHING OPEN
  /// =========================

  final expandedIndex =
      (-1).obs;

  /// =========================
  /// TERMS DATA
  /// API READY
  /// =========================

  final RxList<Map<String, dynamic>>
  termsList =
      <Map<String, dynamic>>[

        {
          "title":
          "Account Responsibility",

          "description":
          "Users are responsible for maintaining accurate account information and protecting login credentials securely.",
        },

        {
          "title":
          "Booking & Vehicle Usage",

          "description":
          "All transport activities must comply with transport and safety regulations imposed by local authorities.",
        },

        {
          "title":
          "Data Privacy & Security",

          "description":
          "Your personal information and transport data remain encrypted and protected inside our platform.",
        },

        {
          "title":
          "Cancellation Policy",

          "description":
          "Transport requests may be cancelled according to company policy and timing restrictions.",
        },

        {
          "title":
          "Platform Limitations",

          "description":
          "We are not responsible for delays caused by weather, strikes, traffic restrictions, or third-party failures.",
        },

        {
          "title":
          "Fraud & Misuse",

          "description":
          "Fraudulent activity, fake bookings, or misuse of the application can permanently suspend your account.",
        },

      ].obs;

  /// =========================
  /// TOGGLE CARD
  /// =========================

  void toggleCard(int index) {

    if (expandedIndex.value == index) {

      /// CLOSE
      expandedIndex.value = -1;

    } else {

      /// OPEN
      expandedIndex.value = index;
    }
  }
}