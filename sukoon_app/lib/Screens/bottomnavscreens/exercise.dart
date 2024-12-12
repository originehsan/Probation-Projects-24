import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import connectivity_plus

import '../global_variable.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  YoutubePlayerController? _controller; // Make it nullable
  bool _isPlayerReady = false;
  bool _isVideoEnded = false;
  bool _isLoading = true;
  late TextEditingController _idController;

  List<Map<String, dynamic>> exercises = [];

  final String apiUrl = 'https://login-signup-page-3z09.onrender.com/user/recommendations';

  // Static in-memory cache to store video data (thumbnails and exercise details)
  static List<Map<String, dynamic>> cachedExercises = [];

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();

    // If exercises are cached, use them directly
    if (cachedExercises.isEmpty) {
      _fetchExercises();
    } else {
      _loadFromCache();
    }
  }

  // Load exercises from cache
  void _loadFromCache() {
    setState(() {
      exercises = cachedExercises;
      _isLoading = false;
    });

    if (exercises.isNotEmpty) {
      final firstVideoId = _extractVideoId(exercises[0]['link'] ?? '');
      _controller = YoutubePlayerController(
        initialVideoId: firstVideoId,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          enableCaption: true,
        ),
      )..addListener(listener);

      setState(() {}); // Trigger a rebuild after controller initialization
    }
  }

  Future<void> _fetchExercises() async {
    // Check network connectivity
    List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

    // If network is mobile, introduce a 30 second delay
    if (connectivityResult == ConnectivityResult.mobile) {
      log("Low network detected. Waiting for 30 seconds...");
      await Future.delayed(const Duration(seconds: 30));  // 30-second delay
    }

    try {
      final response = await http
          .post(
            Uri.parse(apiUrl),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'stats': GlobalVariables.stats,
            }),
          )
          .timeout(
            const Duration(seconds: 30), // Timeout duration
            onTimeout: () {
              throw TimeoutException('The connection has timed out.');
            },
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          exercises = List<Map<String, dynamic>>.from(data['recommendations']['exercises']);
          _isLoading = false;
        });

        // Cache the fetched exercises in-memory
        cachedExercises = exercises;

        if (exercises.isNotEmpty) {
          final firstVideoId = _extractVideoId(exercises[0]['link'] ?? '');
          _controller = YoutubePlayerController(
            initialVideoId: firstVideoId,
            flags: const YoutubePlayerFlags(
              mute: false,
              autoPlay: false,
              disableDragSeek: false,
              loop: false,
              isLive: false,
              enableCaption: true,
            ),
          )..addListener(listener);

          setState(() {}); // Trigger a rebuild after controller initialization
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
                'Loading Exercises...',
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
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = exercises[index];
                        final videoId = _extractVideoId(exercise['link'] ?? '');
                        final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              log('Tapped on: ${exercise['title']}');
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
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded /
                                                          (loadingProgress.expectedTotalBytes ?? 1)
                                                      : null,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      if (_controller == null || _isVideoEnded)
                                        const CircularProgressIndicator(),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                    child: Text(
                                      exercise['title'] ?? 'No Title', // Use fallback if title is null
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
    return YoutubePlayer.convertUrlToId(url) ?? '';
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
