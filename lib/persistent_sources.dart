import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const Map<String, String> _predefinedSources = {
  "Wired": "https://www.wired.com/feed/",
  "Techcrunch": "https://techcrunch.com/feed/",
  "The-Next-Web": "https://thenextweb.com/feed/",
  "Engadget": "https://www.engadget.com/rss.xml",
  "Mashable": "https://mashable.com/feed/",
  "The-Guardian-US": "https://www.theguardian.com/us/rss",
  "NASA": "https://www.nasa.gov/rss/dyn/breaking_news.rss",
};

class Sources {
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static Map<String, String> get sourcesMap {
    var sources = _prefsInstance?.getString('sources');
    if (sources == null) {
      Map<String, String> newMap = {
        for (var entry in _predefinedSources.entries) entry.key: entry.value
      };
      setSources(newMap);
      return newMap;
    } else {
      var decoded = json.decode(sources).cast<String, String>() ?? {};
      return decoded;
    }
  }

  static Future<bool> setSources(Map<String, String> sources) async {
    var prefs = await _instance;
    var encoded = json.encode(sources);
    return prefs.setString('sources', encoded);
  }

  static Future<bool> addSource(String key, String value) async {
    Map<String, String> sources = sourcesMap;
    sources[key] = value;
    return setSources(sources);
  }

  static Future<bool> removeSource(String key) async {
    Map<String, String> sources = sourcesMap;
    sources.remove(key);
    return setSources(sources);
  }
}
