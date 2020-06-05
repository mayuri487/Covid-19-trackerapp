import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Widgets/search.dart';


class RegionalDataScreen extends StatefulWidget {
  @override
  _RegionalDataScreenState createState() => _RegionalDataScreenState();
}

class _RegionalDataScreenState extends State<RegionalDataScreen> {
  List countryData;
  var _isLoading = false;
  Future fetchData() async {
    setState(() {
      _isLoading = true;
    });
    const url = 'https://corona.lmao.ninja/v2/countries';
    final response = await http.get(url);
    setState(() {
      countryData = json.decode(response.body);
      _isLoading = false;
    });
    print(json.decode(response.body));
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Country Data'),
          //backgroundColor: Colors.,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: Search(countryData));
              },
            ),
          ]),
      body: _isLoading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            )
          : ListView.separated(
              separatorBuilder: (context, i) => Divider(),
              itemCount: countryData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.grey)],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('${countryData[index]['country']}',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(countryData[index]
                                      ['countryInfo']['flag'])),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'CONFIRMED : ${countryData[index]['cases']}',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'RECOVERED : ${countryData[index]['recovered']}',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'ACTIVE : ${countryData[index]['active']}',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'DEATHS : ${countryData[index]['deaths']}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
