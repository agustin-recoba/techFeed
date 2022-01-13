import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webfeed/domain/media/thumbnail.dart';

class ThumbnailsWidget extends StatefulWidget {
  List<Thumbnail> thumbnails;
  ThumbnailsWidget(this.thumbnails, {Key? key}) : super(key: key);

  @override
  _ThumbnailsWidgetState createState() => _ThumbnailsWidgetState();
}

class _ThumbnailsWidgetState extends State<ThumbnailsWidget> {
  int _pos = 0;
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        if (widget.thumbnails.isNotEmpty) {
          _pos = (_pos + 1) % widget.thumbnails.length;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.thumbnails.isEmpty
        ? Container()
        : SizedBox(
            height: 100,
            width: 100,
            child: Image.network(
              widget.thumbnails[_pos].url as String,
              fit: BoxFit.cover,
            ),
          );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
