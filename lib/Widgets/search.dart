import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = query.isEmpty
        ? countryList
        : countryList
            .where((country) =>
                country['country'].toString().toLowerCase().startsWith(query))
            .toList();
    return Container(
        child: ListView.separated(
            separatorBuilder: (context, i) => Divider(),
            itemCount: suggestion.length,
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
                            Text(
                              '${suggestion[index]['country']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                    countryList[index]['countryInfo']['flag'])),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'CONFIRMED : ${suggestion[index]['cases']}',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'RECOVERED : ${suggestion[index]['recovered']}',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'ACTIVE : ${suggestion[index]['active']}',
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'DEATHS : ${suggestion[index]['deaths']}',
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
            }));
  }
}
