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
        Text('$count'.toUpperCase(), style: AppTextStyles.headingType2),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(unit, style: AppTextStyles.normalType16),
        ),
      ],
    );
  }
}

class CountWithUnitHeader extends StatelessWidget {
  final dynamic count;
  final String unit;

  const CountWithUnitHeader({
    super.key,
    required this.count,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('$count'.toUpperCase(), style: AppTextStyles.headingTypeVar2),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(unit, style: AppTextStyles.normalType16),
        ),
      ],
    );
  }
}

class CountWithUnitResult extends StatelessWidget {
  final dynamic count;
  final String unit;

  const CountWithUnitResult({
    super.key,
    required this.count,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$count', style: AppTextStyles.headingTypeVar3),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(unit, style: AppTextStyles.headingTypeVar3),
        ),
      ],
    );
  }
}
