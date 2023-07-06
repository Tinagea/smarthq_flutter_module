import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:video_player/video_player.dart';

/// TODO: Interapt - the class should not be immutable if it's using in the way
/// This class (or a class that this class inherits from) is marked as '@immutable',
/// but one or more of its instance fields aren't final
// ignore: must_be_immutable
class CommonVideoPlayer extends StatefulWidget {
  double aspectRatio;
  String mediaURL;
  bool autoplay;

  CommonVideoPlayer({
    Key? key,
    required this.aspectRatio,
    required this.mediaURL,
    this.autoplay = true,
  }) : super(key: key);

  @override
  State<CommonVideoPlayer> createState() => _CommonVideoPlayerState();
}

class _CommonVideoPlayerState extends State<CommonVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.mediaURL)
      ..setLooping(true)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        if (widget.autoplay) _controller.play();
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    geaLog.debug("Building Video Player, With URL: ${widget.mediaURL}");
    if (_controller.value.isInitialized) {
      // initialized
      return IgnorePointer(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      );
    } else {
      // not ready
      return Container();
    }
  }
}