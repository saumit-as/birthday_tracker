import 'package:birthday_tracker/constants.dart';
import 'package:birthday_tracker/models/birthday_information.dart';
import 'package:flutter/material.dart';

class BirthdayInfoCard extends StatelessWidget {
  const BirthdayInfoCard({
    Key? key,
    required this.birthdayInfo,
    required this.index,
  }) : super(key: key);

  final BirthdayInfo birthdayInfo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 84,
        width: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            birthdayInfo.name,
            style: nameStyle,
          ),
        ),
      ),
      SizedBox(
        height: 10,
      )
    ]);
  }
}
