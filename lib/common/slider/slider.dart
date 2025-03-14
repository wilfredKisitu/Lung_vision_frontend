import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'slider_provider.dart';

class CustomSlider extends ConsumerWidget {
  final double maxRange;

  const CustomSlider({super.key, required this.maxRange});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double sliderValue = ref.watch(sliderProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Display Current Value
        Text(
          sliderValue.toStringAsFixed(1),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        // Slider Widget
        Slider(
          value: sliderValue,
          min: 0,
          max: maxRange,
          divisions: maxRange.toInt(),
          label: sliderValue.toStringAsFixed(1),
          onChanged: (double newValue) {
            ref.read(sliderProvider.notifier).state = newValue;
          },
        ),
      ],
    );
  }
}
