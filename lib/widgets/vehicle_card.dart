import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transport_wala/utility/utility.dart';

import '../resources/text_styes/custome_text.dart';

class VehicleCard extends StatelessWidget {

  final String image;

  final String truckName;

  final String truckNumber;

  final String tyre;

  final String power;

  final String mileage;

  final String weight;

  final VoidCallback? onTap;

  const VehicleCard({
    super.key,
    required this.image,
    required this.truckName,
    required this.truckNumber,
    required this.tyre,
    required this.power,
    required this.mileage,
    required this.weight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: EdgeInsets.only(
        bottom: 16.h,
      ),

      padding: EdgeInsets.all(16.w),

      decoration: BoxDecoration(
        color: Colors.grey.shade100,

        borderRadius:
        BorderRadius.circular(18.r),

        boxShadow: [

          BoxShadow(
            color: Colors.black.withOpacity(0.04),

            blurRadius: 14,

            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: IntrinsicHeight(

        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.stretch,

          children: [


            ClipRRect(
              borderRadius:
              BorderRadius.circular(14.r),

              child: image.isEmpty

                  ? Container(
                width: 110.w,

                color: Colors.grey.shade300,

                child: Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,

                    color: Colors.grey.shade500,

                    size: 34.sp,
                  ),
                ),
              )

                  : Image.asset(
                image,

                width: 110.w,

                fit: BoxFit.cover,

                errorBuilder:
                    (context, error, stackTrace) {

                  return Container(
                    width: 110.w,

                    color: Colors.grey.shade300,

                    child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,

                        color: Colors.grey.shade500,

                        size: 34.sp,
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(width: 14.w),

            /// =====================
            /// DETAILS
            /// =====================

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  /// TOP ROW
                  Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              truckName.trim().isEmpty
                                  ? "Unknown Truck"
                                  : truckName,

                              maxLines: 1,

                              overflow:
                              TextOverflow.ellipsis,

                              style:
                              CustomTextTheme.bold(
                                color: Colors.black,
                                fontSize: 18.sp,
                              ),
                            ),

                            Text(
                              truckNumber.trim().isEmpty
                                  ? "Not Available"
                                  : truckNumber,

                              style:
                              CustomTextTheme.bold(
                                color:
                                const Color(0xFF2F66F6),

                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: onTap,

                        child: Container(
                          width: 30.w,
                          height: 30.w,

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            border: Border.all(
                              color:
                              const Color(0xFF2F66F6),

                              width: 2,
                            ),
                          ),

                          child: Icon(
                            Icons.arrow_forward_rounded,

                            color:
                            const Color(0xFF2F66F6),

                            size: 18.sp,
                          ),
                        ),
                      ),
                    ],
                  ),

                  hGap(6.h),

                  /// =====================
                  /// INFO GRID
                  /// =====================

                  Row(
                    children: [

                      Expanded(
                        child: _InfoItem(
                          title: "Number of Tyre",
                          value: tyre,
                        ),
                      ),

                      Expanded(
                        child: _InfoItem(
                          title: "Power",
                          value: power,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 4.h),

                  Row(
                    children: [

                      Expanded(
                        child: _InfoItem(
                          title: "Mileage",
                          value: mileage,
                        ),
                      ),

                      Expanded(
                        child: _InfoItem(
                          title: "GVW / GCW (Kgs)",
                          value: weight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ===============================
/// INFO ITEM
/// ===============================

class _InfoItem extends StatelessWidget {

  final String title;

  final String value;

  const _InfoItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Text(
          title,

          style: CustomTextTheme.medium(
            color: Colors.black45,
            fontSize: 12.sp,
          ),
        ),

        SizedBox(height: 1.h),

        Text(
          value.trim().isEmpty
              ? "--"
              : value,

          style: CustomTextTheme.bold(
            color: Colors.black,
            fontSize: 17.sp,
          ),
        ),
      ],
    );
  }
}