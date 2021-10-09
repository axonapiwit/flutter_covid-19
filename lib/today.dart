import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'covid.dart';
import 'dart:async';
import 'widgets/chart.dart';

Future<Covid> fetchCovid() async {
  final response = await http.get(
      Uri.parse('https://static.easysunday.com/covid-19/getTodayCases.json'));
  if (response.statusCode == 200) {
    return Covid.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class TodayPage extends StatefulWidget {
  TodayPage({Key? key}) : super(key: key);

  @override
  _TodayPage createState() => _TodayPage();
}

class _TodayPage extends State<TodayPage> {
  late Future<Covid> futureCovid;

  @override
  void initState() {
    super.initState();
    futureCovid = fetchCovid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green.withOpacity(0.20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 40),
                child: FutureBuilder<Covid>(
                    future: fetchCovid(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Wrap(
                          runSpacing: 20,
                          spacing: 20,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${snapshot.data!.country}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Text('Updated ${snapshot.data!.updateDate}',
                                        style: TextStyle(
                                          fontSize: 14,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            InfoCard(
                              title: 'Cases',
                              data: '${snapshot.data!.todayCases}',
                              iconColor: Colors.red,
                            ),
                            InfoCard(
                              title: 'Hospitalized',
                              data: '${snapshot.data!.Hospitalized}',
                              iconColor: Colors.green,
                            ),
                            InfoCard(
                              title: 'Deaths',
                              data: '${snapshot.data!.todayDeaths}',
                              iconColor: Colors.red.shade900,
                            ),
                            InfoCard(
                              title: 'Recovered',
                              data: '${snapshot.data!.todayRecovered}',
                              iconColor: Colors.green,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('News',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    News(
                                      title: 'images/1.png',
                                      subTitle: 'Covid Test',
                                    ),
                                    News(
                                      title: 'images/2.png',
                                      subTitle: 'Covid Mask',
                                    ),
                                    News(
                                      title: 'images/3.png',
                                      subTitle: 'Covid-19',
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return CircularProgressIndicator();
                    })),
          ],
        ),
      ),
    );
  }
}

class News extends StatelessWidget {
  final String title;
  final String subTitle;
  const News({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          title,
          height: 100,
          width: 80,
        ),
        SizedBox(height: 10),
        Text(subTitle)
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String data;
  final Color iconColor;
  const InfoCard({
    Key? key,
    required this.title,
    required this.data,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: Constraints.maxWidth / 2 - 10,
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.face_outlined,
                        size: 20,
                        color: iconColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('$title'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                          TextSpan(
                              text: '$data \n',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: 'People',
                              style: TextStyle(fontSize: 12, height: 2))
                        ])),
                  ),
                  Expanded(
                    child: LineReportChart(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
