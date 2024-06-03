import 'dart:math';
import 'package:advancedalarm/models/model.dart';
import 'package:advancedalarm/notification_widgets/notification_helper.dart';
import 'package:advancedalarm/screens/AlarmAddScreen/widgets/hoursettings.dart';
import 'package:advancedalarm/screens/AlarmAddScreen/widgets/minutesettins.dart';
import 'package:advancedalarm/screens/HomeScreen/home_page.dart';
import 'package:advancedalarm/screens/MusicChoiceScreen/music_choice.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlarmAddPage extends StatefulWidget {
  final Function(bool) onIndexChanged;
  const AlarmAddPage({super.key, required this.onIndexChanged,});

  @override
  State<AlarmAddPage> createState() => _AlarmAddPageState();
}

class _AlarmAddPageState extends State<AlarmAddPage> {
  int _currentIndexofHour = 0;
  int _currentIndexofMinute = 0;
  String uriOfSongs = 'frfr';
  int id = 9999;
  String songName = '';
  String artisName = '';
  String songInfo = '';
  int duration = 0;
  String _hourTime = '00';
  String _minuteTime = '00';
  bool israndom = false;
  List<SongModel> songss = [];
  List<int> numbers = [];

  void isRandom(bool updated,List<SongModel> songs) {
    setState(() {
      israndom = updated;
      songss = songs;
    });
  }

  void _updateCurrentIndexofHour(int index) {
    setState(() {
      int time = 0;
      time = index;
      _hourTime = index < 10 ? '0$time' : '$time';
      _currentIndexofHour = index;
      int currentHour = DateTime.now().hour;

      if (currentHour > _currentIndexofHour) {
        _currentIndexofHour =  _currentIndexofHour + (23-currentHour);
      } else {
        _currentIndexofHour = _currentIndexofHour - currentHour;
      }
    });
  }

  void _updateCurrentIndexofMinute(int index) {
    setState(() {
      int time = 0;
      time = index;
      _minuteTime = index < 10 ? '0$time' : '$time';
      _currentIndexofMinute = index;
      int currentMinute = DateTime.now().minute;
      if (currentMinute > _currentIndexofMinute) {
        _currentIndexofMinute = _currentIndexofMinute + (60 - currentMinute);
      } else {
        _currentIndexofMinute = _currentIndexofMinute - currentMinute;
      }
    });
  }

  void generateSongs(List<int> numberss, List<SongModel> songs) {
    if (songs.isEmpty) {
      print('Song list is empty, cannot generate random songs.');
      return;
    }
    for (int i = 0; i < 5; i++) {
      int randomIndex = Random().nextInt(songs.length);
      
      bool checker = false;
      for (int j = 0; j < numberss.length; j++) {
        if (randomIndex == numberss[j]) {
          checker = true;
        }
      }
      numberss.add(randomIndex);
      numbers.add(randomIndex);
      if (checker == true) {
        continue;
      } else {
        String channelID = randomIndex.toString();
        NotificationHelper.shechuledNotification(
          channelID,
          'WAKE UP',
          'WAAKEEE UPPPPPP!!!!!',
          "${songs[randomIndex].uri}", 
          (_currentIndexofHour * 60 * 60) + (_currentIndexofMinute * 60) + (360 * i),
          randomIndex,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double itemWidth = (MediaQuery.of(context).size.width) / 5;
    double screenWidth = (MediaQuery.of(context).size.height);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'New Alarm',
          style: TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.w400),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 95
                ),
                Text(
                  'Alarm in $_currentIndexofHour hours and',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '$_currentIndexofMinute minutes',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            HourSettings(onIndexChanged: _updateCurrentIndexofHour, itemWidth: itemWidth),
            const SizedBox(
              height: 20,
            ),
            MinuteSettings(onIndexChanged: _updateCurrentIndexofMinute, itemWidth: itemWidth),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  'Melody',
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
              ),
              trailing: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: TextButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MusicList(onIndexChanged: isRandom),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                          id = result['ChannelIDandID'];
                          uriOfSongs = result['uri'];
                          songName = result['Name'];
                          artisName = result['Author'];
                          songInfo = '$songName $artisName';
                         
                          numbers = result['numbers'];
                        });
                      }
                    },
                    child: Container(
                      width: 140,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            uriOfSongs == 'frfr'
                                ? '                   Default'
                                : songInfo,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white70,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: const Text(
                'Repetition',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: const Text(
                'Vibrate',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Press to save', style: TextStyle(fontSize: 20, color: Colors.white),),
                SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      Model(
                        id: id,
                        time: '$_hourTime:$_minuteTime',
                        uri: uriOfSongs,
                        duration: (_currentIndexofHour * 60 * 60) + (_currentIndexofMinute * 60),
                        randomNotifications: numbers,
                        israndom: israndom,
                        songs: songss,
                        currentIndexofHour: _currentIndexofHour,
                        currentIndexofMinute: _currentIndexofMinute
                      ),
                    );

                    if (israndom) {
                      generateSongs(numbers, songss);
                    } else {
                      NotificationHelper.shechuledNotification(
                        '$id',
                        'WAKE UP',
                        'WAAKEEE UPPPPPP!!!!!',
                        uriOfSongs,
                        (_currentIndexofHour * 60 * 60) + (_currentIndexofMinute * 60),
                        id,
                      );
                    }

                    widget.onIndexChanged(israndom);
                  },
                  icon: Icon(
                    Icons.audio_file,
                    size: screenWidth / 7,
                    color: Colors.white70,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
