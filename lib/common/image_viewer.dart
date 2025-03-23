import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkImageDisplay extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double borderRadius; // Added borderRadius parameter

  const NetworkImageDisplay({
    super.key,
    required this.imageUrl,
    this.width = 350.0,
    this.height = 390.0,
    this.borderRadius = 5, // Default border radius value
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        borderRadius,
      ), // Apply border radius here
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        placeholder:
            (context, url) => Container(
              width: width,
              height: height,
              color: Colors.grey[200],
              child: Icon(Icons.image, size: 50, color: Colors.grey[500]),
            ),
        errorWidget:
            (context, url, error) => Container(
              width: width,
              height: height,
              color: Colors.grey[200],
              child: Icon(Icons.error, size: 50, color: Colors.red),
            ),
        fit: BoxFit.cover,
      ),
    );
  }
}
