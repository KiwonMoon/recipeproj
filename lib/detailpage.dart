import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

class DetailsPage extends StatefulWidget {
  final String placeId;
  final GooglePlace googlePlace;

  DetailsPage({Key? key, required this.placeId, required this.googlePlace}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {


  DetailsResult detailsResult = DetailsResult();
  List<Uint8List> images = [];
  Color _iconColor = Colors.grey;


  @override
  void initState() {
    getDetils(widget.placeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(detailsResult.name ?? ""),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: _iconColor,
      //   onPressed: () {
      //     setState(() {
      //       _iconColor = Colors.redAccent;
      //     });
      //   },
      //   child: Icon(Icons.favorite),
      // ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 250,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.memory(
                            images[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.location_on),
                            backgroundColor: Colors.deepOrangeAccent,
                          ),
                          title: Text(
                            detailsResult != null &&
                                detailsResult.formattedAddress != null
                                ? 'Address: ${detailsResult.formattedAddress}'
                                : "Address: null",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.location_searching),
                            backgroundColor: Colors.deepOrangeAccent,
                          ),
                          title: Text(
                            detailsResult != null &&
                                detailsResult.geometry != null &&
                                detailsResult.geometry!.location != null
                                ? 'Geometry: ${detailsResult.geometry!.location!.lat.toString()},${detailsResult.geometry!.location!.lng.toString()}'
                                : "Geometry: null",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.rate_review),
                            backgroundColor: Colors.deepOrangeAccent,
                          ),
                          title: Text(
                            detailsResult != null &&
                                detailsResult.rating != null
                                ? 'Rating: ${detailsResult.rating.toString()}'
                                : "Rating: null",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.attach_money),
                            backgroundColor: Colors.deepOrangeAccent,
                          ),
                          title: Text(
                            detailsResult != null &&
                                detailsResult.priceLevel != null
                                ? 'Price level: ${detailsResult.priceLevel.toString()}'
                                : "Price level: null",
                          ),
                        ),
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

  void getDetils(String placeId) async {
    var result = await widget.googlePlace.details.get(placeId);
    if (result != null && result.result != null && mounted) {
      setState(() {
        detailsResult = result.result!;
        images = [];
      });

      if (result.result!.photos != null) {
        for (var photo in result.result!.photos!) {
          getPhoto(photo.photoReference!);
        }
      }
    }
  }

  void getPhoto(String photoReference) async {
    var result = await widget.googlePlace.photos.get(photoReference, 400, 400);
    if (result != null && mounted) {
      setState(() {
        images.add(result);
      });
    }
  }
}