import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../../../../constants/constants.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.p0, required this.user});
  final types.VideoMessage p0;
  final types.User user;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Duration duration;
  Duration position = Duration.zero;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    duration = Duration(minutes: 12);
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://vnno-pt-3-tf-mcloud-lpl-s7-mv-zmp3.zmdcdn.me/uTVe8ONGw-c/whls/vod/480/uENaZODxVNrTNLuEnUu/Tham-Yeu-La.m3u8?authen=exp=1697958124~acl=/uTVe8ONGw-c/*~hmac=ae5f95188a48134b01c5384a9541c3b2'),
    )..initialize().then((_) {
        setState(() {
          position = _controller.value.position;
          duration = _controller.value.duration;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String formatTime(Duration dur) {
    String formatString = '';
    if (dur.inHours.toInt() == 0) {
      formatString = 'mm:ss';
    } else {
      formatString = 'H:mm:ss';
    }
    final show = DateFormat(formatString).format(
      DateTime.fromMillisecondsSinceEpoch(
        dur.inSeconds.toInt() * 1000,
        isUtc: true,
      ),
    );
    return show;
  }

  getVideoPosition() {
    var duration = Duration(
        milliseconds: _controller.value.position.inMilliseconds.round());
    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: (_controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container()),
        ),
        Row(
          children: [
            hpad(2),
            Text(
              '${getVideoPosition()}-${formatTime(duration)}',
              style: txtRegular(12, Colors.white),
            ),
            hpad(2),
            Flexible(
              child: VideoProgressIndicator(
                _controller,
                colors: VideoProgressColors(playedColor: Colors.white),
                allowScrubbing: true,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  isPlaying != isPlaying;
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              iconSize: 30,
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: widget.p0.author.id == widget.user.id
                    ? Colors.white
                    : primaryColorBase,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
