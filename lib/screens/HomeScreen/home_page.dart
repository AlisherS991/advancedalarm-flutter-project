import 'dart:math';

import 'package:advancedalarm/models/model.dart';
import 'package:advancedalarm/notification_widgets/notification_helper.dart';
import 'package:advancedalarm/screens/AlarmAddScreen/alarm_add_page.dart';
import 'package:advancedalarm/screens/HomeScreen/widgets/itembuilder.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Model> alarmList = Model.aList();
  bool israndom = false;
  List<int> numbers=[];
   
  void isRandom(bool updated){
israndom = updated;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            color: Color.fromARGB(255, 61, 77, 168),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                        
                      ),
                      for (Model thisAlarmList in alarmList)
                        ToDoItem(
                          todo: thisAlarmList,
                          onToDoChanged: (israndom ? _handleToDoChangeofRandom : _handleToDoChange),
                          onDeleteItem: _deleteOnDeleteItem,
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ElevatedButton(
                onPressed: ()  {
                  setState(() async {
                    Model data = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>   AlarmAddPage(onIndexChanged: isRandom,),
                      ),
                    );
                    setState(() {
                      alarmList.add(data);
                    });
                                    });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 135, 46, 252),
                  minimumSize: const Size(60, 70),
                  elevation: 10,
                ),
                child: const Text(
                  '+',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 174, 130, 192),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(Model todo) {
    setState(() {
      todo.set = !todo.set;
    //   todo.set? NotificationHelper.shechuledNotification(
    //   '${todo.id}',
      
    //   'WAKE UP',
    //   'WAAKEEE UPPPPPP!!!!!',
    //   todo.uri, 
    //   todo.duration ,
    //   todo.id,
    // ) : 
    NotificationHelper.deleteNotification(todo.id) ;
    });
  }
 void generateSongs(List<int> numberss, List<SongModel> songs, int _currentIndexofHour,int _currentIndexofMinute) {
    for (int i = 0; i < 5; i ++) {
      int randomIndex = Random().nextInt(songs.length);
      numberss.add(randomIndex);
      numbers.add(randomIndex);
      bool checker = false;
      for (int j = 0; j < numberss.length; j++) {
        if (randomIndex == numberss[j]) {
          checker = true;
        }
      }
      if (checker == true) {
        continue;
      } else {
        String channelID = randomIndex.toString();
        NotificationHelper.shechuledNotification(
          channelID,
          'WAKE UP',
          'WAAKEEE UPPPPPP!!!!!',
          "${songs[randomIndex].uri}",
          (_currentIndexofHour*60*60)+(_currentIndexofMinute*60), 
          randomIndex,
        );
      }
    }
  }
  void _handleToDoChangeofRandom(Model todo) {
    setState(() {
      todo.set = !todo.set;
      todo.set?  generateSongs(todo.randomNotifications!, todo.songs!,todo.currentIndexofHour!,todo.currentIndexofMinute!) : NotificationHelper.deleteNotifications(todo.randomNotifications!) ;
    });
  }

  void _deleteOnDeleteItem(int id,List<int> numberss,bool israndomm) {
    setState(() {
      
      israndom = israndomm;
      List<int> numbers = numberss;
      for (int i = 0; i < alarmList.length; i++) {
        if ((alarmList[i].id == id)  ) {
          alarmList.removeAt(i);
        }
      }
      israndom?  NotificationHelper.deleteNotifications(numbers) :NotificationHelper.deleteNotification(id) ;
      
    });
  }
}
