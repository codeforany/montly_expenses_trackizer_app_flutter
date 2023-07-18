import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class IconItemRow extends StatelessWidget {
  final String title;
  final String icon;
  final String value;
  const IconItemRow(
      {super.key,
      required this.title,
      required this.icon,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 20,
            height: 20,
            color: TColor.gray20,
          ),
          const SizedBox(
            width: 15,
          ),
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

class IconItemSwitchRow extends StatelessWidget {
  final String title;
  final String icon;
  final bool value;
  final Function(bool) didChange;

  const IconItemSwitchRow(
      {super.key,
      required this.title,
      required this.icon,
      required this.didChange,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 20,
            height: 20,
            color: TColor.gray20,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: TextStyle(
                color: TColor.white, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          const SizedBox(
            width: 8,
          ),
          CupertinoSwitch(value: value, onChanged: didChange)
        ],
      ),
    );
  }
}
