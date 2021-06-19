import 'package:flutter/material.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 45,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25.0,
          ),
        ),
      ],
    );
  }
}
