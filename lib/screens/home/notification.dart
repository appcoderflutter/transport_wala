import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/home/notification_controller.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../widgets/custom_appbar.dart';

class NotificationPage
    extends GetView<NotificationController> {

  const NotificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF7F8FA),

      appBar: CustomAppBar(

        title: "Notifications",

        showBack: true,

        showDrawer: false,

        showNotification: false,

        backgroundColor:
        Colors.white,

        iconColor:
        const Color(0xFF2F66F6),
      ),

      body: SafeArea(

        child: Padding(
          padding:
          EdgeInsets.symmetric(
            horizontal: 18.w,
          ),

          child: Obx(
                () {

              /// EMPTY STATE
              if (controller
                  .notifications
                  .isEmpty) {

                return Center(

                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,

                    children: [

                      /// ICON
                      Container(
                        width: 120.w,
                        height: 120.w,

                        decoration:
                        BoxDecoration(

                          shape:
                          BoxShape.circle,

                          color:
                          const Color(
                              0xFFEEF3FF),
                        ),

                        child: Icon(
                          Icons
                              .notifications_none_rounded,

                          size: 60.sp,

                          color:
                          const Color(
                              0xFF2F66F6),
                        ),
                      ),

                      SizedBox(
                          height: 26.h),

                      Text(
                        "No Notifications Yet",

                        style:
                        CustomTextTheme.bold(
                          color:
                          Colors.black,

                          fontSize:
                          22.sp,
                        ),
                      ),

                      SizedBox(
                          height: 10.h),

                      Padding(
                        padding:
                        EdgeInsets.symmetric(
                          horizontal:
                          34.w,
                        ),

                        child: Text(
                          "You’ll receive updates about loads, payments and activities here.",

                          textAlign:
                          TextAlign.center,

                          style:
                          CustomTextTheme.medium(
                            color:
                            Colors.black54,

                            fontSize:
                            14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              /// NOTIFICATION LIST
              return ListView.builder(

                padding:
                EdgeInsets.only(
                  top: 10.h,
                  bottom: 20.h,
                ),

                itemCount:
                controller
                    .notifications
                    .length,

                itemBuilder:
                    (context, index) {

                  final notification =
                  controller
                      .notifications[index];

                  return Container(

                    margin:
                    EdgeInsets.only(
                      bottom: 16.h,
                    ),

                    padding:
                    EdgeInsets.all(
                        16.w),

                    decoration:
                    BoxDecoration(

                      color:
                      Colors.white,

                      borderRadius:
                      BorderRadius.circular(
                          18.r),

                      boxShadow: [

                        BoxShadow(
                          color: Colors
                              .black
                              .withOpacity(
                              0.04),

                          blurRadius:
                          14,

                          offset:
                          const Offset(
                              0, 5),
                        ),
                      ],
                    ),

                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [

                        /// ICON
                        Container(
                          width: 54.w,
                          height: 54.w,

                          decoration:
                          BoxDecoration(

                            shape:
                            BoxShape.circle,

                            color:
                            _getBgColor(
                              notification[
                              "icon"],
                            ),
                          ),

                          child: Icon(
                            _getIcon(
                              notification[
                              "icon"],
                            ),

                            color:
                            _getColor(
                              notification[
                              "icon"],
                            ),

                            size:
                            28.sp,
                          ),
                        ),

                        SizedBox(
                            width: 14.w),

                        /// TEXT
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                            children: [

                              Row(
                                children: [

                                  Expanded(
                                    child:
                                    Text(
                                      notification[
                                      "title"] ??
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

                                  Text(
                                    notification[
                                    "time"] ??
                                        "",

                                    style:
                                    CustomTextTheme.medium(
                                      color:
                                      Colors.black45,

                                      fontSize:
                                      11.sp,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                  height:
                                  8.h),

                              Text(
                                notification[
                                "message"] ??
                                    "",

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
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  /// =====================
  /// ICONS
  /// =====================

  IconData _getIcon(
      String type,
      ) {

    switch (type) {

      case "payment":
        return Icons
            .account_balance_wallet_rounded;

      case "success":
        return Icons
            .verified_rounded;

      default:
        return Icons
            .local_shipping_rounded;
    }
  }

  /// =====================
  /// ICON COLOR
  /// =====================

  Color _getColor(
      String type,
      ) {

    switch (type) {

      case "payment":
        return Colors.orange;

      case "success":
        return Colors.green;

      default:
        return const Color(
            0xFF2F66F6);
    }
  }

  /// =====================
  /// BG COLOR
  /// =====================

  Color _getBgColor(
      String type,
      ) {

    switch (type) {

      case "payment":
        return Colors.orange
            .withOpacity(0.12);

      case "success":
        return Colors.green
            .withOpacity(0.12);

      default:
        return const Color(
            0xFF2F66F6)
            .withOpacity(0.10);
    }
  }
}