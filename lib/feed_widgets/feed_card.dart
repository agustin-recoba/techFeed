import 'package:flutter/material.dart';
import 'package:techfeed/feed_widgets/thumbnail_widget.dart';
import 'package:html/parser.dart';
import 'package:webfeed/webfeed.dart';

import '../main.dart';

class FeedCard extends StatelessWidget {
  final RssItem item;
  final bool showSource = false;
  const FeedCard(this.item, {bool showSource = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        title: Text(item.title as String),
        subtitle: Text(_parseHtmlString(item.description as String)),
        onTap: () => openWeb(item.link as String),
        leading:
            !(item.media!.thumbnails == null || item.media!.thumbnails!.isEmpty)
                ? ThumbnailsWidget(item.media!.thumbnails ?? [])
                : null,
        tileColor: Theme.of(context).cardColor.withOpacity(0.1),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32))),
      ),
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    if (parsedString.length > 300) {
      return parsedString.substring(0, 300) + '...';
    } else {
      return parsedString;
    }
  }
}
