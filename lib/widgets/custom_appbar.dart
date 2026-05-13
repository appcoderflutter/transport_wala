import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../resources/mColours.dart';
import '../../resources/text_styes/custome_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// TITLE
  final String? title;

  /// BACK BUTTON
  final bool showBack;

  /// NOTIFICATION
  final bool showNotification;

  /// DRAWER ICON
  final bool showDrawer;

  /// UNREAD NOTIFICATION
  final bool hasNotification;

  /// BACK ACTION
  final VoidCallback? onBack;

  /// NOTIFICATION ACTION
  final VoidCallback? onNotification;

  /// DRAWER ACTION
  final VoidCallback? onDrawer;

  /// CUSTOM BG
  final Color? backgroundColor;

  /// CUSTOM TITLE COLOR
  final Color? titleColor;

  /// CUSTOM ICON COLOR
  final Color? iconColor;

  /// NOTIFICATION COUNT

  final int notificationCount;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBack = false,
    this.showNotification = false,
    this.showDrawer = false,
    this.hasNotification = false,
    this.onBack,
    this.onNotification,
    this.onDrawer,
    this.backgroundColor,
    this.titleColor,
    this.iconColor,
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? MColors.white,

      elevation: 0,

      scrolledUnderElevation: 0,

      toolbarHeight: 65.h,

      automaticallyImplyLeading: false,

      centerTitle: true,

      /// =========================
      /// LEADING
      /// =========================
      leadingWidth: 65.w,

      leading:
          /// BACK BUTTON
          showBack
          ? Padding(
              padding: EdgeInsets.only(left: 16.w),

              child: GestureDetector(
                onTap: () {
                  if (onBack != null) {
                    onBack!.call();

                    return;
                  }

                  Get.back();
                },

                child: Align(
                  alignment: Alignment.centerLeft,

                  child: Container(
                    width: 38.w,
                    height: 38.w,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      color: Colors.black.withOpacity(0.05),
                    ),

                    child: Icon(
                      Icons.arrow_back,

                      size: 24.w,

                      color: iconColor ?? MColors.black,
                    ),
                  ),
                ),
              ),
            )
          /// DRAWER BUTTON
          : showDrawer
          ? Padding(
              padding: EdgeInsets.only(left: 16.w),

              child: GestureDetector(
                onTap: onDrawer,

                child: Align(
                  alignment: Alignment.centerLeft,

                  child: Icon(
                    Icons.menu_rounded,

                    size: 30.w,

                    color: iconColor ?? MColors.black,
                  ),
                ),
              ),
            )
          : const SizedBox(),

      /// =========================
      /// TITLE
      /// =========================
      title: title != null
          ? Text(
              title!,

              maxLines: 1,

              overflow: TextOverflow.ellipsis,

              style: CustomTextTheme.bold(
                color: titleColor ?? const Color(0xFF082544),

                fontSize: 20.sp,
              ),
            )
          : null,

      /// =========================
      /// ACTIONS
      /// =========================
      actions: [
        /// NOTIFICATION
        /// COUNT BADGE
        if (showNotification)
          GestureDetector(
            onTap: onNotification,

            child: SizedBox(
              width: 45.w,
              height: 45.w,

              child: Stack(
                clipBehavior: Clip.none,

                children: [
                  /// ICON
                  Center(
                    child: Icon(
                      Icons.notifications_none_rounded,

                      size: 28.w,

                      color: iconColor ?? MColors.black,
                    ),
                  ),

                  /// BADGE
                  if (hasNotification)
                    Positioned(
                      top: 6.h,
                      right: 2.w,

                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.red,

                          borderRadius: BorderRadius.circular(30.r),

                          border: Border.all(color: MColors.white, width: 1.5),
                        ),

                        constraints: BoxConstraints(
                          minWidth: 18.w,
                          minHeight: 18.h,
                        ),

                        child: Center(
                          child: Text(
                            notificationCount > 99
                                ? "99+"
                                : notificationCount.toString(),

                            style: TextStyle(
                              color: Colors.white,

                              fontSize: 9.sp,

                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

        SizedBox(width: 16.w),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(65.h);
}
