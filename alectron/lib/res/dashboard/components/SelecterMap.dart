import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gg;
import '../ui/location.dart';



class SelecterMap extends StatelessWidget {
  const SelecterMap({Key? key}) : super(key: key);

    Widget getMap(context) {
    String htmlId = "7";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final mapOptions = MapOptions()
      ..center = LatLng(0,0)
        ..zoom = 4;


      final elem = DivElement()

        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';
      final map = GMap(elem, mapOptions);

      // ignore: avoid_single_cascade_in_expression_statements
      map
        ..onClick.listen((event) {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationTrace(
                  position: gg.LatLng(event.latLng!.toJSON()!.lat!.toDouble(),event.latLng!.toJSON()!.lng!.toDouble()),
                ),
              ),
            );
          }
          // widget.onMapClick(event.latLng, map.zoom);
        );
      return elem;
    });

    return HtmlElementView(viewType: htmlId);
  }

  String getWindow(
    name,
    id,
    nt,
  ) {
    return '''
    <div style="padding: 10px; display: flex; flex-direction: column; color: black">
        <H5 style="margin: 0px">Nom Complet : ${name}</H5>
        <H5 style="margin: 0px">Id : ${id}</H5>
        <H5 style="margin: 0px">NT : ${nt}</H5>

    </div>
''';
  }

  @override
  Widget build(BuildContext context) {
    return getMap(context);
  }
}
