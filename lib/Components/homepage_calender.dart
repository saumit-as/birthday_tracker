import 'package:flutter/material.dart';

class HomePageCalender extends StatelessWidget {
  const HomePageCalender({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        // color: Colors.white,
        height: 162,
      ),
    );
  }
}
