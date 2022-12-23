import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final onTap;
  final title;
  final leading;
  const SubmitButton({Key? key, this.onTap, this.title = 'Confirmer', this.leading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration( color: Colors.indigo,
          borderRadius: BorderRadius.circular(10)
        ),

        child:  Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(leading != null)
                Image.asset(leading,width: 30,),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(title,style: TextStyle(color: Colors.white70,fontSize: 20),),
              ),
            ],
          ),
        ),
      )
    );
  }
}
