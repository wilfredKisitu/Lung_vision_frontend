import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lungv_app/Themes/colors.dart';
import 'package:lungv_app/Themes/text_styles.dart';
import 'package:lungv_app/common/Constants/image_paths.dart';
import 'package:lungv_app/common/count_with_unit.dart';
import 'package:lungv_app/common/image_viewer.dart';

class CtDetailsScreen extends ConsumerWidget {
  final String imageUrl;
  final String prediction;
  final double confidence;
  const CtDetailsScreen({
    super.key,
    required this.imageUrl,
    required this.prediction,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(
                'CT Details',
                style: AppTextStyles.navType1,
              ), // Dynamic title
              centerTitle: true,
              backgroundColor:
                  innerBoxIsScrolled
                      ? AppColor.primaryWhite
                      : AppColor.primaryGray,
              elevation: innerBoxIsScrolled ? 1 : 1,
              scrolledUnderElevation: 0,
              toolbarHeight: 60,
              floating: false,
              pinned: true,
              leading: IconButton(
                onPressed: () {
                  context.go('/main');
                },
                icon: Icon(Icons.chevron_left),
              ),
            ),
          ];
        },
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CT diagnosis results
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CountWithUnitResult(
                              count: 'CT Diagnosis',
                              unit: 'Result',
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Text(
                                // _formatDate(diagnosis.createdAt.toString()),
                                '12 Feb, 2025',
                                style: AppTextStyles.normal14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    // **Image**
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Image.asset(
                        'assets/images/ct_scan.png',
                        height: 100,
                      ),
                    ),
                  ],
                ),
                // Diagnosed with
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 20,
                  ),
                  child: Text('Diagnosed With'),
                ),
                // Result
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 20,
                  ),
                  child: Text(
                    prediction.toUpperCase(),
                    style: AppTextStyles.headingTypeVar4,
                  ),
                ),

                // Image loader
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: NetworkImageDisplay(imageUrl: imageUrl)),
                ),
                // Confidence
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Text('Confidence', style: AppTextStyles.normal14),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/confidence.png', height: 80),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Text(
                          (confidence * 100).toString(),
                          style: AppTextStyles.headingTypeVar7,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// formart data
// String _formatDate(String? dateString) {
//   if (dateString == null || dateString.isEmpty) {
//     return 'Unknown Date';
//   }

//   try {
//     final DateTime parsedDate = DateTime.parse(dateString);
//     return DateFormat('d MMM, yyyy').format(parsedDate);
//   } catch (e) {
//     return 'Invalid Date';
//   }
// }
