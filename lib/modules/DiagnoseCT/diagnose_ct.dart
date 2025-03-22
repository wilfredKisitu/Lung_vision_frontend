import 'package:flutter/material.dart';
import 'package:lungv_app/Themes/text_styles.dart';
import 'package:lungv_app/common/custom_button.dart';
import 'package:lungv_app/common/image_uploader.dart';

class DiagnoseCt extends StatelessWidget {
  const DiagnoseCt({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text(
              'New CT Diagnosis', style: AppTextStyles.headingType1,
              ),
            ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20,),
          child: Text('Upload your CT scan for diagnois', style: AppTextStyles.normalType14,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: 
              Text(
                'Get to proactively know the variate of lung cancer your likely to have', 
                style: AppTextStyles.normalType14,),
              ),
          // image upload
          SizedBox(height: 30,),
          // Diagnose by ct
          ImageUploader(),
          // Scan for diagnosis
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
            child: CustomButton(text: 'Scan CT for Diagnosis', onPressed: (){
              // call the APi
            }),
          )
        ],
      ),
    ));
  }
}
