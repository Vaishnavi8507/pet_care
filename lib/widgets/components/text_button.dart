import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry? borderRadius;
  final BorderSide? borderSide;
  final TextStyle? textStyle;
  final double? width;
  final Icon? icon;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(16),
    this.borderRadius,
    this.borderSide,
    this.textStyle,
    this.width,  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width, // Set the width of the container
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(15),
           // side: borderSide ?? BorderSide(color: Colors.black), // Default black border
          ),
        ),
        child: Text(
          text,
          style: textStyle?.merge(TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
              )) ??
              TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
              ),
        ),
      ),
    );
  }
}
