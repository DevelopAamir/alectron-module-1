import 'package:flutter/material.dart';

class TileFile extends StatefulWidget {
  final text;
  final title;
  final readOnly;
  final onChange;
  TileFile({Key? key, this.text, this.title, this.readOnly = true, this.onChange}) : super(key: key);

  @override
  State<TileFile> createState() => _TileFileState();
}

class _TileFileState extends State<TileFile> {
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,style: TextStyle(color: Colors.white70,fontSize: 22,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white70
          ),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              readOnly: widget.readOnly ,
              controller: controller,
              onChanged: widget.onChange,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.text
              ),
            ),
          ),
        ),

      ],
    );
  }
}
