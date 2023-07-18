import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class ItemRow extends StatelessWidget {
  final String title;
  final String value;
  const ItemRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: TColor.white, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: TColor.gray30,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Image.asset("assets/img/next.png",
              width: 12, height: 12, color: TColor.gray30)
        ],
      ),
    );
  }
}