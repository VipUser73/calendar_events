import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({required this.press, super.key});

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: press,
          splashRadius: 20,
          icon: const Icon(
            Icons.calendar_month,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
