import 'dart:async';
import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_enclosure.dart';
import 'package:webfeed/webfeed.dart';

class ThumbnailsWidget extends StatefulWidget {
  final RssItem item;
  final List<String> _images = [];
  ThumbnailsWidget(this.item, {Key? key}) : super(key: key) {
    if (item.media != null && item.media!.thumbnails != null) {
      for (var thumbnail in item.media!.thumbnails!) {
        if (thumbnail.url != null) {
          _images.add(thumbnail.url!);
        }
      }
    }
    if (item.enclosure != null && item.enclosure?.url != null) {
      _images.add((item.enclosure!.url)!);
    }
  }

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
        if (widget._images.isNotEmpty) {
          _pos = (_pos + 1) % widget._images.length;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._images.isEmpty) {
      return const Icon(Icons.image);
    } else {
      return SizedBox(
        height: 100,
        width: 100,
        child: Image.network(
          widget._images[_pos],
          fit: BoxFit.cover,
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
