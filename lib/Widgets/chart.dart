import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

class MyPieChart extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyPieChart> {
  Map<String, double> data = new Map();
  // bool _loadChart = false;

  Map worlwideData;
  var _isLoading = false;
  double confirmed = 0;
  double recovered = 0;
  double deaths = 0;
  double active = 0;

  Future getData() async {
    setState(() {
      _isLoading = true;
    });
    const url = 'https://corona.lmao.ninja/v2/all';
    final response = await http.get(url);
    setState(() {
      worlwideData = json.decode(response.body);
      confirmed = worlwideData['cases'].toDouble();
      recovered = worlwideData['recovered'].toDouble();
      deaths = worlwideData['deaths'].toDouble();
      active = worlwideData['active'].toDouble();
    });
    print(confirmed);

    setState(() {
      _isLoading = false;
    });
    print(worlwideData);
  }

  @override
  void initState() {
    getData().then((_) {
      data.addAll({
        'Confirmed': confirmed,
        'Recovered': recovered,
        'Active': active,
        'Deaths': deaths
      });
    });
    print('active $active');
    super.initState();
  }

  List<Color> _colors = [
    Colors.blueAccent,
    Colors.green,
    Colors.redAccent,
    Colors.grey
  ];

  Widget cardItem(IconData icon, String status, Color color, String count) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon, color: color),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    '$status :',
                  ),
                  Text(
                    count,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _isLoading
              ? CircularProgressIndicator()
              : Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      PieChart(
                        dataMap: data,
                        colorList:
                            _colors, // if not declared, random colors will be chosen
                        animationDuration: Duration(milliseconds: 1500),
                        chartLegendSpacing: 22.0,
                        chartRadius: MediaQuery.of(context).size.width /
                            2.7, //determines the size of the chart
                        showChartValuesInPercentage: true,
                        showChartValues: true,
                        showChartValuesOutside: false,
                        chartValueBackgroundColor: Colors.grey[200],
                        showLegends: false,
                        legendPosition: LegendPosition
                            .right, //can be changed to top, left, bottom
                        decimalPlaces: 1,
                        showChartValueLabel: true,
                        initialAngle: 0,
                        chartValueStyle: defaultChartValueStyle.copyWith(
                          color: Colors.blueGrey[900].withOpacity(0.9),
                        ),
                        chartType:
                            ChartType.ring, //can be changed to ChartType.ring
                      ),
                      Column(children: [
                        cardItem(Icons.brightness_1, 'CONFIRMED',
                            Colors.blueAccent, confirmed.toString()),
                        cardItem(Icons.brightness_1, 'RECOVERED', Colors.green,
                            recovered.toString()),
                        cardItem(Icons.brightness_1, 'ACTIVE', Colors.redAccent,
                            active.toString()),
                        cardItem(Icons.brightness_1, 'DEATHS', Colors.grey,
                            deaths.toString()),
                      ])
                    ],
                  ),
                ),
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today Cases', style: TextStyle(fontSize: 15)),
                _isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        worlwideData['todayCases'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )
              ],
            ),
          ),
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today Deaths', style: TextStyle(fontSize: 15)),
                _isLoading
                    ? CircularProgressIndicator()
                    : Text(worlwideData['todayDeaths'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
