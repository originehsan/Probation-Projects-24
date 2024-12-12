import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import connectivity_plus

import '../global_variable.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  YoutubePlayerController? _controller;
  bool _isPlayerReady = false;
  bool _isVideoEnded = false;
  bool _isLoading = true;
  late TextEditingController _idController;

  List<Map<String, dynamic>> musicList = [];

  final String apiUrl = 'https://login-signup-page-3z09.onrender.com/user/recommendations';

  // Static in-memory cache to store music data (thumbnails and details)
  static List<Map<String, dynamic>> cachedMusicList = [];

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();

    // If music data is cached, load it directly
    if (cachedMusicList.isEmpty) {
      _fetchMusic();
    } else {
      _loadFromCache();
    }
  }

  // Load music data from in-memory cache
  void _loadFromCache() {
    setState(() {
      musicList = cachedMusicList;
      _isLoading = false;
    });

    if (musicList.isNotEmpty) {
      final firstVideoId = _extractVideoId(musicList[0]['link']);
      _controller = YoutubePlayerController(
        initialVideoId: firstVideoId,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);
    }
  }

  Future<void> _fetchMusic() async {
    List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    
    if (connectivityResult == ConnectivityResult.mobile) {
      log("Low network detected. Waiting for 30 seconds...");
      await Future.delayed(const Duration(seconds: 30));  // 30-second delay
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'stats': GlobalVariables.stats,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          musicList = List<Map<String, dynamic>>.from(data['recommendations']['music']);
          _isLoading = false;
        });

        // Cache the fetched music data in memory
        cachedMusicList = musicList;

        if (musicList.isNotEmpty) {
          final firstVideoId = _extractVideoId(musicList[0]['link']);
          _controller = YoutubePlayerController(
            initialVideoId: firstVideoId,
            flags: const YoutubePlayerFlags(
              mute: false,
              autoPlay: false,
              disableDragSeek: false,
              loop: false,
              isLive: false,
              forceHD: false,
              enableCaption: true,
            ),
          )..addListener(listener);
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void listener() {
    if (_isPlayerReady && mounted) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    _controller?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              const Text(
                'Loading Music...',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Alice',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller!.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        onReady: () {
          setState(() {
            _isPlayerReady = true;
          });
        },
        onEnded: (data) {
          _controller?.pause();
          setState(() {
            _isVideoEnded = true;
          });
          _showSnackBar('Tap on video to continue.');
        },
      ),
      builder: (context, player) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            if (_isLoading)
              const Center(child: CircularProgressIndicator()),
            if (!_isLoading)
              Column(
                children: [
                  player,
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: musicList.length,
                      itemBuilder: (context, index) {
                        final music = musicList[index];
                        final videoId = _extractVideoId(music['link'] ?? '');
                        final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              log('Tapped on: ${music['title']}');
                              _controller?.load(videoId);
                              setState(() {
                                _isVideoEnded = false;
                              });
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                                        child: Image.network(
                                          thumbnailUrl,
                                          height: 140,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Container(
                                                color: Colors.grey[300], 
                                                height: 140,
                                                width: double.infinity,
                                                child: Center(
                                                  child: CircularProgressIndicator(
                                                    value: loadingProgress.expectedTotalBytes != null
                                                        ? loadingProgress.cumulativeBytesLoaded / 
                                                          (loadingProgress.expectedTotalBytes ?? 1)
                                                        : null,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          errorBuilder: (context, error, stackTrace) {
                                           
                                            return Container(
                                              color: Colors.grey[300], 
                                              height: 140,
                                              width: double.infinity,
                                              child: const Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                    child: Text(
                                      music['title'] ?? 'No Title', 
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  String _extractVideoId(String url) {
    return YoutubePlayer.convertUrlToId(url) ?? ''; // Fallback if URL is invalid
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
