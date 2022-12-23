import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  final String title;
  final controller;
  const DescriptionTextField({Key? key, this.title = 'Description', this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white70, borderRadius: BorderRadius.circular(5)),
        child:  TextField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: title),
        ),
      ),
    );
  }
}
