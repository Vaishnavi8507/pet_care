// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obsText;
  final TextEditingController controller;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final FocusNode? focusNode;
  const MyTextField({
    Key? key,
    required this.hintText,
    required this.obsText,
    required this.controller,
    required this.margin,
    required this.padding,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        margin: margin,
        child: TextField(
          controller: controller,
          obscureText: obsText,
          focusNode: focusNode,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
              fillColor: Theme.of(context).colorScheme.secondary,
              filled: true,
              hintText: hintText,
              hintStyle:
                  TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
      ),
    );
  }
}
