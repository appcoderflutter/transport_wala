import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/drawer/terms_controller.dart';
import '../../resources/mColours.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../widgets/custom_appbar.dart';

class TermsConditionPage
    extends GetView<TermsController> {

  const TermsConditionPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      MColors.white,

      appBar: CustomAppBar(

        title:
        "Terms & Conditions",

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
            /// TOP PREMIUM HEADER
            /// ====================

            Container(

              margin:
              EdgeInsets.all(16.w),

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
                      Icons.gavel_rounded,

                      color:
                      Colors.white,

                      size: 28.sp,
                    ),
                  ),

                  SizedBox(width: 16.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [

                        Obx(
                              () => Text(
                            controller
                                .title
                                .value,

                            style:
                            CustomTextTheme.bold(
                              color:
                              Colors.white,

                              fontSize:
                              22.sp,
                            ),
                          ),
                        ),

                        SizedBox(
                            height: 4.h),

                        Obx(
                              () => Text(
                            controller
                                .updatedDate
                                .value,

                            style:
                            CustomTextTheme.medium(
                              color:
                              Colors.white70,

                              fontSize:
                              13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding:
              EdgeInsets.symmetric(
                horizontal: 16.w,
              ),

              child: Container(

                padding:
                EdgeInsets.all(14.w),

                decoration:
                BoxDecoration(

                  color:
                  const Color(0xFFEEF3FF),

                  borderRadius:
                  BorderRadius.circular(
                      18.r),
                ),

                child: Row(
                  children: [

                    Icon(
                      Icons
                          .verified_user_rounded,

                      color:
                      const Color(0xFF2F66F6),

                      size: 22.sp,
                    ),

                    SizedBox(width: 12.w),

                    Expanded(
                      child: Text(
                        "Please read all terms carefully before using the platform.",

                        style:
                        CustomTextTheme.medium(
                          color:
                          Colors.black87,

                          fontSize:
                          13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// ====================
            /// TERMS LIST
            /// ====================

            Expanded(

              child: ListView.builder(

                physics:
                const BouncingScrollPhysics(),

                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  bottom: 24.h,
                  top: 16.h,
                ),

                itemCount:
                controller.termsList.length,

                itemBuilder:
                    (context, index) {

                  return Obx(() {

                    final item =
                    controller
                        .termsList[index];

                    final isExpanded =
                        controller
                            .expandedIndex
                            .value == index;

                    return AnimatedContainer(

                      duration:
                      const Duration(
                          milliseconds: 300),

                      margin:
                      EdgeInsets.only(
                        bottom: 14.h,
                      ),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(
                            24.r),

                        border: Border.all(

                          color: isExpanded

                              ? const Color(
                              0xFF2F66F6)

                              : Colors.black12,

                          width:
                          isExpanded ? 1.5 : 1,
                        ),

                        boxShadow: [

                          BoxShadow(
                            color: isExpanded

                                ? const Color(
                                0xFF2F66F6)
                                .withOpacity(
                                0.10)

                                : Colors.black
                                .withOpacity(
                                0.04),

                            blurRadius:
                            isExpanded
                                ? 24
                                : 12,

                            offset:
                            const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [

                          /// HEADER
                          InkWell(

                            borderRadius:
                            BorderRadius.circular(
                                24.r),

                            onTap: () {

                              controller
                                  .toggleCard(
                                  index);
                            },

                            child: Padding(
                              padding:
                              EdgeInsets.all(
                                  18.w),

                              child: Row(
                                children: [

                                  /// NUMBER
                                  Container(

                                    width: 38.w,
                                    height: 38.w,

                                    decoration:
                                    BoxDecoration(

                                      gradient:
                                      const LinearGradient(
                                        colors: [

                                          Color(
                                              0xFF2F66F6),

                                          Color(
                                              0xFF5A84FF),
                                        ],
                                      ),

                                      shape:
                                      BoxShape.circle,
                                    ),

                                    child: Center(
                                      child: Text(
                                        "${index + 1}",

                                        style:
                                        CustomTextTheme.bold(
                                          color:
                                          Colors.white,

                                          fontSize:
                                          15.sp,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                      width: 14.w),

                                  /// TITLE
                                  Expanded(
                                    child: Text(
                                      item["title"] ??
                                          "",

                                      style:
                                      CustomTextTheme.bold(
                                        color:
                                        Colors.black,

                                        fontSize:
                                        16.sp,
                                      ),
                                    ),
                                  ),

                                  AnimatedRotation(

                                    duration:
                                    const Duration(
                                        milliseconds:
                                        300),

                                    turns:
                                    isExpanded
                                        ? 0.5
                                        : 0,

                                    child: Icon(
                                      Icons
                                          .keyboard_arrow_down_rounded,

                                      color:
                                      const Color(
                                          0xFF2F66F6),

                                      size: 28.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// DESCRIPTION
                          AnimatedCrossFade(

                            firstChild:
                            const SizedBox(),

                            secondChild:
                            Padding(

                              padding:
                              EdgeInsets.only(
                                left: 18.w,
                                right: 18.w,
                                bottom: 20.h,
                              ),

                              child: Container(

                                width:
                                double.infinity,

                                padding:
                                EdgeInsets.all(
                                    16.w),

                                decoration:
                                BoxDecoration(

                                  color:
                                  const Color(
                                      0xFFF7F9FF),

                                  borderRadius:
                                  BorderRadius.circular(
                                      18.r),
                                ),

                                child: Text(
                                  item["description"] ??
                                      "",

                                  style:
                                  CustomTextTheme.medium(
                                    color:
                                    Colors.black87,

                                    fontSize:
                                    13.sp,
                                  ),
                                ),
                              ),
                            ),

                            crossFadeState:
                            isExpanded

                                ? CrossFadeState
                                .showSecond

                                : CrossFadeState
                                .showFirst,

                            duration:
                            const Duration(
                                milliseconds: 300),
                          ),
                        ],
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}