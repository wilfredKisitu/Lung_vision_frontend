import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lungv_app/Themes/colors.dart';
import 'package:lungv_app/Themes/text_styles.dart';

class DateScroller extends StatelessWidget {
  const DateScroller({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    List<DateTime> dates = List.generate(7, (index) => today.subtract(Duration(days: 3 - index)));
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: dates.map((date) {
          bool isToday = date.day == today.day && date.month == today.month && date.year == today.year;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: isToday
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColor.primaryOrange,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Today ${DateFormat('dd, MMMM').format(date)}',
                      style: AppTextStyles.dateStyleWhite,
                    ),
                  )
                : Text(
                    DateFormat('dd').format(date),
                    style: AppTextStyles.dateStyleBlack,
                  ),
          );
        }).toList(),
      ),
    );
  }
}


