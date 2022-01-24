import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

import '../../helper_functions.dart';
import 'advanced_card.dart';
import 'thumbnail_widget.dart';

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
        subtitle: Text(parseHtmlString(item.description as String)),
        onLongPress: () => showDialog(
          context: context,
          builder: (context) => DetailedCard(item),
        ),
        onTap: () => openWeb(item.link as String),
        leading: ThumbnailsWidget(item),
        tileColor: Theme.of(context).cardColor.withOpacity(0.1),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32))),
      ),
    );
  }
}
