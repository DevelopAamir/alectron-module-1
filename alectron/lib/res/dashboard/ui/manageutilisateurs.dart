import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:alectron/res/dashboard/components/drawer.dart';

class Manageutilisateurs extends StatefulWidget {
  final id;
  const Manageutilisateurs({Key? key, this.id}) : super(key: key);

  @override
  State<Manageutilisateurs> createState() => _ManageutilisateursState();
}

class _ManageutilisateursState extends State<Manageutilisateurs> {
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: widget.id == null
            ? Container()
            : Container(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/logo.png',
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                  ],
                ),
                height: 250,
                decoration: const BoxDecoration(
                    color: Colors.black87,
                    boxShadow: [BoxShadow(color: Colors.grey)]),
              ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomDrawer(
                selectedPage: 'Gestiondesutilisateurs',
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: StreamBuilder(
                            stream: firestore
                                .collection('Users')
                                .doc(widget.id)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<
                                        DocumentSnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              return !snapshot.hasData
                                  ? Container()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 35,
                                        ),
                                        Text(
                                          'Nom Complet : '+ snapshot.data!['name'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'ID : ${snapshot.data!['ID']}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        if (snapshot.data!
                                            .data()!
                                            .containsKey('email'))
                                        Text(
                                          'WN: ${snapshot.data!['whatsapp']}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white70),
                                        ),
                                        if (!snapshot.data!
                                            .data()!
                                            .containsKey('email'))
                                          Text(
                                            'NT: ${snapshot.data!['whatsapp']}',
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white70),
                                          ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        if (snapshot.data!
                                            .data()!
                                            .containsKey('email'))
                                          Text(
                                            'Email: ${snapshot.data!['email']}',
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white70),
                                          ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        StreamBuilder(
                                            stream: firestore
                                                .collection('Habitations')
                                                .doc(widget.id)
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<
                                                        DocumentSnapshot<
                                                            Map<String,
                                                                dynamic>>>
                                                    habitations) {
                                              return !habitations.hasData
                                                  ? Container()
                                                  : DiscWithEdit(
                                                      title: 'Habitation',
                                                      withButton: true,
                                                      value: habitations
                                                              .data!.exists
                                                          ? habitations.data![
                                                              'habitaion']
                                                          : '',
                                                      onChanged: (a) {
                                                        if (habitations
                                                            .data!.exists) {
                                                          habitations
                                                              .data!.reference
                                                              .update({
                                                            'habitaion': a
                                                          });
                                                        } else {
                                                          habitations
                                                              .data!.reference
                                                              .set({
                                                            'habitaion': a
                                                          });
                                                        }
                                                      },
                                                    );
                                            }),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        StreamBuilder(
                                            stream: firestore
                                                .collection('Messages')
                                                .orderBy('date', descending: false)
                                                .snapshots(),
                                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              int index = 0;
                                              return Column(
                                                  children: snapshot.hasData
                                                      ? snapshot.data!.docs
                                                      .where((element) =>
                                                  element['ID'] ==
                                                      widget.id &&
                                                      element['selection_type'] ==
                                                          'active').isEmpty
                                                      ? [
                                                    AlertsBox(
                                                      height: 200,
                                                      title: 'Alerte Déplacement',
                                                      child: Text(''),
                                                      trailing: Container(),
                                                    )
                                                  ]
                                                      : snapshot.data!.docs
                                                      .where((element) =>
                                                  element['ID'] ==
                                                      widget.id &&
                                                      element['selection_type'] ==
                                                          'active')
                                                      .map((e) {
                                                    index++;
                                                    return AlertsBox(
                                                      height: index == 1 ? 180 : null,
                                                      title: 'Alerte Déplacement',
                                                      child: Text(e['description']),
                                                      trailing: InkWell(
                                                          onTap: () {
                                                            e.reference.delete();
                                                          },
                                                          child: Icon(Icons.close)),
                                                    );
                                                  }).toList()
                                                      : []);
                                            }),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        StreamBuilder(
                                            stream: firestore
                                                .collection('Messages')
                                                .orderBy('date', descending: false)
                                                .snapshots(),
                                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              int index = 0;
                                              return Column(
                                                  children: snapshot.hasData
                                                      ? snapshot.data!.docs
                                                      .where((element) =>
                                                  element['ID'] ==
                                                      widget.id &&
                                                      element['selection_type'] ==
                                                          'Inactive').isEmpty
                                                      ? [
                                                    AlertsBox(
                                                      height: 200,
                                                      title: 'Alectron Alertes',
                                                      child: Text(''),
                                                      trailing: Container(),
                                                    )
                                                  ]
                                                      : snapshot.data!.docs
                                                      .where((element) =>
                                                  element['ID'] ==
                                                      widget.id &&
                                                      element['selection_type'] ==
                                                          'Inactive')
                                                      .map((e) {
                                                    index++;
                                                    return AlertsBox(
                                                      height: index == 1 ? 180 : null,
                                                      title: 'Alectron Alertes',
                                                      child: Text(e['description']),
                                                      trailing: InkWell(
                                                          onTap: () {
                                                            e.reference.delete();
                                                          },
                                                          child: Icon(Icons.close)),
                                                    );
                                                  }).toList()
                                                      : []);
                                            }),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        const DiscWithEdit(
                                          withButton: true,
                                          title: 'Souscription (Mai 2022) ',
                                          value: '0 0 0 0 0 FCFA',
                                        )
                                      ],
                                    );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiscWithEdit extends StatefulWidget {
  final bool withButton;
  final String title;
  final value;
  final onChanged;
  const DiscWithEdit(
      {Key? key,
      this.withButton = false,
      required this.title,
      this.value,
      this.onChanged})
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
    if (widget.value != null) {
      controller.text = widget.value;
    }
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(5)),
      height: 180,
      width: 300,
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
            maxLines: 5,
            focusNode: myFocusNode,
            readOnly: !myFocusNode.hasFocus,
            controller: controller,
            style: const TextStyle(fontSize: 12),
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
                      if (widget.onChanged != null) {
                        widget.onChanged(controller.text);
                        setState(() {
                          myFocusNode.unfocus();
                        });
                      }
                    },
                    child: const Text(
                      'Confirmer',
                      style: TextStyle(color: Colors.black87),
                    )))
        ],
      ),
    );
  }
}





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

          width: 300,
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
