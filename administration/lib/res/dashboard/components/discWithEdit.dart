import 'package:flutter/material.dart';

class DiscWithEdit extends StatefulWidget {
  final bool withButton;
  final String title;
  final value;
  final btnValue;
  final ontap;
  final withEdit;
  final onChanged;
  final cantEdit;
  final Widget? trailing;
  const DiscWithEdit(
      {Key? key,
      this.withButton = false,
      required this.title,
      this.value,
      this.btnValue,
      this.ontap,
      this.withEdit = false,
      this.onChanged,
      this.cantEdit = false, this.trailing})
      : super(key: key);

  @override
  State<DiscWithEdit> createState() => _DiscWithEditState();
}

class _DiscWithEditState extends State<DiscWithEdit> {
  late FocusNode myFocusNode;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.text.isEmpty) {
      controller.text = widget.value;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(5)),
        height: 200,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(

              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                if(widget.trailing != null)
                  widget.trailing!,
                if (widget.withEdit && widget.trailing == null)
                  InkWell(
                      onTap: () {
                        setState(() {
                          myFocusNode.requestFocus();
                        });
                      },
                      child: const Icon(Icons.edit))
              ],
            ),
            TextField(
              readOnly: myFocusNode.hasFocus == false,
              maxLines: 3,
              focusNode: myFocusNode,
              style: const TextStyle(fontSize: 18),
              onChanged: widget.onChanged,
              controller: controller,
              decoration: InputDecoration(
                hintText: widget.value,
                border: InputBorder.none,
              ),
            ),
            const Spacer(),

            if (widget.withButton)
              Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                      onPressed: () {
                        myFocusNode.unfocus();
                        if(widget.ontap != null) {
                          widget.ontap();
                        }
                        setState(() {});
                      },
                      child: Text(
                        widget.btnValue ?? 'Confirmer',
                        style: const TextStyle(color: Colors.black87),
                      )))
          ],
        ),
      ),
    );
  }
}





