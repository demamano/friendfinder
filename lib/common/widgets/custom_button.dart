import 'package:flutter/material.dart';
import 'package:friendfinder/colors.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: textColor,
          minimumSize: const Size(double.infinity, 55.0)),
      child: Text(
        text,
        style: const TextStyle(color: backgroundColor,fontSize: 16.0),
      ),
    );
  }
}
