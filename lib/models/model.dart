import 'package:on_audio_query/on_audio_query.dart';

class Model {
  int id;
  String uri;
  int duration;
  String time;
  List<int>? randomNotifications;
  bool? israndom;
  List<SongModel> ?songs;
  int? currentIndexofHour;
  int? currentIndexofMinute;
  bool set;
  Model({
    required this.id,
    required this.time,
    required this.uri,
    required this.duration,
    this.randomNotifications,
    this.israndom,
    this.songs,
    this.currentIndexofHour,
    this.currentIndexofMinute,
    this.set = true,
  });
  static List<Model> aList() {
    return [
      
    ];
  }
}
