import 'package:flutter/material.dart';

import '../constant.dart';

userId(uid){
  return 'CI' + uid.substring(0,8).toUpperCase();
}

spinner({child,visibility = false}) {
  return Stack(
    children: [
      if(!visibility)
      child,
      Visibility(visible: visibility,
        child: Container(
          height:double.infinity,
          width: double.infinity,

          color: primaryColor,
          child: Center(
            child: CircularProgressIndicator(color: Colors.white70,),
          ),
        ),
      )
    ],
  );
}

toast(msg){
  print(msg);
}