import 'package:flutter/material.dart';


class AuthField extends StatelessWidget {
  final String title;
  const AuthField({
    Key? key, required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child:  Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 8.0,vertical: 3),
        child:  TextField(
          decoration: InputDecoration(
            hintText: title,
            border: InputBorder.none,

          ),
        ),
      ),
    );
  }
}
