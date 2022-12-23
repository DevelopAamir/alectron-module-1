import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:alectron/res/dashboard/ui/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:ui' as ui;
import 'dart:html' as html;

class GoogleMaps extends StatefulWidget {
  final List markers;
  final Function(dynamic, num?) onMapClick;
  final num zoom;
  final onClickOnMarker;
  final List<QueryDocumentSnapshot<Object?>> activeUsers;
  final streamer;
  final Function(List)? onActiveUserSelected;
  final Function(List)? onInActiveUserSelected;
  const GoogleMaps(
      {Key? key,
      required this.markers,
      required this.onMapClick,
      required this.zoom,
      this.onClickOnMarker,
      required this.activeUsers,
      this.streamer,
      this.onActiveUserSelected,
      this.onInActiveUserSelected})
      : super(key: key);

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  late GoogleMapController googleMapController;
  List<Marker> markers = [];
  selection() {
    List activeSelectedUsers = [];
    List activeInSelectedUsers = [];
    activeInSelectedUsers.clear();
    activeSelectedUsers.clear();
    for (var element in widget.markers) {
      if (intersects(points, element['position'])) {
        activeInSelectedUsers.add(element);
      }
    }
    for (var element in widget.activeUsers) {
      GeoPoint po = element['current_location'];
      if (intersects(points, LatLng(po.latitude, po.longitude))) {
        activeSelectedUsers.add(element);
      }
    }
    widget.onActiveUserSelected!(activeSelectedUsers);
    widget.onInActiveUserSelected!(activeInSelectedUsers);
  }

  void addMarkers({onlyUpdateMarker = false}) async {
    int i = 3;

    var po = points[i];

    markers.insert(
      i,
      Marker(
          zIndex: 1,
          markerId: MarkerId(po.toString()),
          position: po,
          infoWindow: InfoWindow(title: po.toString()),
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(25, 25)), 'assets/move.png'),
          onTap: () {
            print(markers[i].position);
          },
          onDrag: (a) {
            selection();
            setState(() {
              points[i] = a;
              if (i == 3) {
                points[i - 1] = LatLng(points[i - 1].latitude, a.longitude);
                points[0] = LatLng(a.latitude, points[0].longitude);
              }
            });
          },
          draggable: true),
    );
    markers.insert(
      1,
      Marker(
          zIndex: 1,
          markerId: MarkerId('another point'),
          position: points[1],
          infoWindow: InfoWindow(title: po.toString()),
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(25, 25)), 'assets/move.png'),
          onDrag: (a) {
            selection();
            points[1] = a;
            points[0] = LatLng(points[0].latitude, a.longitude);
            points[2] = LatLng(a.latitude, points[2].longitude);
            setState(() {});
          },
          draggable: true),

    );

    if (mounted) {
      setState(() {});
    }
  }

  LatLng seslectionArea = LatLng(30,0);

  addSelecter()async{
    // markers.add(
    //   Marker(
    //
    //       markerId: MarkerId('selecter'),
    //       position: seslectionArea,
    //       onDrag: (a){
    //         setState(() {
    //           seslectionArea = a;
    //         });
    //       },
    //       icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(50, 50)), 'assets/addnew.png'),
    //       onTap: (){
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => LocationTrace(
    //               position: LatLng(seslectionArea.latitude, seslectionArea.longitude),
    //             ),
    //           ),
    //         );
    //       },
    //       draggable: true
    //   ),
    // );
    // setState(() {
    //
    // });
  }

  @override
  void initState() {
    addMarkers();
    addSelecter();


    for (var element in widget.markers) {
      setState(() {
        markers.add(Marker(
            zIndex: 1,
            markerId: MarkerId(markers.length.toString()),
            position: element['position'],
            onTap: () {},
            infoWindow: InfoWindow(
                title: 'Nom Complet : ' + element['user']['name'],
                snippet:
                    'ID : ${element['user']['ID']} \n NT :  ${element['user']['whatsapp']}')));
      });
    }

    widget.activeUsers.forEach((element) async {
      BitmapDescriptor img = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(50, 50)), 'assets/flag.png');

      markers.add(Marker(
          zIndex: 1,
          markerId: MarkerId(markers.length.toString()),
          position: LatLng(element['current_location'].latitude,
              element['current_location'].longitude),
          infoWindow: InfoWindow(
              title: 'Nom Complet : ' + element['name'],
              snippet: 'ID : ${element['ID']} \n NT :  ${element['whatsapp']}'),
          icon: img));
    });
    selection();


    super.initState();
  }

  List<LatLng> points = [
    LatLng(10, -10),
    LatLng(-10, -10),
    LatLng(-10, 10),
    LatLng(10, 10),
  ];
  getPolygon() {
    Polygon poly = Polygon(
        polygonId: PolygonId('polygone'),
        points: points,
        strokeWidth: 1,
        fillColor: Colors.red.withOpacity(.2));
    return poly;
  }

  num x = 0;
  num y = 0;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(

      onMapCreated: (con) {
        setState(() {
          googleMapController = con;
        });
      },
      markers: Set<Marker>.of(markers),
      polygons: Set<Polygon>.of([getPolygon()]),
      mapType: MapType.normal,
      initialCameraPosition:
          CameraPosition(target: widget.markers.first['position'], zoom: 4),
      onTap: (_) {
        Timer(Duration(milliseconds: 500), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationTrace(
                position: LatLng(_.latitude, _.longitude),
              ),
            ),
          );
        });
      },
    );
  }

  intersects(List<LatLng> points, LatLng point) {
    bool res = false;
    num smallerLat =
        getSmallerPoint(points.map((e) => e.latitude.toInt()).toList());
    num smallerLng =
        getSmallerPoint(points.map((e) => e.longitude.toInt()).toList());
    num largesLat =
        getLargesPoint(points.map((e) => e.latitude.toInt()).toList());
    num largesLng =
        getLargesPoint(points.map((e) => e.longitude.toInt()).toList());
    if (point.latitude > smallerLat &&
        point.latitude < largesLat &&
        point.longitude > smallerLng &&
        point.longitude < largesLng) {
      print('' +
          smallerLat.toString() +
          '  ' +
          largesLat.toString() +
          '  ' +
          smallerLng.toString() +
          ' ' +
          largesLng.toString());
      print(point);
    }

    return point.latitude > smallerLat &&
        point.latitude < largesLat &&
        point.longitude > smallerLng &&
        point.longitude < largesLng;
  }

  midOfRect() {
    num smallerLat =
        getSmallerPoint(points.map((e) => e.latitude.toInt()).toList());
    num smallerLng =
        getSmallerPoint(points.map((e) => e.longitude.toInt()).toList());
    num largesLat =
        getLargesPoint(points.map((e) => e.latitude.toInt()).toList());
    num largesLng =
        getLargesPoint(points.map((e) => e.longitude.toInt()).toList());

    return LatLng((smallerLat + largesLat) / 2, (smallerLng + largesLng) / 2);
  }

  num getSmallerPoint(List points) {
    num smaller = 10000000;
    points.forEach((element) {
      if (element < smaller) {
        smaller = element;
      }
    });
    return smaller;
  }

  num getLargesPoint(List points) {
    num largest = 0;
    points.forEach((element) {
      if (element > largest) {
        largest = element;
      }
    });
    return largest;
  }
}

occupied(latLng) {
  if (3.4887368693537475 > latLng.lat &&
      latLng.lat < -4.001875691802311 &&
      4.97866765735796 > latLng.lat &&
      latLng.lat < -2.3756001855319226) {
    print(true);
    return true;
  } else {}
}

// Latitude : -4.001875691802311 >

// Latitude : 3.4887368693537475> < -4.001875691802311
// Longitude : 4.97866765735796> < -2.3756001855319226

// Longitude : -2.3756001855319226 >

//   var map;
//   Widget getMap() {
//     String htmlId = "7";
//
//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
//       final mapOptions = MapOptions()
//         ..zoom = widget.zoom
//         ..center = widget.markers.last['position'];
//
//       final elem = DivElement()
//         ..id = htmlId
//         ..style.width = "100%"
//         ..style.height = "100%"
//         ..style.border = 'none';
//       final map = GMap(elem, mapOptions);
//       //ignore: avoid_single_cascade_in_expression_statements
//
//       if (widget.markers.isNotEmpty) {
//         widget.markers.forEach((e) {
//           LatLng mark = e['position'];
//           final marker = Marker(MarkerOptions()
//             ..position = e['position']
//             ..map = map
//             ..clickable = true);
//
//           final infoWindow = InfoWindow(InfoWindowOptions()
//             ..content = getWindow(
//                 e['user']['name'], e['user']['ID'], e['user']['whatsapp']));
//           marker.onMouseover.listen((event) {
//             infoWindow.open(map, marker);
//           });
//         });
//       }
//       widget.activeUsers.forEach((e) {
//         e.reference.snapshots().listen((event) {
//           print(event);
//           GeoPoint po = event['current_location'];
//           LatLng mark = LatLng(po.latitude, po.longitude);
//           final marker = Marker(MarkerOptions()
//             ..position = LatLng(po.latitude, po.longitude)
//             ..map = map
//             ..visible = e['available']
//             ..clickable = true
//             ..icon =
//                 'https://firebasestorage.googleapis.com/v0/b/alect-ron.appspot.com/o/flag.png?alt=media&token=f79bbb04-5117-43a9-98a8-1299a2221d00');
//           marker.onClick.listen((event) {});
//
//           final infoWindow = InfoWindow(InfoWindowOptions()
//             ..content =
//                 getWindow(event['name'], event['ID'], event['whatsapp']));
//           marker.onMouseover.listen((event) {
//             infoWindow.open(map, marker);
//           });
//         });
//       });
//       final poly = Rectangle(RectangleOptions()
//         ..map = map
//         ..bounds = LatLngBounds(
//           LatLng(widget.activeUsers.first['current_location'].latitude+ 10, widget.activeUsers.first['current_location'].longitude- 10),
//           LatLng(widget.activeUsers.first['current_location'].latitude - 10, widget.activeUsers.first['current_location'].longitude+ 10),
//         )
//         ..draggable = true
//         ..fillColor = '#FF0000'
//         ..strokeColor = '#FF0000'
//         ..editable = true
//         ..strokeWeight = 1);
//
//       widget.activeUsers.forEach((element) {
//         GeoPoint po = element['current_location'];
//         if(poly.bounds!.intersects(LatLngBounds(LatLng(po.latitude,po.longitude))) == true){
//           print(element['name']);
//         }
//       });
//
//       poly.onBoundsChanged.listen((event) {
//         List<QueryDocumentSnapshot<Object?>> selectActiveUser = [];
//         List selectInActiveUser = [];
//         widget.activeUsers.forEach((element) {
//           GeoPoint po = element['current_location'];
//           if(poly.bounds!.intersects(LatLngBounds(LatLng(po.latitude,po.longitude))) == true){
//             selectActiveUser.add(element);
//           }
//         });
//         widget.markers.forEach((e) {
//           LatLng po = e['position'];
//           if(poly.bounds!.intersects(LatLngBounds(LatLng(po.lat,po.lng))) == true){
//             selectInActiveUser.add(e);
//           }
//         });
//         widget.onActiveUserSelected!(selectActiveUser);
//         widget.onInActiveUserSelected!(selectInActiveUser);
//
//       });
//
//       poly.onDrag.listen((event) {
//         List<QueryDocumentSnapshot<Object?>> selectActiveUser = [];
//         List selectInActiveUser = [];
//         widget.activeUsers.forEach((element) {
//           GeoPoint po = element['current_location'];
//           if(poly.bounds!.intersects(LatLngBounds(LatLng(po.latitude,po.longitude))) == true){
//             selectActiveUser.add(element);
//           }
//         });
//         widget.markers.forEach((e) {
//           LatLng po = e['position'];
//           if(poly.bounds!.intersects(LatLngBounds(LatLng(po.lat,po.lng))) == true){
//             selectInActiveUser.add(e);
//           }
//         });
//         widget.onActiveUserSelected!(selectActiveUser);
//         widget.onInActiveUserSelected!(selectInActiveUser);
//
//       });
//       // ignore: avoid_single_cascade_in_expression_statements
//       map
//         ..onClick.listen((event) {
//           if (mounted) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => LocationTrace(
//                   position: event.latLng!,
//                 ),
//               ),
//             );
//           }
//           // widget.onMapClick(event.latLng, map.zoom);
//         });
//       return elem;
//     });
//
//     return HtmlElementView(viewType: htmlId);
//   }
//
//   String getWindow(
//     name,
//     id,
//     nt,
//   ) {
//     return '''
//     <div style="padding: 10px; display: flex; flex-direction: column; color: black">
//         <H5 style="margin: 0px">Nom Complet : ${name}</H5>
//         <H5 style="margin: 0px">Id : ${id}</H5>
//         <H5 style="margin: 0px">NT : ${nt}</H5>
//
//     </div>
// ''';
//   }
