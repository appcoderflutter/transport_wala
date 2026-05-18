import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/drawer/kyc_controller.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../widgets/custom_appbar.dart';

class KycPage extends GetView<KycController> {
  const KycPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),

      appBar: CustomAppBar(
        title: "KYC Details",

        showBack: true,

        showDrawer: false,

        showNotification: false,

        backgroundColor: Colors.white,

        iconColor: const Color(0xFF2F66F6),
      ),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = controller.user.value;

          final kyc = controller.kycData.value;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 30.h),

            child: Column(
              children: [
                SizedBox(height: 12.h),

                Stack(
                  clipBehavior: Clip.none,

                  children: [
                    Container(
                      width: double.infinity,

                      padding: EdgeInsets.only(
                        top: 28.h,
                        left: 22.w,
                        right: 22.w,
                        bottom: 28.h,
                      ),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34.r),

                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,

                          end: Alignment.bottomRight,

                          colors: [Color(0xFF2F66F6), Color(0xFF001A9F)],
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2F66F6).withOpacity(.28),

                            blurRadius: 30,

                            offset: const Offset(0, 14),
                          ),
                        ],
                      ),

                      child: Stack(
                        children: [
                          /// GLASS CONTENT
                          ClipRRect(
                            borderRadius: BorderRadius.circular(28.r),

                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 8,
                                sigmaY: 8,
                              ),

                              child: Container(
                                width: double.infinity,

                                alignment: Alignment.center,

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    /// PROFILE
                                    Hero(
                                      tag: "profile",

                                      child: Container(
                                        padding: EdgeInsets.all(4.w),

                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,

                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),

                                        child: CircleAvatar(
                                          radius: 46.r,

                                          backgroundColor: Colors.white,

                                          backgroundImage:
                                          (user?.profilePic ?? "")
                                              .trim()
                                              .isNotEmpty &&
                                              user?.profilePic != "NA"
                                              ? NetworkImage(
                                            "${user!.profilePic!}?t=${DateTime.now().millisecondsSinceEpoch}",
                                          )
                                              : null,

                                          child:
                                          (user?.profilePic ?? "")
                                              .trim()
                                              .isEmpty ||
                                              user?.profilePic == "NA"
                                              ? Icon(
                                            Icons.person,

                                            size: 42.sp,

                                            color: const Color(0xFF2F66F6),
                                          )
                                              : null,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 18.h),

                                    /// NAME
                                    Text(
                                      user?.name ?? "Unknown User",

                                      textAlign: TextAlign.center,

                                      style: CustomTextTheme.bold(
                                        color: Colors.white,

                                        fontSize: 23.sp,
                                      ),
                                    ),

                                    SizedBox(height: 7.h),

                                    /// USER TYPE
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 14.w,
                                        vertical: 7.h,
                                      ),

                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(.12),

                                        borderRadius: BorderRadius.circular(40.r),
                                      ),

                                      child: Text(
                                        (user?.userType ?? "").trim() == "TRANSPORTER"
                                            ? "TRANSPORTER"
                                            : "VEHICLE OWNER",

                                        textAlign: TextAlign.center,

                                        style: CustomTextTheme.medium(
                                          color: Colors.white,

                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 14.h),

                                    /// ID
                                    Text(
                                      "Unique ID : ${user?.uniqueUserId ?? "--"}",

                                      textAlign: TextAlign.center,

                                      style: CustomTextTheme.medium(
                                        color: Colors.white70,

                                        fontSize: 13.sp,
                                      ),
                                    ),

                                    SizedBox(height: 22.h),

                                    /// VERIFIED BADGE
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 18.w,
                                        vertical: 10.h,
                                      ),

                                      decoration: BoxDecoration(
                                        color: Colors.white,

                                        borderRadius: BorderRadius.circular(50.r),
                                      ),

                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,

                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [
                                          Icon(
                                            _getKycIcon(user?.isKycVerified),

                                            color: _getKycColor(
                                              user?.isKycVerified,
                                            ),

                                            size: 18.sp,
                                          ),

                                          SizedBox(width: 8.w),

                                          Text(
                                            _getKycStatus(user?.isKycVerified),

                                            textAlign: TextAlign.center,

                                            style: CustomTextTheme.bold(
                                              color: _getKycColor(
                                                user?.isKycVerified,
                                              ),

                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 22.h),

                /// =========================
                /// STATS ROW
                /// =========================
                Row(
                  children: [
                    Expanded(
                      child: _statsCard(
                        icon: Icons.route_rounded,

                        title: "Routes",

                        value: "${user?.userActiveRoutes ?? 0}",
                      ),
                    ),

                    SizedBox(width: 14.w),

                    Expanded(
                      child: _statsCard(
                        icon: Icons.local_shipping_rounded,

                        title: "Vehicles",

                        value: "${user?.userActiveVehicles ?? 0}",
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 26.h),

                /// =========================
                /// PERSONAL INFO
                /// =========================
                _sectionTitle(
                  title: "Personal Information",

                  subtitle: "Basic KYC identity details",
                ),

                SizedBox(height: 16.h),

                _infoCard(
                  icon: Icons.badge_outlined,

                  title: "Aadhaar Number",

                  value: kyc?.aadharNo,
                ),

                _infoCard(
                  icon: Icons.location_on_outlined,

                  title: "Address",

                  value: kyc?.address,
                ),

                SizedBox(height: 24.h),

                /// =========================
                /// BUSINESS INFO
                /// =========================
                _sectionTitle(
                  title: "Business Information",

                  subtitle: "Company & GST details",
                ),

                SizedBox(height: 16.h),

                _infoCard(
                  icon: Icons.business_outlined,

                  title: "Company Name",

                  value: kyc?.companyName,
                ),

                _infoCard(
                  icon: Icons.receipt_long_outlined,

                  title: "GST Number",

                  value: kyc?.gstNo,
                ),

                _infoCard(
                  icon: Icons.person_outline,

                  title: "Contact Person",

                  value: kyc?.contactPersonName,
                ),

                SizedBox(height: 24.h),

                /// =========================
                /// DOCUMENTS
                /// =========================
                _sectionTitle(
                  title: "Documents",

                  subtitle: "Uploaded Aadhaar previews",
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: _imageCard(
                        title: "Front Side",

                        image: kyc?.aadharCardFrontSide,
                      ),
                    ),

                    SizedBox(width: 14.w),

                    Expanded(
                      child: _imageCard(
                        title: "Back Side",

                        image: kyc?.aadharCardBackSide,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                /// =========================
                /// BUTTON
                /// =========================
                Container(
                  width: double.infinity,

                  height: 58.h,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),

                    gradient: const LinearGradient(
                      colors: [Color(0xFF2F66F6), Color(0xFF001A9F)],
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2F66F6).withOpacity(.28),

                        blurRadius: 20,

                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(
                        Icons.edit_note_rounded,

                        color: Colors.white,

                        size: 24.sp,
                      ),

                      SizedBox(width: 10.w),

                      Text(
                        "Request KYC Update",

                        style: CustomTextTheme.bold(
                          color: Colors.white,

                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// =========================
  /// SECTION TITLE
  /// =========================

  Widget _sectionTitle({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,

          style: CustomTextTheme.bold(color: Colors.black87, fontSize: 18.sp),
        ),

        SizedBox(height: 4.h),

        Text(
          subtitle,

          style: CustomTextTheme.medium(color: Colors.black45, fontSize: 12.sp),
        ),
      ],
    );
  }

  /// =========================
  /// STATS CARD
  /// =========================

  Widget _statsCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(18.w),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(22.r),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),

            blurRadius: 16,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        children: [
          Container(
            width: 52.w,
            height: 52.w,

            decoration: BoxDecoration(
              color: const Color(0xFF2F66F6).withOpacity(.08),

              shape: BoxShape.circle,
            ),

            child: Icon(icon, color: const Color(0xFF2F66F6), size: 24.sp),
          ),

          SizedBox(height: 12.h),

          Text(
            value,

            style: CustomTextTheme.bold(color: Colors.black, fontSize: 22.sp),
          ),

          SizedBox(height: 4.h),

          Text(
            title,

            style: CustomTextTheme.medium(
              color: Colors.black45,

              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  /// =========================
  /// INFO CARD
  /// =========================

  Widget _infoCard({
    required IconData icon,
    required String title,
    String? value,
  }) {
    final displayValue = (value ?? "").trim().isEmpty || value == "NA"
        ? "Not Available"
        : value!;

    return Container(
      width: double.infinity,

      margin: EdgeInsets.only(bottom: 14.h),

      padding: EdgeInsets.all(18.w),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(22.r),

        border: Border.all(color: Colors.grey.shade100),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),

            blurRadius: 16,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.w,

            decoration: BoxDecoration(
              color: const Color(0xFF2F66F6).withOpacity(.08),

              borderRadius: BorderRadius.circular(16.r),
            ),

            child: Icon(icon, color: const Color(0xFF2F66F6), size: 24.sp),
          ),

          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: CustomTextTheme.medium(
                    color: Colors.black45,

                    fontSize: 12.sp,
                  ),
                ),

                SizedBox(height: 6.h),

                Text(
                  displayValue,

                  style: CustomTextTheme.bold(
                    color: Colors.black87,

                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// =========================
  /// IMAGE CARD
  /// =========================

  Widget _imageCard({required String title, String? image}) {
    final hasImage = (image ?? "").trim().isNotEmpty && image != "NA";

    return GestureDetector(
      onTap: () {
        if (hasImage) {
          Get.dialog(
            Dialog(
              backgroundColor: Colors.black,

              insetPadding: EdgeInsets.all(14.w),

              child: InteractiveViewer(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.r),

                  child: Image.network(image!, fit: BoxFit.contain),
                ),
              ),
            ),
          );
        }
      },

      child: Container(
        padding: EdgeInsets.all(12.w),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(22.r),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),

              blurRadius: 16,

              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18.r),

              child: hasImage
                  ? Image.network(
                      image!,

                      height: 150.h,

                      width: double.infinity,

                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 150.h,

                      color: Colors.grey.shade200,

                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,

                          color: Colors.grey,

                          size: 34.sp,
                        ),
                      ),
                    ),
            ),

            SizedBox(height: 12.h),

            Text(
              title,

              style: CustomTextTheme.bold(
                color: Colors.black87,

                fontSize: 13.sp,
              ),
            ),

            SizedBox(height: 4.h),

            Text(
              "Tap to preview",

              style: CustomTextTheme.medium(
                color: Colors.black45,

                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// =========================
  /// STATUS TEXT
  /// =========================

  String _getKycStatus(String? status) {
    switch (status) {
      case "0":
        return "KYC SUBMITTED";

      case "1":
        return "KYC PENDING";

      case "2":
        return "KYC VERIFIED";

      default:
        return "KYC NOT SUBMITTED";
    }
  }

  /// =========================
  /// STATUS COLOR
  /// =========================

  Color _getKycColor(String? status) {
    switch (status) {
      case "0":
        return Colors.blue;

      case "1":
        return Colors.orange;

      case "2":
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  /// =========================
  /// STATUS ICON
  /// =========================

  IconData _getKycIcon(String? status) {
    switch (status) {
      case "0":
        return Icons.upload_file_rounded;

      case "1":
        return Icons.pending_actions_rounded;

      case "2":
        return Icons.verified_rounded;

      default:
        return Icons.info_outline_rounded;
    }
  }
}
