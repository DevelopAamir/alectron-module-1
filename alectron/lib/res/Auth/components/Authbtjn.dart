

import 'package:alectron/res/Auth/components/textstyle.dart';
import 'package:alectron/res/constants.dart';
import 'package:flutter/material.dart';


class AuthButton extends StatelessWidget {
  final Function()? onTap;
  const AuthButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
      color: primaryColor,
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0,vertical: 15),
        child: Text('Connexion',style: btnTextstyle,),
      ),
    );
  }
}
