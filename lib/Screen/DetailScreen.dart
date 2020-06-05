import 'package:flutter/material.dart';

import '../dummy_data.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Get to know about COVID 19')),
        body: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: dummyData.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Text(dummyData[index]['question']),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(dummyData[index]['answer']),
                  )
                ],
              );
            }));
  }
}
