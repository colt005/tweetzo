// To parse this JSON data, do
//
//     final MTrends = welcomeFromJson(jsonString);

import 'dart:convert';

class MTrends {
  List<Trend> trends;
  DateTime asOf;
  DateTime createdAt;
  List<Location> locations;

  MTrends({
    this.trends,
    this.asOf,
    this.createdAt,
    this.locations,
  });

  factory MTrends.fromJson(String str) => MTrends.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MTrends.fromMap(Map<String, dynamic> json) => new MTrends(
    trends: new List<Trend>.from(json["trends"].map((x) => Trend.fromMap(x))),
    asOf: DateTime.parse(json["as_of"]),
    createdAt: DateTime.parse(json["created_at"]),
    locations: new List<Location>.from(json["locations"].map((x) => Location.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "trends": new List<dynamic>.from(trends.map((x) => x.toMap())),
    "as_of": asOf.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "locations": new List<dynamic>.from(locations.map((x) => x.toMap())),
  };
}

class Location {
  String name;
  int woeid;

  Location({
    this.name,
    this.woeid,
  });

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => new Location(
    name: json["name"],
    woeid: json["woeid"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "woeid": woeid,
  };
}

class Trend {
  String name;
  String url;
  dynamic promotedContent;
  String query;
  int tweetVolume;

  Trend({
    this.name,
    this.url,
    this.promotedContent,
    this.query,
    this.tweetVolume,
  });

  factory Trend.fromJson(String str) => Trend.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Trend.fromMap(Map<String, dynamic> json) => new Trend(
    name: json["name"],
    url: json["url"],
    promotedContent: json["promoted_content"],
    query: json["query"],
    tweetVolume: json["tweet_volume"] == null ? null : json["tweet_volume"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "url": url,
    "promoted_content": promotedContent,
    "query": query,
    "tweet_volume": tweetVolume == null ? null : tweetVolume,
  };
}
