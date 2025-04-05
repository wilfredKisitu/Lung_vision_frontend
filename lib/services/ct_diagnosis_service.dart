import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:lungv_app/models/ct_diagnosis.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CtDiagnoseService {
  final String _url = "http://159.89.32.143:3000";

  Future<CtDiagnoseResult?> uploadCtImage(File imageFile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = int.tryParse(prefs.getString('userId') ?? '0');
      // final token = prefs.getString('tokenAccess') ?? '';

      // Prepare the image file for upload
      final mimeType = lookupMimeType(imageFile.path);
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$_url/ctDiagnose/upload/$userId'),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        ),
      );

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        final json = jsonDecode(responseData);
        final result = CtDiagnoseResult.fromJson(json);
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
