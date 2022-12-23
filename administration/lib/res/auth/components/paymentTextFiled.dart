

import 'package:flutter/material.dart';

class PaymenttextFiled extends StatelessWidget {
  const PaymenttextFiled({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white70),
      decoration: InputDecoration(

        hintText: hintText,
        filled: true,
        hintStyle: TextStyle(color: Colors.white70),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white70), //<-- SEE HERE
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide:  BorderSide(width: 1, color: Colors.white70), //<-- SEE HERE
        ),
        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
