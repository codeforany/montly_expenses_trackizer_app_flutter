import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class SubScriptionCell extends StatelessWidget {
  final Map sObj;
  final VoidCallback onPressed;

  const SubScriptionCell(
      {super.key, required this.sObj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color: TColor.border.withOpacity(0.1),
          ),
          color: TColor.gray60.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        
          children: [
            Image.asset(
              sObj["icon"],
              width: 45,
              height: 45,
            ),
            const Spacer(),
            Text(
              sObj["name"],
              style: TextStyle(
                  color: TColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "\$${sObj["price"]}",
              style: TextStyle(
                  color: TColor.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
