import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

import '../../helper_functions.dart';

class DetailedCard extends StatelessWidget {
  final RssItem item;
  const DetailedCard(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              children: [
                for (var text in _textList)
                  Padding(
                    child: text,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
              ],
            )),
      ),
    );
  }

  List<Widget> get _textList {
    return [
      if (item.title != null)
        Text(
          'Title: ' + parseHtmlString(item.title!),
        ),
      if (item.description != null)
        Text(
          'Description: ' +
              parseHtmlString(item.description!, shrinkText: false),
        ),
      if (item.link != null)
        InkWell(
            onTap: () {
              openWeb(parseHtmlString(item.link!));
            },
            child: Text(
              'Link: ' + parseHtmlString(item.link!),
            )),
      if (item.categories != null)
        Text(
          'Categories: ' +
              item.categories!.map((e) => parseHtmlString(e.value)).join(', '),
        ),
      if (item.guid != null)
        Text(
          'Guid: ' + parseHtmlString(item.guid!),
        ),
      if (item.pubDate != null)
        Text(
          'PubDate: ' + parseHtmlString(item.pubDate!.toString()),
        ),
      if (item.author != null)
        Text(
          'Author: ' + parseHtmlString(item.author!),
        ),
      if (item.comments != null)
        Text(
          'Comments: ' + parseHtmlString(item.comments!),
        ),
      if (item.source != null && item.source!.value != null)
        Text(
          'Source: ' + parseHtmlString(item.source!.value!),
        ),
      if (item.content != null)
        Text(
          'Content: ' + parseHtmlString(item.content!.value),
        )
    ];
  }
}
