import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    // data = [
    //   _ChartData('CHN', 12),
    //   _ChartData('GER', 15),
    //   _ChartData('RUS', 30),
    //   _ChartData('BRZ', 6.4),
    //   _ChartData('IND', 14)
    // ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chart'),),
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
              padding: const EdgeInsets.only(top: 30, left: 5),
              child:
              Column(
                children: <Widget>[
                  Text('\u{1F373} 레시피에 많이 쓰인 재료 상위 10가지 \u{1F373}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  SizedBox(height: 30,),
                  SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(minimum: 0, maximum: 20, interval: 5),
                      tooltipBehavior: _tooltip,
                      series: <ChartSeries<_ChartData, String>>[
                        BarSeries<_ChartData, String>(
                            dataSource: [
                              _ChartData(snapshot.data!.docs[9]['name'], snapshot.data!.docs[9]['counter']),
                              _ChartData(snapshot.data!.docs[8]['name'], snapshot.data!.docs[8]['counter']),
                              _ChartData(snapshot.data!.docs[7]['name'], snapshot.data!.docs[7]['counter']),
                              _ChartData(snapshot.data!.docs[6]['name'], snapshot.data!.docs[6]['counter']),
                              _ChartData(snapshot.data!.docs[5]['name'], snapshot.data!.docs[5]['counter']),
                              _ChartData(snapshot.data!.docs[4]['name'], snapshot.data!.docs[4]['counter']),
                              _ChartData(snapshot.data!.docs[3]['name'], snapshot.data!.docs[3]['counter']),
                              _ChartData(snapshot.data!.docs[2]['name'], snapshot.data!.docs[2]['counter']),
                              _ChartData(snapshot.data!.docs[1]['name'], snapshot.data!.docs[1]['counter']),
                              _ChartData(snapshot.data!.docs[0]['name'], snapshot.data!.docs[0]['counter']),
                            ],
                            xValueMapper: (_ChartData data, _) => data.x,
                            yValueMapper: (_ChartData data, _) => data.y,
                            name: 'count',
                            color: Colors.deepOrange)
                      ]),
                ],
              ),
              /*Column(
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
                ],
              ),*/
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
              ],
            ),
          ],
        ),
      );
    });
  }
}
class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final int y;
}