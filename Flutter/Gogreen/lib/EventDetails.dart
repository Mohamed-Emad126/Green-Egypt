import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class EventDetailsScreen extends StatefulWidget {
  final String eventId;

  const EventDetailsScreen({super.key, required this.eventId}); // 👈 تمرير eventId

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool _isInterested = false;

  // إرسال طلب POST للعلامة "مهتم"
  Future<void> markAsInterested(String eventId, BuildContext context) async {
    final url = Uri.parse('https://yourapi.com/api/events/$eventId/interested'); // 👈 غير الرابط هنا

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        setState(() {
          _isInterested = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Marked as interested')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to mark as interested')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(390, 844));
    final String eventId = widget.eventId; // 👈 استخدام الـ eventId الممرر

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left,
                          size: 45.w, color: const Color(0xFF013D26)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Event Details',
                      style: TextStyle(
                        color: const Color(0xFF003C26),
                        fontSize: 24.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  height: 210.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/img_43.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Plant 50 Tree Event',
                        style: TextStyle(
                          color: const Color(0xFF003C26),
                          fontSize: 28.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    GestureDetector(
                      onTap: () {
                        if (!_isInterested) {
                          markAsInterested(eventId, context);
                        }
                      },
                      child: Container(
                        width: 94.w,
                        height: 21.h,
                        decoration: ShapeDecoration(
                          color: _isInterested
                              ? const Color(0xFF147351)
                              : const Color(0xFFBACFCA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 1,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              _isInterested ? Icons.star : Icons.star_border,
                              color: const Color(0xFF013D26),
                              size: 12.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              _isInterested ? 'Interested!' : 'Interested',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF003C26),
                                fontSize: 12.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Icon(
                              Icons.arrow_drop_down,
                              color: const Color(0xFF013D26),
                              size: 16.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Container(
                      width: 7.w,
                      height: 7.h,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF147351),
                        shape: OvalBorder(),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Upcoming',
                      style: TextStyle(
                        color: const Color(0xFF147351),
                        fontSize: 18.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  'Join us for a tree planting event in Zagazig from Friday, July 20 to Saturday, July 21, 2026. Our goal is to plant 50 trees to support urban greening, improve air quality, and create a healthier environment for the community.',
                  style: TextStyle(
                    color: const Color(0xFF003C26),
                    fontSize: 16.sp,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 24.h),
                _buildDetailRow(
                  label: 'Date',
                  value: 'Friday, July 20 – Saturday, July 21, 2026',
                ),
                _buildDetailRow(
                  label: 'Time',
                  value: '9:00 AM – 1:00 PM',
                ),
                _buildDetailRow(
                  label: 'Location',
                  value: 'Salam Street, Zagazig, Sharkia, Egypt',
                ),
                _buildDetailRow(
                  label: 'Organizer',
                  value: 'GoGreen Admins',
                ),
                _buildDetailRow(
                  label: 'Attendees',
                  value: '120 interested. 100 going',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({required String label, required String value}) {
    return Column(
      children: [
        Divider(
          height: 1.h,
          color: const Color(0xFFDADADA),
        ),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100.w,
              child: Text(
                label,
                style: TextStyle(
                  color: const Color(0xFF709283),
                  fontSize: 16.sp,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: const Color(0xFF147351),
                  fontSize: 16.sp,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
