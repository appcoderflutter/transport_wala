import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/drawer/privacy_policy_controller.dart';
import '../../resources/mColours.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../widgets/custom_appbar.dart';

class PrivacyPolicyPage
    extends GetView<PrivacyPolicyController> {

  const PrivacyPolicyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      MColors.white,

      appBar: CustomAppBar(

        title: "Privacy Policy",

        backgroundColor:
        Colors.white,

        iconColor:
        const Color(0xFF2F66F6),

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

              margin:
              EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),

              padding:
              EdgeInsets.all(20.w),

              decoration:
              BoxDecoration(

                gradient:
                const LinearGradient(

                  begin:
                  Alignment.topLeft,

                  end:
                  Alignment.bottomRight,

                  colors: [

                    Color(0xFF2F66F6),

                    Color(0xFF5A84FF),
                  ],
                ),

                borderRadius:
                BorderRadius.circular(
                    24.r),
              ),

              child: Row(
                children: [

                  Container(

                    width: 56.w,
                    height: 56.w,

                    decoration:
                    BoxDecoration(

                      color:
                      Colors.white
                          .withOpacity(
                          0.15),

                      shape:
                      BoxShape.circle,
                    ),

                    child: Icon(

                      Icons
                          .privacy_tip_rounded,

                      color:
                      Colors.white,

                      size: 28.sp,
                    ),
                  ),

                  SizedBox(width: 16.w),

                  Expanded(

                    child: Obx(() {

                      return Column(

                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                        children: [

                          Text(

                            controller
                                .privacyPolicyData
                                .value
                                ?.title ??

                                "Privacy Policy",

                            style:
                            CustomTextTheme.bold(

                              color:
                              Colors.white,

                              fontSize:
                              22.sp,
                            ),
                          ),

                          SizedBox(
                              height: 4.h),

                          Text(

                            "Your privacy and data security matter to us.",

                            style:
                            CustomTextTheme.medium(

                              color:
                              Colors.white70,

                              fontSize:
                              13.sp,
                            ),
                          ),
                        ],
                      );
                    }),
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

                if (controller
                    .isLoading.value) {

                  return const Center(

                    child:
                    CircularProgressIndicator(),
                  );
                }

                /// EMPTY

                if (controller
                    .privacyPolicyData
                    .value == null) {

                  return Center(

                    child: Container(

                      margin:
                      EdgeInsets.symmetric(
                        horizontal: 30.w,
                      ),

                      padding:
                      EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 28.h,
                      ),

                      decoration:
                      BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(
                            28.r),

                        boxShadow: [

                          BoxShadow(

                            color:
                            Colors.black
                                .withOpacity(
                                0.06),

                            blurRadius: 18,

                            offset:
                            const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: Column(

                        mainAxisSize:
                        MainAxisSize.min,

                        children: [

                          Container(

                            width: 72.w,
                            height: 72.w,

                            decoration:
                            const BoxDecoration(

                              color:
                              Color(0xFFEEF3FF),

                              shape:
                              BoxShape.circle,
                            ),

                            child: Icon(

                              Icons
                                  .privacy_tip_outlined,

                              color:
                              Color(0xFF2F66F6),

                              size: 34.sp,
                            ),
                          ),

                          SizedBox(
                              height: 18.h),

                          Text(

                            "No Privacy Policy Found",

                            style:
                            CustomTextTheme.bold(

                              color:
                              Colors.black87,

                              fontSize:
                              18.sp,
                            ),
                          ),

                          SizedBox(
                              height: 8.h),

                          Text(

                            "Privacy policy information is currently unavailable.",

                            textAlign:
                            TextAlign.center,

                            style:
                            CustomTextTheme.medium(

                              color:
                              Colors.black54,

                              fontSize:
                              13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                /// DATA

                return SingleChildScrollView(

                  physics:
                  const BouncingScrollPhysics(),

                  padding:
                  EdgeInsets.fromLTRB(
                    16.w,
                    10.h,
                    16.w,
                    16.h,
                  ),

                  child: Container(

                    width: double.infinity,

                    padding:
                    EdgeInsets.all(22.w),

                    decoration:
                    BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(
                          28.r),

                      boxShadow: [

                        BoxShadow(

                          color:
                          Colors.black
                              .withOpacity(
                              0.05),

                          blurRadius: 18,

                          offset:
                          const Offset(0, 8),
                        ),
                      ],
                    ),

                    child: Html(

                      data: controller
                          .privacyPolicyData
                          .value
                          ?.privacyPolicy ??

                          "",

                      style: {

                        "body": Style(

                          margin:
                          Margins.zero,

                          padding:
                          HtmlPaddings.zero,

                          fontSize:
                          FontSize(16.sp),

                          color:
                          Colors.black87,

                          lineHeight:
                          const LineHeight(
                              1.8),
                        ),

                        "p": Style(

                          margin:
                          Margins.only(
                            bottom: 16,
                          ),
                        ),

                        "span": Style(

                          fontSize:
                          FontSize(16.sp),

                          color:
                          Colors.black87,

                          lineHeight:
                          const LineHeight(
                              1.8),
                        ),

                        "a": Style(

                          color:
                          const Color(
                              0xFF2F66F6),

                          textDecoration:
                          TextDecoration.none,
                        ),
                      },
                    ),
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