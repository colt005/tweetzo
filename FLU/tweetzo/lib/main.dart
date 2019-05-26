import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:twitter/twitter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'Keys/secrets.dart';
import 'package:geolocator/geolocator.dart';





String trendUrl = "/trends/place.json?id=";
String filterUrl = "/statuses/filter.json?track=news";
String whoeid = "2295420";

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List data;
  secrets secret = secrets();
  List trenddata;
  List filterdata;
  String userLattitude;
  String userLongitude;

  
  



  Future getData() async {
    secrets secret = secrets();
    Twitter twitter = new Twitter(secret.CONSUMER_KEY, secret.CONSUMER_SECRET,
        secret.ACCESS_TOKEN, secret.ACCESS_TOKEN_SECRET);
    var response = await twitter.request("GET", trendUrl + whoeid);
    //var response = await twitter.request("POST", filterUrl);

//    var newsresponse = await twitter.request("GET", filterUrl);
//    filterdata = json.decode(newsresponse.body) as List;
//    debugPrint(filterdata[0].toString());
//
    data = json.decode(response.body) as List;
    debugPrint(data[0].toString());
    Map lis2 = new Map.from(data[0]);
   // debugPrint(lis2['trends'].toString());

    trenddata = new List.from(lis2['trends']);
   // debugPrint(trenddata.toString());
  //  debugPrint(trenddata[0]['name'].toString());


    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();

    getData();
    getLocation();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Trends')),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: trenddata == null ? 0 : trenddata.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title:
                  Text(
                "#${trenddata[index]['name'].toString().replaceAll(RegExp("#"), '')}",
                style: TextStyle(fontSize: 15.0),
              ),
              trailing: Text("${trenddata[index]['tweet_volume']}"),
              subtitle: Text("$userLattitude and $userLongitude"),

              onLongPress: (){

                _showAlertDialog("${trenddata[index]['name'].toString()}", trenddata[index]['url']);



              },
            ),
          );
        },
      ),
    );
  }
  AlertDialog _showAlertDialog(String title,String url){
    AlertDialog alertDialog = AlertDialog(
      title: AppBar(title: Text(title)),
      content: SizedBox(
        width: 400.0,
        height: 500.0,
        child: WebviewScaffold(
          resizeToAvoidBottomInset: true,
          withZoom: true,
          withJavascript : true,
          url: url,


        ),
      ),
    );
    showDialog(context: context,builder: (_) => alertDialog);
  }
  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint(position.toString());
    userLongitude = position.longitude.toString();
    userLattitude = position.latitude.toString();
  }


  }




