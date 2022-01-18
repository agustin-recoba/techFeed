import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openWeb(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}

String parseHtmlString(String htmlString, {bool shrinkText = true}) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;
  if (parsedString.length > 300 && shrinkText) {
    return parsedString.substring(0, 300) + '...';
  } else {
    return parsedString;
  }
}
