import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class ImageButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  const ImageButton({super.key, required this.image, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: TColor.border.withOpacity(0.15),
          ),
          color: TColor.gray60.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Image.asset(image, width: 50, height: 50, color: TColor.gray70),
      ),
    );
  }
}
