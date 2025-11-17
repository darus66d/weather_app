import 'package:flutter/material.dart';
import 'package:weather_app/data/app_text_style.dart';

class PrimaryButton extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final Color color;
  final Color? borderColor;
  final String title;
  final TextStyle? textStyle;
  final Function()? onTap;


  const PrimaryButton({super.key, required this.height, required this.width, required this.radius, required this.color, required this.title, this.textStyle, this.onTap, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
          )
        ),
        child: Center(
          child: Text(
            title,
            style: textStyle ?? AppTextstyle.textStyle22WideW300,
          ),
        ),
      ),
    );
  }
}
