import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/drawer/driver_controller.dart';
import '../../resources/mColours.dart';
import '../../resources/text_styes/custome_text.dart';
import '../../widgets/custom_appbar.dart';

class DriverPage
    extends GetView<DriverController> {

  const DriverPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      MColors.white,

      floatingActionButton:

      Container(

        decoration:
        BoxDecoration(

          borderRadius:
          BorderRadius.circular(
              30.r),

          gradient:
          const LinearGradient(
            colors: [

              Color(0xFF2F66F6),

              Color(0xFF5A84FF),
            ],
          ),

          boxShadow: [

            BoxShadow(
              color:
              const Color(
                  0xFF2F66F6)
                  .withOpacity(0.35),

              blurRadius: 20,

              offset:
              const Offset(0, 8),
            ),
          ],
        ),

        child:
        FloatingActionButton.extended(

          onPressed: () {},

          elevation: 0,

          backgroundColor:
          Colors.transparent,

          label: Text(
            "Add Driver",

            style:
            CustomTextTheme.bold(
              color:
              Colors.white,

              fontSize:
              14.sp,
            ),
          ),

          icon: Icon(
            Icons.add_rounded,

            color:
            Colors.white,

            size: 22.sp,
          ),
        ),
      ),

      appBar: CustomAppBar(

        title: "Drivers",

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

            /// HERO
            Container(

              margin:
              EdgeInsets.all(16.w),

              padding:
              EdgeInsets.all(22.w),

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
                    34.r),
              ),

              child: Column(
                children: [

                  /// TOP
                  Row(
                    children: [

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                          children: [

                            Text(
                              "Driver Management",

                              style:
                              CustomTextTheme.extraBold(
                                color:
                                Colors.white,

                                fontSize:
                                28.sp,
                              ),
                            ),

                            SizedBox(height: 8.h),

                            Text(
                              "Manage and monitor all transport drivers seamlessly.",

                              style:
                              CustomTextTheme.medium(
                                color:
                                Colors.white70,

                                fontSize:
                                13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(

                        width: 82.w,
                        height: 82.w,

                        decoration:
                        BoxDecoration(

                          shape:
                          BoxShape.circle,

                          color:
                          Colors.white
                              .withOpacity(
                              0.14),
                        ),

                        child: Icon(
                          Icons
                              .supervised_user_circle_rounded,

                          color:
                          Colors.white,

                          size: 46.sp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 28.h),

                  /// STATS
                  Row(
                    children: [

                      Expanded(
                        child: _TopStatCard(
                          title:
                          "Total",

                          value:
                          controller
                              .totalDrivers
                              .value
                              .toString(),
                        ),
                      ),

                      SizedBox(width: 12.w),

                      Expanded(
                        child: _TopStatCard(
                          title:
                          "Active",

                          value:
                          controller
                              .activeDrivers
                              .value
                              .toString(),
                        ),
                      ),

                      SizedBox(width: 12.w),

                      Expanded(
                        child: _TopStatCard(
                          title:
                          "Trips",

                          value:
                          controller
                              .onTripDrivers
                              .value
                              .toString(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// SEARCH
            Transform.translate(

              offset:
              Offset(0, -8.h),

              child: Padding(

                padding:
                EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),

                child: Container(

                  padding:
                  EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),

                  decoration:
                  BoxDecoration(

                    color:
                    Colors.white,

                    borderRadius:
                    BorderRadius.circular(
                        24.r),

                    boxShadow: [

                      BoxShadow(
                        color: Colors
                            .black
                            .withOpacity(
                            0.05),

                        blurRadius:
                        20,

                        offset:
                        const Offset(
                            0,
                            8),
                      ),
                    ],
                  ),

                  child: Obx(

                        () => TextField(

                      controller:
                      controller
                          .searchController,

                      focusNode:
                      controller
                          .searchFocusNode,

                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),

                      onChanged: (value) {

                        controller
                            .searchText
                            .value = value;
                      },

                      decoration:
                      InputDecoration(

                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18.h,
                        ),

                        border:
                        InputBorder.none,

                        icon: Icon(
                          Icons.search_rounded,

                          color:
                          const Color(
                              0xFF2F66F6),

                          size: 24.sp,
                        ),

                        /// CLEAR BUTTON
                        suffixIcon:
                        controller
                            .searchText
                            .value
                            .isNotEmpty

                            ? GestureDetector(

                          onTap: () {

                            /// CLEAR TEXT
                            controller
                                .searchController
                                .clear();

                            /// CLEAR SEARCH
                            controller
                                .searchText
                                .value = "";

                            /// REMOVE KEYBOARD
                            controller
                                .searchFocusNode
                                .unfocus();
                          },

                          child: Container(

                            margin:
                            EdgeInsets.all(10.w),

                            decoration:
                            BoxDecoration(

                              color:
                              const Color(
                                  0xFFEEF3FF),

                              shape:
                              BoxShape.circle,
                            ),

                            child: Icon(
                              Icons.close_rounded,

                              color:
                              const Color(
                                  0xFF2F66F6),

                              size: 18.sp,
                            ),
                          ),
                        )

                            : null,

                        hintText:
                        "Search drivers...",

                        hintStyle:
                        CustomTextTheme.medium(
                          color:
                          Colors.black45,

                          fontSize:
                          14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// TITLE
            Padding(
              padding:
              EdgeInsets.symmetric(
                horizontal: 18.w,
              ),

              child: Row(
                children: [

                  Text(
                    "All Drivers",

                    style:
                    CustomTextTheme.bold(
                      color:
                      Colors.black,

                      fontSize:
                      20.sp,
                    ),
                  ),

                  const Spacer(),

                  Obx(
                        () => Container(

                      padding:
                      EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),

                      decoration:
                      BoxDecoration(

                        color:
                        const Color(
                            0xFFEEF3FF),

                        borderRadius:
                        BorderRadius.circular(
                            30.r),
                      ),

                      child: Text(
                        "${controller.filteredDrivers.length} Drivers",

                        style:
                        CustomTextTheme.bold(
                          color:
                          const Color(
                              0xFF2F66F6),

                          fontSize:
                          12.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            /// LIST
            Expanded(

              child: Obx(() {

                /// =========================
                /// NO DRIVER
                /// =========================

                if (controller.drivers.isEmpty) {

                  return SingleChildScrollView(
                    physics:
                    const BouncingScrollPhysics(),
                    child: SizedBox(
                      height:
                      MediaQuery.of(context)
                          .size
                          .height * 0.40,
                      child: Center(

                        child: Padding(

                          padding:
                          EdgeInsets.symmetric(
                            horizontal: 26.w,
                          ),

                          child: Column(

                            mainAxisAlignment:
                            MainAxisAlignment.center,

                            children: [

                              Container(

                                width: 120.w,
                                height: 120.w,

                                decoration:
                                BoxDecoration(

                                  shape:
                                  BoxShape.circle,

                                  gradient:
                                  LinearGradient(
                                    colors: [

                                      const Color(
                                          0xFF2F66F6)
                                          .withOpacity(
                                          0.10),

                                      const Color(
                                          0xFF5A84FF)
                                          .withOpacity(
                                          0.03),
                                    ],
                                  ),
                                ),

                                child: Icon(
                                  Icons.people_alt_rounded,

                                  color:
                                  const Color(
                                      0xFF2F66F6),

                                  size: 56.sp,
                                ),
                              ),

                              SizedBox(height: 28.h),

                              Text(
                                "No Drivers Yet",

                                textAlign:
                                TextAlign.center,

                                style:
                                CustomTextTheme.extraBold(
                                  color:
                                  Colors.black,

                                  fontSize:
                                  24.sp,
                                ),
                              ),

                              SizedBox(height: 10.h),

                              Text(
                                "Your added drivers will appear here.\nStart building your transport network.",

                                textAlign:
                                TextAlign.center,

                                style:
                                CustomTextTheme.medium(
                                  color:
                                  Colors.black45,

                                  fontSize:
                                  14.sp,
                                ),
                              ),

                              SizedBox(height: 28.h),

                              Container(

                                padding:
                                EdgeInsets.symmetric(
                                  horizontal: 22.w,
                                  vertical: 14.h,
                                ),

                                decoration:
                                BoxDecoration(

                                  gradient:
                                  const LinearGradient(
                                    colors: [

                                      Color(0xFF2F66F6),

                                      Color(0xFF5A84FF),
                                    ],
                                  ),

                                  borderRadius:
                                  BorderRadius.circular(
                                      30.r),
                                ),

                                child: Row(

                                  mainAxisSize:
                                  MainAxisSize.min,

                                  children: [

                                    Icon(
                                      Icons.add_rounded,

                                      color:
                                      Colors.white,

                                      size: 20.sp,
                                    ),

                                    SizedBox(width: 8.w),

                                    Text(
                                      "Add Your First Driver",

                                      style:
                                      CustomTextTheme.bold(
                                        color:
                                        Colors.white,

                                        fontSize:
                                        14.sp,
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
                  );
                }

                /// =========================
                /// SEARCH EMPTY
                /// =========================

                if (controller
                    .filteredDrivers
                    .isEmpty) {

                  return SingleChildScrollView(
                    physics:
                    const BouncingScrollPhysics(),
                    child: SizedBox(
                      height:
                      MediaQuery.of(context)
                          .size
                          .height * 0.40,
                      child: Center(

                        child: Padding(

                          padding:
                          EdgeInsets.symmetric(
                            horizontal: 26.w,
                          ),

                          child: Column(

                            mainAxisAlignment:
                            MainAxisAlignment.center,

                            children: [

                              Container(

                                width: 120.w,
                                height: 120.w,

                                decoration:
                                BoxDecoration(

                                  shape:
                                  BoxShape.circle,

                                  gradient:
                                  LinearGradient(
                                    colors: [

                                      Colors.orange
                                          .withOpacity(
                                          0.12),

                                      Colors.orange
                                          .withOpacity(
                                          0.03),
                                    ],
                                  ),
                                ),

                                child: Icon(
                                  Icons.search_off_rounded,

                                  color:
                                  Colors.orange,

                                  size: 54.sp,
                                ),
                              ),

                              SizedBox(height: 28.h),

                              Text(
                                "No Driver Found",

                                textAlign:
                                TextAlign.center,

                                style:
                                CustomTextTheme.extraBold(
                                  color:
                                  Colors.black,

                                  fontSize:
                                  24.sp,
                                ),
                              ),

                              SizedBox(height: 10.h),

                              Text(
                                "No driver matched your search.\nTry searching with another name.",

                                textAlign:
                                TextAlign.center,

                                style:
                                CustomTextTheme.medium(
                                  color:
                                  Colors.black45,

                                  fontSize:
                                  14.sp,
                                ),
                              ),

                              SizedBox(height: 24.h),

                              Container(

                                padding:
                                EdgeInsets.symmetric(
                                  horizontal: 18.w,
                                  vertical: 10.h,
                                ),

                                decoration:
                                BoxDecoration(

                                  color:
                                  const Color(
                                      0xFFFFF3E5),

                                  borderRadius:
                                  BorderRadius.circular(
                                      30.r),
                                ),

                                child: Text(
                                  "\"${controller.searchText.value}\"",

                                  style:
                                  CustomTextTheme.bold(
                                    color:
                                    Colors.orange,

                                    fontSize:
                                    14.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                /// =========================
                /// DRIVER LIST
                /// =========================

                return ListView.builder(

                  physics:
                  const BouncingScrollPhysics(),

                  padding:
                  EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 16.h,
                  ),

                  itemCount:
                  controller
                      .filteredDrivers
                      .length,

                  itemBuilder:
                      (context, index) {

                    final driver =
                    controller
                        .filteredDrivers[index];

                    final status =
                    (driver["status"] ?? "")
                        .toString();

                    final isOnTrip =
                        status ==
                            "On Trip";

                    return Container(

                      margin:
                      EdgeInsets.only(
                        bottom: 18.h,
                      ),

                      padding:
                      EdgeInsets.all(
                          1.3.w),

                      decoration:
                      BoxDecoration(

                        gradient:
                        LinearGradient(

                          begin:
                          Alignment.topLeft,

                          end:
                          Alignment.bottomRight,

                          colors: [

                            const Color(
                                0xFF2F66F6)
                                .withOpacity(
                                0.22),

                            Colors.white,

                            const Color(
                                0xFF5A84FF)
                                .withOpacity(
                                0.10),
                          ],
                        ),

                        borderRadius:
                        BorderRadius.circular(
                            30.r),
                      ),

                      child: Container(

                        padding:
                        EdgeInsets.all(
                            18.w),

                        decoration:
                        BoxDecoration(

                          color:
                          Colors.white,

                          borderRadius:
                          BorderRadius.circular(
                              29.r),

                          boxShadow: [

                            BoxShadow(

                              color: isOnTrip

                                  ? const Color(
                                  0xFF2F66F6)
                                  .withOpacity(
                                  0.10)

                                  : Colors.black
                                  .withOpacity(
                                  0.04),

                              blurRadius:
                              18,

                              offset:
                              const Offset(
                                  0,
                                  8),
                            ),
                          ],
                        ),

                        child: Column(
                          children: [

                            /// TOP
                            Row(
                              children: [

                                /// AVATAR
                                Stack(
                                  children: [

                                    Container(

                                      width: 74.w,
                                      height: 74.w,

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

                                        borderRadius:
                                        BorderRadius.circular(
                                            24.r),
                                      ),

                                      child: Icon(
                                        Icons.person,

                                        color:
                                        Colors.white,

                                        size: 38.sp,
                                      ),
                                    ),

                                    Positioned(
                                      right: 0,
                                      bottom: 0,

                                      child: Container(

                                        width: 18.w,
                                        height: 18.w,

                                        decoration:
                                        BoxDecoration(

                                          color:
                                          const Color(
                                              0xFF15B86C),

                                          shape:
                                          BoxShape.circle,

                                          border: Border.all(
                                            color:
                                            Colors.white,

                                            width: 2,
                                          ),

                                          boxShadow: [

                                            BoxShadow(
                                              color:
                                              const Color(
                                                  0xFF15B86C)
                                                  .withOpacity(
                                                  0.45),

                                              blurRadius:
                                              10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(width: 16.w),

                                /// INFO
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                    children: [

                                      Text(
                                        driver["name"] ??
                                            "--",

                                        style:
                                        CustomTextTheme.bold(
                                          color:
                                          Colors.black,

                                          fontSize:
                                          18.sp,
                                        ),
                                      ),

                                      SizedBox(
                                          height:
                                          4.h),

                                      Text(
                                        driver["phone"] ??
                                            "--",

                                        style:
                                        CustomTextTheme.medium(
                                          color:
                                          Colors.black54,

                                          fontSize:
                                          13.sp,
                                        ),
                                      ),

                                      SizedBox(
                                          height:
                                          8.h),

                                      Container(

                                        padding:
                                        EdgeInsets.symmetric(
                                          horizontal:
                                          12.w,

                                          vertical:
                                          5.h,
                                        ),

                                        decoration:
                                        BoxDecoration(

                                          color: isOnTrip

                                              ? const Color(
                                              0xFFE8FFF1)

                                              : const Color(
                                              0xFFEEF3FF),

                                          borderRadius:
                                          BorderRadius.circular(
                                              30.r),
                                        ),

                                        child: Text(
                                          status,

                                          style:
                                          CustomTextTheme.bold(

                                            color: isOnTrip

                                                ? const Color(
                                                0xFF15B86C)

                                                : const Color(
                                                0xFF2F66F6),

                                            fontSize:
                                            11.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /// RATING
                                Column(
                                  children: [

                                    Icon(
                                      Icons.star_rounded,

                                      color:
                                      Colors.amber,

                                      size: 24.sp,
                                    ),

                                    SizedBox(
                                        height:
                                        2.h),

                                    Text(
                                      driver["rating"] ??
                                          "--",

                                      style:
                                      CustomTextTheme.bold(
                                        color:
                                        Colors.black,

                                        fontSize:
                                        15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 18.h),

                            Divider(
                              color:
                              Colors.black12,
                            ),

                            SizedBox(height: 16.h),

                            /// DETAILS
                            Row(
                              children: [

                                Expanded(
                                  child: _InfoCard(
                                    title:
                                    "Truck",

                                    value:
                                    driver["truck"] ??
                                        "--",

                                    icon:
                                    Icons
                                        .local_shipping_rounded,
                                  ),
                                ),

                                SizedBox(width: 12.w),

                                Expanded(
                                  child: _InfoCard(
                                    title:
                                    "Experience",

                                    value:
                                    driver["experience"] ??
                                        "--",

                                    icon:
                                    Icons
                                        .workspace_premium_rounded,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopStatCard extends StatelessWidget {

  final String title;

  final String value;

  const _TopStatCard({
    required this.title,

    required this.value,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
      EdgeInsets.symmetric(
        vertical: 14.h,
      ),

      decoration:
      BoxDecoration(

        color:
        Colors.white
            .withOpacity(0.12),

        borderRadius:
        BorderRadius.circular(
            22.r),
      ),

      child: Column(
        children: [

          Text(
            value,

            style:
            CustomTextTheme.extraBold(
              color:
              Colors.white,

              fontSize:
              22.sp,
            ),
          ),

          SizedBox(height: 4.h),

          Text(
            title,

            style:
            CustomTextTheme.medium(
              color:
              Colors.white70,

              fontSize:
              12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {

  final String title;

  final String value;

  final IconData icon;

  const _InfoCard({
    required this.title,

    required this.value,

    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
      EdgeInsets.all(14.w),

      decoration:
      BoxDecoration(

        color:
        const Color(0xFFF7F9FF),

        borderRadius:
        BorderRadius.circular(
            20.r),
      ),

      child: Column(
        children: [

          Icon(
            icon,

            color:
            const Color(0xFF2F66F6),

            size: 24.sp,
          ),

          SizedBox(height: 8.h),

          Text(
            value,

            textAlign:
            TextAlign.center,

            style:
            CustomTextTheme.bold(
              color:
              Colors.black,

              fontSize:
              14.sp,
            ),
          ),

          SizedBox(height: 4.h),

          Text(
            title,

            style:
            CustomTextTheme.medium(
              color:
              Colors.black54,

              fontSize:
              12.sp,
            ),
          ),
        ],
      ),
    );
  }
}