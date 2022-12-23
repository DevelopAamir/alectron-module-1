import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function(String)? onChanged;
  final bool validity;
  const AuthTextField({Key? key, required this.hintText, required this.icon, this.onChanged, this.validity = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffD2D2D2),
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: Color(0xffD2D2D2),
                child:  Icon(icon, color: Colors.grey,size: 35,),
                height: 70,
              )),
           SizedBox(width: 10,),
            Expanded(
            flex: 5,
            child: TextField(
              onChanged: onChanged,
              style: TextStyle(color: Colors.white70),
              decoration: InputDecoration(
                errorText: validity?'Field is required': null,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.white70)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
