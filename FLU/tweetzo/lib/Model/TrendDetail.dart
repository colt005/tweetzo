import 'dart:async';

class TrendDetail {
  final List<Trends> trends;
  final List<Locations> locations;
  final String as_of;
  final String created_at;

  TrendDetail({this.trends, this.locations, this.as_of, this.created_at});

  Map<String, dynamic> toJson() => {
        'trends': trends,
        'locations': locations,
        'as_of': as_of,
        'created_at': created_at,
      };

  factory TrendDetail.fromJSON(Map<String, dynamic> trenddetailJson) {
    var trelist = trenddetailJson['trends'] as List;
    List<Trends> trendlist = trelist.map((i) => Trends.fromJson(i)).toList();
    var loclist = trenddetailJson['locations'] as List;
    List<Locations> locationlist =
        loclist.map((i) => Locations.fromJson(i)).toList();

    return new TrendDetail(
      trends: trendlist,
      locations: locationlist,
      as_of: trenddetailJson['as_of'],
      created_at: trenddetailJson['created_at'],
    );
  }
}

class Trends {
  final String name;
  final String url;
  final String promoted_content;
  final String query;
  final String tweet_volume;

  Trends(
      {this.name,
      this.url,
      this.promoted_content,
      this.query,
      this.tweet_volume});

  factory Trends.fromJson(Map<String, dynamic> json) {
    return Trends(
        name: json['name'],
        url: json['url'],
        promoted_content: json['promoted_content'],
        query: json['query'],
        tweet_volume: json['tweet_volume']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
        'promoted_content': promoted_content,
        'query': query,
        'tweet_volume': tweet_volume,
      };
}

class Locations {
  final String name;
  final String woeid;

  Locations({this.name, this.woeid});

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(name: json['name'], woeid: json['woeis']);
  }

  Map<String, dynamic> toJson() => {'name': name, 'woeid': woeid};
}
