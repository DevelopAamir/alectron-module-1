import 'package:administration/res/constant.dart';
import 'package:flutter/material.dart';
class ProfileCard extends StatefulWidget {
  final bool withButton;

  final value;
  final data;
  const ProfileCard({Key? key,  this.withButton = false, this.value, this.data}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late FocusNode myFocusNode;

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration:  BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5)
        ),
        height: 200,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Row(
              children:  [
                Text(widget.data['name'],style:  const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87,),),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 20,),
            Text('ID : ${widget.data['ID']}',style: const TextStyle(color: primaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Text('Email : ${widget.data['email']}',style: const TextStyle(color: primaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Text('NW : ${widget.data['whatsapp']}',style: const TextStyle(color: primaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
            const Spacer(),
            if(widget.withButton)
              Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(onPressed: (){}, child: const Text('Confirmer',style: TextStyle(color: Colors.black87),)))
          ],
        ),
      ),
    );
  }
}



