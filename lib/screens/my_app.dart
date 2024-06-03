import 'package:advancedalarm/screens/HomeScreen/home_page.dart';
import 'package:advancedalarm/screens/time_screen/time_page.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: AppBar(
              backgroundColor: Color.fromARGB(255, 61, 77, 168),
              bottom: const TabBar(
                dividerColor: Color.fromARGB(255, 61, 77, 168),
                indicatorColor: Color.fromRGBO(94, 23, 235, 0),
                tabs: [
                  Tab(
                    icon: Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Icon(
                        Icons.alarm,
                        color: Colors.black,
                        size: 44,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Padding(
                      padding: EdgeInsets.only(right: 40.0),
                      child: Icon(
                        Icons.timelapse,
                        color: Colors.black,
                        size: 44,
                      ),
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              title: const Text('Alarm clock'),
              titleTextStyle: const TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          body:  TabBarView(
            children: [
              const MyHomePage(),
              CurrentTimeScreen (),
            ],
          ),
        ),
      ),
    );
  }
}
