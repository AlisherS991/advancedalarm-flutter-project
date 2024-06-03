import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  static bool state = true;


  var playIndex = 0.obs;
  var isPlaying = false.obs;
  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }
   static void inStateChanged(){ 
  state = !state;
  }
  
  
  playSong(String? uri, index,) {
    playIndex.value = index;
    
    try {
      if(state){
audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioPlayer.play();
      

      isPlaying(true);
      }else{
audioPlayer.stop();
      }
      
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  checkPermission() async {
    var perm = await Permission.audio.request();
    if (perm.isGranted) {
      // return audioQuery.querySongs(
      //   ignoreCase: true,
      //   orderType: OrderType.ASC_OR_SMALLER,
      //   sortType: null,
      //   uriType: UriType.EXTERNAL,
      // );
    } else {
      checkPermission();
    }
  }
}
