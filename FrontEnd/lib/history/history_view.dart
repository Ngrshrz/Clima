
//import 'dart:js_util';

import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:clima/components/Loading_widget.dart';

import '../services/networking.dart';
import '../utilities/constants.dart';

class Historyview extends StatefulWidget{
 Historyview({Key?key}) : super(key: key);

  @override
  State<Historyview> createState() => _HistoryviewState();
}

class _HistoryviewState extends State<Historyview> {
var weatherDataResult;

  @override
  void initState() {
   
    super.initState();

  }

   dynamic getData() {   

    try {
      NetworkHelper networkHelper = NetworkHelper(
        "$openWeatherMapUrl/Weather/GetHistory");
      var weatherData = networkHelper.getData();
           print('+_+_+_+$weatherData');

      return weatherData;
    } catch (e) {
      print(e);
    }
       
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<dynamic>(future: getData(),
    builder: (context , snapshot)
    {
      if(snapshot.hasData){
        
    weatherDataResult = snapshot.data;

    List<Map> historyList = 
           List.generate(10, (index) => {"id" : index, "city":weatherDataResult[index]["cityName"] ,"date":weatherDataResult[index]["registerDate"],
           "country" : weatherDataResult[index]["countryName"] , "temp" : weatherDataResult[index]["temperature"] })
           .toList();

    print(MediaQuery.of(context).size.width);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 94, 131),
        title: const Text('HISTORY'),
      ),
      body: Padding(
          padding:EdgeInsets.all(8.0),
          child : ListView.builder(
            itemCount: historyList.length,
            itemBuilder: ( _, index) {
              final item=historyList[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(15)
                
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('date: ${item['date'].toString().split('T')[0]} - time: ${item['date'].toString().split('T')[1]}  \ncountry: ${item['country']} - city: ${item['city']} \ntemp: ${item['temp']}')
                   //  Text(item['id'].toString()),
                  ],
                ) ,
              );
            },
            ),
            ), 
         );
    // TODO: implement build
   // throw UnimplementedError();
      }
      else{
       return  LoadingWidget();

      }
    });

  }
}