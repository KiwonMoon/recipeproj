import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_place/google_place.dart';
import 'package:location/location.dart' as LocationManager;
import 'detailpage.dart';

//codelab
// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   final Map<String, Marker> _markers = {};
//   Future<void> _onMapCreated(GoogleMapController controller) async {
//     final googleOffices = await locations.getGoogleOffices();
//     setState(() {
//       _markers.clear();
//       for (final office in googleOffices.offices) {
//         final marker = Marker(
//           markerId: MarkerId(office.name),
//           position: LatLng(office.lat, office.lng),
//           infoWindow: InfoWindow(
//             title: office.name,
//             snippet: office.address,
//           ),
//         );
//         _markers[office.name] = marker;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Google Office Locations'),
//           backgroundColor: Colors.deepOrangeAccent,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: GoogleMap(
//           onMapCreated: _onMapCreated,
//           initialCameraPosition: const CameraPosition(
//             target: LatLng(0, 0),
//             zoom: 2,
//           ),
//           markers: _markers.values.toSet(),
//         ),
//       ),
//     );
//   }
// }

// 자기 위치 + 주변 음식점 시도 중
// final places =
// GoogleMapsPlaces(apiKey: "AIzaSyAfJ9_bp3dmxJfOga_BAOS-Gppkc1a6Mhw");

// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   Completer<GoogleMapController> _controller = Completer();
//   final Set<Marker> _markers = {};
//
//   late Future<Position> _currentLocation;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentLocation = Geolocator.getCurrentPosition();
//   }
//
//   static const LatLng _center = const LatLng(36.8151, 127.1139);
//   MapType _currentMapType = MapType.normal;
//   LatLng _lastMapPosition = _center;
//
//   void _onCameraMove(CameraPosition position) {
//     _lastMapPosition = position.target;
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//   }
//
//   void _onMapTypeButtonPressed() {
//     setState(() {
//       _currentMapType = (_currentMapType == MapType.normal)
//           ? MapType.satellite
//           : MapType.normal;
//     });
//   }
//
//   void _onAddMarkerButtonPressed() {
//     setState(() {
//       _markers.add(Marker(
// // This marker id can be anything that uniquely identifies each marker.
//         markerId: MarkerId(_lastMapPosition.toString()),
//         position: _lastMapPosition,
//         infoWindow: InfoWindow(
//           title: 'Really cool place',
//           snippet: '5 Star Rating',
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//       ));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('내 주변 가게 찾아보기'),
//           backgroundColor: Colors.deepOrangeAccent,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: FutureBuilder(
//             future: _currentLocation,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.hasData) {
//                   // The user location returned from the snapshot
//                   Position snapshotData = snapshot.data as Position;
//                   LatLng _userLocation =
//                   LatLng(snapshotData.latitude, snapshotData.longitude);
//                   return Stack(
//                     children: [
//                       GoogleMap(
//                         initialCameraPosition: CameraPosition(
//                           target: _userLocation,
//                           zoom: 12,
//                         ),
//                         markers: _markers
//                           ..add(Marker(
//                               markerId: MarkerId("User Location"),
//                               infoWindow: InfoWindow(title: "User Location"),
//                               position: _userLocation)),
//                       ),
//                       Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Align(
//                               alignment: Alignment.topRight,
//                               child: FloatingActionButton(
//                                 onPressed: () => _onMapTypeButtonPressed(),
//                                 materialTapTargetSize:
//                                 MaterialTapTargetSize.padded,
//                                 backgroundColor: Colors.deepOrangeAccent,
//                                 child: const Icon(Icons.map, size: 36.0),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                             const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
//                             child: Align(
//                               alignment: Alignment.topRight,
//                               child: FloatingActionButton(
//                                 onPressed: _onAddMarkerButtonPressed,
//                                 materialTapTargetSize:
//                                 MaterialTapTargetSize.padded,
//                                 backgroundColor: Colors.deepOrangeAccent,
//                                 child:
//                                 const Icon(Icons.add_location, size: 36.0),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 } else {
//                   return Center(child: Text("Failed to get user location."));
//                 }
//               }
//               // While the connection is not in the done state yet
//               return Center(child: CircularProgressIndicator());
//             }),
//       ),
//     );
//   }
// }

//자기 자신 위치에 마커 추가
class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Future<Position> _currentLocation;
  late GooglePlace googlePlace;
  late String nextToken;
  Set<Marker> _markers = {};

  @override
  void initState() {
    googlePlace = GooglePlace("AIzaSyDccuAeeo8AFsOOUWJx0MwOrq7Lq-_YvgQ");
    _currentLocation = Geolocator.getCurrentPosition();
    super.initState();
  }

  void findPlaces(LatLng userLocation, String token) async {
    NearBySearchResponse result;
    print(userLocation.latitude);
    print(userLocation.longitude);

    result = (await googlePlace.search.getNearBySearch(
        Location(lat: userLocation.latitude, lng: userLocation.longitude), 3000,
        type: "restaurant", rankby: RankBy.Distance))!;

    print(result.toString());
    if(result != null) {
      print(result.nextPageToken);
      if(result.nextPageToken != null) nextToken = result.nextPageToken!;
      else nextToken = "";

      Set<Marker> _restaurantMarkers = result.results!
          .map((result) => Marker(
          markerId: MarkerId(result.name!),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueOrange),
          infoWindow: InfoWindow(
              title: result.name,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      placeId: result.placeId!,
                      googlePlace: googlePlace,
                    ),
                  ),
                );
              },
              snippet:
              "평점: " + (result.rating?.toString() ?? "점수 없음")),
          position: LatLng(result.geometry!.location!.lat!,
              result.geometry!.location!.lng!)))
          .toSet();

      if(_markers.length == 1) {
        setState(() {
          _markers.addAll(_restaurantMarkers);
        });
      }
    } else {
      findPlaces(userLocation, "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('내 주변 가게 찾아보기'),
          backgroundColor: Colors.deepOrangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder(
            future: _currentLocation,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  // The user location returned from the snapshot
                  Position snapshotData = snapshot.data as Position;
                  LatLng _userLocation =
                  LatLng(snapshotData.latitude, snapshotData.longitude);
                  findPlaces(_userLocation, "");
                  return Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _userLocation,
                          zoom: 17.5,
                        ),
                        markers: _markers
                          ..add(Marker(
                              markerId: MarkerId("User Location"),
                              infoWindow: InfoWindow(title: "User Location"),
                              position: _userLocation)),
                      ),
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //
                      //     },
                      //     child: Text("더 불러오기"),
                      //   ),
                      // )
                    ],
                  );
                } else {
                  return Center(child: Text("Failed to get user location."));
                }
              }
              // While the connection is not in the done state yet
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}