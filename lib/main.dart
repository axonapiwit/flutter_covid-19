import 'package:flutter/material.dart';
import 'today.dart';
import 'total.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Prompt'),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              bottom: TabBar(
                labelColor: Colors.grey,
                indicatorColor: Colors.black,
                tabs: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Today'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Total'),
                  ),
                ],
              ),
              backgroundColor: Colors.green.withOpacity(0.20),
              elevation: 0,
              leading: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.green,
                  ),
                  onPressed: () {}),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.search, color: Colors.green),
                    onPressed: () {})
              ]),
          body: Container(
            child: TabBarView(
              children: [
                TodayPage(),
                TotalPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
