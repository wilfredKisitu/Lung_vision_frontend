import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final String imagePath;
  final double size;
  final bool hasBorder;

  const UserProfile({
    super.key,
    required this.imagePath,
    this.size = 120, // Default size
    this.hasBorder = false, // Optionally add a border
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
            hasBorder
                ? Border.all(color: Colors.blueAccent, width: 3)
                : null, // Add border if needed
      ),
      child: ClipOval(
        child:
            imagePath.isNotEmpty
                ? Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _placeholder(); // Show placeholder on error
                  },
                )
                : _placeholder(), // Show placeholder if imagePath is empty
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey[300],
      child: Icon(Icons.person, size: size * 0.6, color: Colors.grey),
    );
  }
}
