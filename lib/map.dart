import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(36.084260891842284, 129.39647638527407);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          myLocationButtonEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 17.0,
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//
//   LatLng _initialcameraposition = LatLng(10.10329509113411, 100.3870624571811);
//   late GoogleMapController _controller;
//   Location _location = Location();
//
//   void _onMapCreated(GoogleMapController _cntlr)
//   {
//     _controller = _cntlr;
//     _location.onLocationChanged.listen((l) {
//       _controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(l.latitude!, l.longitude!),
//               zoom: 20,
//             )
//         ),
//       );
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Stack(
//           children: [
//             GoogleMap(
//               initialCameraPosition: CameraPosition(target: _initialcameraposition),
//               mapType: MapType.normal,
//               onMapCreated: _onMapCreated,
//               myLocationEnabled: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
// }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:geolocator/geolocator.dart';
//
// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   late Future < Position > _currentLocation;
//   Set < Marker > _markers = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _currentLocation = Geolocator
//         .getCurrentPosition();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: _currentLocation,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               // The user location returned from the snapshot
//               //Position snapshotData = snapshot.data;
//               Position? snapshotData = snapshot.data as Position?;
//               LatLng _userLocation =
//               LatLng(snapshotData!.latitude, snapshotData!.longitude);
//               return GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: _userLocation,
//                   zoom: 12,
//                 ),
//                 markers: _markers..add(Marker(
//                     markerId: MarkerId("User Location"),
//                     infoWindow: InfoWindow(title: "User Location"),
//                     position: _userLocation)),
//               );
//             } else {
//               return Center(child: Text("Failed to get user location."));
//             }
//           }
//           // While the connection is not in the done state yet
//           return Center(child: CircularProgressIndicator());
//         });
//   }
// }