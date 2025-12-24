import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OffersGridScreen extends StatelessWidget {
  const OffersGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ডামি ডেটা লিস্ট
    final List<Map<String, String>> offers = [
      {"name": "Jumeirah One", "desc": "Buy 1 Get 1 Free at Brunch", "image": "assets/images/food.png"},
      {"name": "Al Tayer", "desc": "FOC Oil and Filter Change...", "image": "assets/images/car.png"},
      {"name": "Nandos", "desc": "2-4-1", "image": "assets/images/nandos.png"},
      {"name": "Beauty Salon", "desc": "Buy 1 Get 1 Free", "image": "assets/images/salon.png"},
      {"name": "Next", "desc": "Buy 1 Get 1 Free", "image": "assets/images/next.png"},
      {"name": "Beauty Salon", "desc": "Buy 1 Get 1 Free", "image": "assets/images/salon2.png"},
    ];

    return GridView.builder(
      shrinkWrap: true, // যদি স্ক্রল ভিউর ভেতরে থাকে
      physics: const NeverScrollableScrollPhysics(), // যদি প্যারেন্ট স্ক্রল হয়
      padding: EdgeInsets.all(16.w),
      itemCount: offers.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // প্রতি সারিতে ২টা কার্ড
        crossAxisSpacing: 12.w, // পাশাপাশি গ্যাপ
        mainAxisSpacing: 12.h, // উপর-নিচ গ্যাপ
        childAspectRatio: 0.82, // কার্ডের উচ্চতা ও উইডথ এর অনুপাত (এটি এডজাস্ট করলে কার্ড বড়-ছোট হবে)
      ),
      itemBuilder: (context, index) {
        final item = offers[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ইমেজ এবং ডিসকাউন্ট ট্যাগ
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                    child: Image.asset(
                      item["image"]!,
                      height: 120.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        "30% Off",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // টেক্সট অংশ
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["name"]!,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A237E),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      item["desc"]!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        color: Colors.grey.shade600,
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
  }
}