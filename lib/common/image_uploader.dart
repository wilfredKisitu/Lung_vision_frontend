import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lungv_app/Themes/colors.dart';

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  ImageUploaderState createState() => ImageUploaderState();
}

class ImageUploaderState extends State<ImageUploader> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image Preview
        _selectedImage != null
            ? Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectedImage!,
                    width: 356,
                    height: 393,
                    fit: BoxFit.cover,
                  ),
                ),
            )
            : Center(
              child: Container(
                width: 356,
                height: 393,
                decoration: BoxDecoration(
                  color: AppColor.primaryGray,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                  child: Image.asset('assets/images/upload_image.png'))),
            ),
      ],
    );
  }
}
