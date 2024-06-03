import 'dart:math';

import 'package:advancedalarm/const/text_style.dart';
import 'package:advancedalarm/controllers/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicList extends StatefulWidget {
  final Function(bool,List<SongModel>)? onIndexChanged;
  
  const MusicList({super.key,  this.onIndexChanged});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  List<SongModel> songs = [];

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.white,
          )
        ],
        leading: Icon(Icons.sort_rounded, color: Colors.white),
        title: Text('Beats', style: ourStyle()),
      ),
      body: Stack(
        children: [
          Container(
            child: FutureBuilder<List<SongModel>>(
              future: controller.audioQuery.querySongs(
                ignoreCase: true,
                orderType: OrderType.ASC_OR_SMALLER,
                sortType: null,
                uriType: UriType.EXTERNAL,
              ),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return Center(child: const Text('No Song found',style: TextStyle(fontSize: 32,color: Colors.white70),));
                } else {
                  songs = snapshot.data!;
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Obx(
                          () => ListTile(
                            title: Text(
                              snapshot.data![index].displayNameWOExt,
                              style: ourStyle(),
                            ),
                            subtitle: Text(
                              "${snapshot.data![index].artist}",
                              style: ourStyle(),
                            ),
                            leading: QueryArtworkWidget(
                              id: snapshot.data![index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: const Icon(
                                Icons.music_note,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                controller.playSong(
                                  snapshot.data![index].uri, index);
                                  PlayerController.inStateChanged();
                              },
                              icon: controller.playIndex.value == index &&
                                      controller.isPlaying.value
                                  ? 
                                   const Icon(
                                      Icons.stop,
                                      color: Colors.white,
                                      size: 32,
                                    ) : const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 32,
                                    )
                            ),
                            onTap: () {
                              Navigator.pop(
                                context,
                                {
                                  'ChannelIDandID': index,
                                  'uri': snapshot.data![index].uri,
                                  'Name': snapshot.data![index].displayNameWOExt,
                                  'Author': snapshot.data![index].artist,
                                  'songs': songs, // Add the songs list here
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Align(
            alignment: const Alignment(0, 1),
            child: ElevatedButton(
              onPressed: () {
                if (songs.isNotEmpty) {
                  Navigator.pop(
                    context,
                    {
                      'songs': songs,
                    },
                  );
                  widget.onIndexChanged!(true,songs);
                } else {
                  print('No songs available to return.');
                }
              },
              child:  Padding(
                padding:  EdgeInsets.fromLTRB(0,10,0,10),
                child: Text('Random',style: TextStyle(color: Colors.black,fontSize: 25),),
              ),
              style: ButtonStyle( 
              
              backgroundColor: WidgetStateProperty.all<Color>(Colors.white.withOpacity(0.6))),
            ),
            
          ),
          SizedBox(height: 200,),
        ],
      ),
    );
  }
}
