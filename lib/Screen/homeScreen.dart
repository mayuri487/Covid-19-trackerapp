import 'package:flutter/material.dart';

import '../Widgets/chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Image.network(
                    'https://cdn.pixabay.com/photo/2020/03/19/21/35/covid-4948866_960_720.jpg',
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.darken,
                    color: Colors.black54,
                  ),
                ),
                //color: Colors.purple,
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      'We all are together in this fight!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontStyle: FontStyle.italic),
                    ),
                    Text('Stay home, stay safe.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontStyle: FontStyle.italic))
                  ],
                ),
              )
            ]),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Worlwide Data',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Statistics :',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            Container(child: MyPieChart()),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/regionalScreen');
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Container(
                    height: 100,
                    width: 90,
                    child: Image.network(
                      'https://cdn.pixabay.com/photo/2020/04/18/18/37/coronavirus-disease-covid-2019-5060518_960_720.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title:
                      Text('See Regional Data', style: TextStyle(fontSize: 15)),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/DetailScreen');
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Container(
                    height: 100,
                    width: 90,
                    child: Image.network(
                        'https://image.freepik.com/free-vector/virus-cure-concept_23-2148497093.jpg',
                        fit: BoxFit.cover),
                  ),
                  title: Text('What is Covid-19 ? ',
                      style: TextStyle(fontSize: 15)),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
