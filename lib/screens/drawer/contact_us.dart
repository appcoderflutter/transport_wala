import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/drawer/contact_us_controller.dart';
import '../../resources/mColours.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../widgets/custom_appbar.dart';

class ContactUsPage extends GetView<ContactUsController> {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.white,

      appBar: CustomAppBar(
        title: "Contact Us",

        backgroundColor: Colors.white,

        iconColor: const Color(0xFF2F66F6),

        showBack: true,

        showDrawer: false,

        showNotification: false,
      ),

      body: SafeArea(
        child: Column(
          children: [
            /// ====================
            /// TOP HEADER
            /// ====================
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),

              padding: EdgeInsets.all(22.w),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,

                  end: Alignment.bottomRight,

                  colors: [Color(0xFF2F66F6), Color(0xFF5A84FF)],
                ),

                borderRadius: BorderRadius.circular(28.r),
              ),

              child: Row(
                children: [
                  Container(
                    width: 60.w,
                    height: 60.w,

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),

                      shape: BoxShape.circle,
                    ),

                    child: Icon(
                      Icons.support_agent_rounded,

                      color: Colors.white,

                      size: 30.sp,
                    ),
                  ),

                  SizedBox(width: 16.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "We're Here To Help",

                          style: CustomTextTheme.bold(
                            color: Colors.white,

                            fontSize: 22.sp,
                          ),
                        ),

                        SizedBox(height: 4.h),

                        Text(
                          "Feel free to contact us anytime.",

                          style: CustomTextTheme.medium(
                            color: Colors.white70,

                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// ====================
            /// CONTENT
            /// ====================
            Expanded(
              child: Obx(() {
                /// LOADING

                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                /// EMPTY

                if (controller.contactUsData.value == null) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.w),

                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 28.h,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(28.r),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),

                            blurRadius: 18,

                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Container(
                            width: 72.w,
                            height: 72.w,

                            decoration: const BoxDecoration(
                              color: Color(0xFFEEF3FF),

                              shape: BoxShape.circle,
                            ),

                            child: Icon(
                              Icons.contact_support_outlined,

                              color: Color(0xFF2F66F6),

                              size: 34.sp,
                            ),
                          ),

                          SizedBox(height: 18.h),

                          Text(
                            "No Contact Found",

                            style: CustomTextTheme.bold(
                              color: Colors.black87,

                              fontSize: 18.sp,
                            ),
                          ),

                          SizedBox(height: 8.h),

                          Text(
                            "Contact information is currently unavailable.",

                            textAlign: TextAlign.center,

                            style: CustomTextTheme.medium(
                              color: Colors.black54,

                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final data = controller.contactUsData.value!;

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),

                  padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),

                  child: Column(
                    children: [
                      /// ADDRESS
                      _ContactCard(
                        icon: Icons.location_on,

                        title: "Office Address",

                        value: data.address,
                      ),

                      /// EMAIL
                      _ContactCard(
                        icon: Icons.email_rounded,

                        title: "Email Address",

                        value: data.email,
                      ),

                      /// PHONE
                      _ContactCard(
                        icon: Icons.call_rounded,

                        title: "Phone Number",

                        value: data.phone,
                      ),

                      /// WHATSAPP
                      _ContactCard(
                        icon: Icons.wechat_rounded,

                        title: "WhatsApp",

                        value: data.whatsAppLink == "NA"
                            ? "Not Available"
                            : data.whatsAppLink,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/// =========================
/// CONTACT CARD
/// =========================

class _ContactCard extends StatelessWidget {

  final IconData icon;
  final String title;
  final String value;

  const _ContactCard({

    required this.icon,

    required this.title,

    required this.value,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin:
      EdgeInsets.only(
        bottom: 14.h,
      ),

      padding:
      EdgeInsets.all(18.w),

      decoration:
      BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(
            24.r),

        border: Border.all(

          color:
          const Color(
              0xFFF1F3F8),
        ),

        boxShadow: [

          BoxShadow(

            color:
            Colors.black
                .withOpacity(
                0.03),

            blurRadius: 16,

            offset:
            const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        children: [

          /// ICON

          Container(

            width: 52.w,
            height: 52.w,

            decoration:
            BoxDecoration(

              color:
              const Color(
                  0xFFF4F7FF),

              borderRadius:
              BorderRadius.circular(
                  18.r),
            ),

            child: Icon(

              icon,

              color:
              const Color(
                  0xFF2F66F6),

              size: 25.sp,
            ),
          ),

          SizedBox(width: 16.w),

          /// TEXT

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [

                Text(

                  title,

                  style:
                  CustomTextTheme.medium(

                    color:
                    Colors.black45,

                    fontSize:
                    13.sp,
                  ),
                ),

                SizedBox(height: 6.h),

                Text(

                  value,

                  style:
                  CustomTextTheme.bold(

                    color:
                    Colors.black87,

                    fontSize:
                    15.sp,
                  ),
                ),
              ],
            ),
          ),

          /// MINI ACTION

          Container(

            width: 34.w,
            height: 34.w,

            decoration:
            BoxDecoration(

              color:
              const Color(
                  0xFFF7F8FC),

              borderRadius:
              BorderRadius.circular(
                  12.r),
            ),

            child: Icon(

              Icons.arrow_outward_rounded,

              color:
              Colors.black54,

              size: 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}
