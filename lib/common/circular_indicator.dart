import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungv_app/Themes/colors.dart';
import 'package:lungv_app/common/slider/slider_provider.dart';

class DashedArcPainter extends CustomPainter {
  final double radius = 120; // Radius of the circle
  final double startAngle = 141.05 * (pi / 180); // Start angle in radians
  final double sweepAngle =
      (72.06 / 100) * 2 * pi; // Convert percentage to radians
  final double strokeWidth = 45; // Stroke width
  final double dashSize = 1; // Dash segment size
  final double dashSpacing = 10; // Spacing between dashes

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = AppColor.primaryBlack
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt; // Ensure dashes are clearly separated

    final Offset center = Offset(size.width / 2, size.height / 2);
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    // Total number of dashes that can fit in the arc
    double totalArcLength = radius * sweepAngle;
    double dashWithSpace = dashSize + dashSpacing;
    int dashCount = (totalArcLength / dashWithSpace).floor();

    for (int i = 0; i < dashCount; i++) {
      double dashStartAngle = startAngle + i * dashWithSpace / radius;
      canvas.drawArc(
        rect,
        dashStartAngle,
        dashSize / radius, // Convert linear dash size to angular size
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Arc with stacked count with units
class ArcWithCenteredCount extends ConsumerWidget {
  final String unit;

  const ArcWithCenteredCount({super.key, required this.unit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double sliderValue = ref.watch(sliderProvider);

    return Stack(
      alignment: Alignment.center,
      children: [
        // Dashed Arc
        SizedBox(
          width: 250, // Adjusting size for better proportions
          height: 250,
          child: CustomPaint(painter: DashedArcPainter()),
        ),

        // Count & Unit in Center
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${sliderValue.toInt()}',
              style: const TextStyle(
                fontSize: 40, // Large count
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                unit,
                style: const TextStyle(
                  fontSize: 18, // Smaller unit
                  fontWeight: FontWeight.normal,
                  color: Colors.grey, // Slightly lighter for contrast
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
