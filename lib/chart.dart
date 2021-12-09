import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<double> points = [99, 95, 87, 72, 70, 64, 49, 37];
  List<String> labels = [
    "쌀",
    "고구마",
    "밀가루",
    "계란",
    "체다치즈",
    "소고기",
    "돼지고기",
    "참치캔",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CHART'),),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('rank')
              .orderBy('counter', descending: true).limit(10).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 30, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('\u{1F373} 레시피에 많이 쓰인 재료 상위 10가지 \u{1F373}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  SizedBox(height: 30,),
                  ChartLine(rate: snapshot.data!.docs[0]['counter']*0.1, title: snapshot.data!.docs[0]['name'], number: snapshot.data!.docs[0]['counter']),
                  ChartLine(rate: snapshot.data!.docs[1]['counter']*0.1, title: snapshot.data!.docs[1]['name'], number: snapshot.data!.docs[1]['counter']),
                  ChartLine(rate: snapshot.data!.docs[2]['counter']*0.1, title: snapshot.data!.docs[2]['name'], number: snapshot.data!.docs[2]['counter']),
                  ChartLine(rate: snapshot.data!.docs[3]['counter']*0.1, title: snapshot.data!.docs[3]['name'], number: snapshot.data!.docs[3]['counter']),
                  ChartLine(rate: snapshot.data!.docs[4]['counter']*0.1, title: snapshot.data!.docs[4]['name'], number: snapshot.data!.docs[4]['counter']),
                  ChartLine(rate: snapshot.data!.docs[5]['counter']*0.1, title: snapshot.data!.docs[5]['name'], number: snapshot.data!.docs[5]['counter']),
                  ChartLine(rate: snapshot.data!.docs[6]['counter']*0.1, title: snapshot.data!.docs[6]['name'], number: snapshot.data!.docs[6]['counter']),
                  ChartLine(rate: snapshot.data!.docs[7]['counter']*0.1, title: snapshot.data!.docs[7]['name'], number: snapshot.data!.docs[7]['counter']),
                  ChartLine(rate: snapshot.data!.docs[8]['counter']*0.1, title: snapshot.data!.docs[8]['name'], number: snapshot.data!.docs[8]['counter']),
                  ChartLine(rate: snapshot.data!.docs[9]['counter']*0.1, title: snapshot.data!.docs[9]['name'], number: snapshot.data!.docs[9]['counter']),
                  // ChartLine(title: labels[0], number: points[0], rate: points[0]*0.01),
                  // ChartLine(title: labels[1], number: points[1], rate: points[1]*0.01),
                  // ChartLine(title: labels[2], number: points[2], rate: points[2]*0.01),
                  // ChartLine(title: labels[3], number: points[3], rate: points[3]*0.01),
                  // ChartLine(title: labels[4], number: points[4], rate: points[4]*0.01),
                  // ChartLine(title: labels[5], number: points[5], rate: points[5]*0.01),
                  // ChartLine(title: labels[6], number: points[6], rate: points[6]*0.01),
                  // ChartLine(title: labels[7], number: points[7], rate: points[7]*0.01),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

class ChartLine extends StatelessWidget {
  const ChartLine({
    // Key key,
    required this.rate,
    required this.title,
    required this.number,
  })  : assert(title != null),
        assert(rate != null),
        assert(rate > 0),
        assert(rate <= 1);
  // super(key: key);

  final double rate;
  final String title;
  final int number;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final lineWidget = constraints.maxWidth * rate*0.8;
      return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 48,
                  alignment: Alignment.topRight,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: Container(
                    color: Colors.orange,
                    height: 30,
                    width: lineWidget,
                  ),
                ),
                // Text(
                //   number.toString(),
                //   style: TextStyle(
                //     fontSize: 12,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      );
    });
  }
}