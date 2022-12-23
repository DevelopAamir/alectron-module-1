import 'package:flutter/material.dart';

class AlertsBox extends StatefulWidget {
  final bool withButton;
  final String title;
  final Widget child;
  final Widget trailing;
  final double? height;
  const AlertsBox(
      {Key? key, this.withButton = false, required this.title,required this.trailing, required this.child, this.height})
      : super(key: key);

  @override
  State<AlertsBox> createState() => _AlertsBoxState();
}

class _AlertsBoxState extends State<AlertsBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: widget.height,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(5)),
          
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                widget.trailing
              ],
            ),
            widget.child,
            SizedBox(height: 5,),
            
          ]),
        ));
  }
}
