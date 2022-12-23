import 'dart:async';

import 'package:alectron/res/Auth/utils/auth.dart';
import 'package:alectron/res/dashboard/modals/userModal.dart';
import 'package:alectron/res/dashboard/utils/dashboardUtils.dart';
import 'package:flutter/material.dart';
import 'package:alectron/res/Auth/components/textstyle.dart';
import 'package:alectron/res/dashboard/components/drawer.dart';
import 'package:alectron/res/dashboard/components/numbersCard.dart';

class Tableaudebord extends StatefulWidget {
  const Tableaudebord({Key? key}) : super(key: key);

  @override
  State<Tableaudebord> createState() => _TableaudebordState();
}

class _TableaudebordState extends State<Tableaudebord> {
  List users = [];
  List subscriptions = [];
  @override
  void initState() {
    DashboardUtils().getTotalUsers().then((value){users = value.docs.toList();
      if(mounted){
        setState(() {

        });
      }
    });
    DashboardUtils().getSubscriptions().then((value){subscriptions = value.docs.toList();
    if(mounted){
      setState(() {

      });
    }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), //
        child: Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/logo.png',width: 200,height: 100,
                ),
              ),

            ],
          ),

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
                selectedPage: 'Tableaudebord',
              ),
              Expanded(
                child: Container(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children:  [
                      NumberCard(
                        topic: 'Nombre d’utilisateurs',
                        number: users.length.toString(),
                        isCountrySelector : true,
                        cities: const ['Dummy City',],
                        countries: const ['Côte d’Ivoire'],

                      ),
                       NumberCard(
                        topic: 'Souscription',
                        number: subscriptions.length.toString() + ' FCFA', isCountrySelector : true,
                        cities: ['Dummy City',],
                        countries: ['Côte d’Ivoire'],
                        isDatePicker: true,
                      ),
                      // NumberCard(
                      //   topic: 'Total Available Money',
                      //   number: '1000 USD', isCountrySelector : true,
                      //   cities: ['Dummy City',],
                      //   countries: ['Dummy Country'],
                      // ),
                      // NumberCard(
                      //   topic: 'Money Available Now',
                      //   number: '300 USD', isCountrySelector : true,
                      //   cities: ['Dummy City',],
                      //   countries: ['Dummy Country'],
                      // ),
                      // NumberCard(
                      //   topic: 'Total Transaction Amount',
                      //   number: '300 USD', isCountrySelector : true,isDatePicker: true,
                      //   cities: ['Dummy City',],
                      //   countries: ['Dummy Country'],
                      // ),
                      // NumberCard(
                      //   topic: 'Total Profit of Helico Cash',
                      //   number: '300 USD', isCountrySelector : true,isDatePicker: true,
                      //   cities: ['Dummy City',],
                      //   countries: ['Dummy Country'],
                      // ),
                      // NumberCard(
                      //   topic: 'Payers available now',
                      //   number: '300', isCountrySelector : true,
                      //   cities: ['Dummy City',],
                      //   countries: ['Dummy Country'],
                      // ),
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
