import 'package:flutter/material.dart';
import 'package:lungv_app/Themes/text_styles.dart';

class CountWithUnit extends StatelessWidget {
  final dynamic count;
  final String unit;

  const CountWithUnit({super.key, required this.count, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('$count', style: AppTextStyles.heading3),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(unit, style: AppTextStyles.normal14),
        ),
      ],
    );
  }
}
