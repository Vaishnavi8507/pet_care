import 'package:flutter/material.dart';
class CustomToolTip extends StatelessWidget {
  final String? message;
  final String? additionalInfo;

  const CustomToolTip({
    Key? key,
    required this.message,
    required this.additionalInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message!,
      child: IconButton(
        icon: Icon(Icons.info_outlined),
        onPressed: () {
          // Handle onPressed action if needed
        },
      ),
    );
  }
}