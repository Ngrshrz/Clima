
import 'package:clima/components/Loading_widget.dart';
import 'package:clima/components/error_message.dart';
import 'package:clima/history/history_view.dart';
import 'package:clima/main.dart';
import 'package:clima/model/weather_model.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/utilities/weather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

import '../components/details_widget.dart';




class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

  class _HomeState extends State<Home> {
  bool isDataLoaded = false ;
  bool isErrorOcured = false;
  double? latitud , longitud ;
  GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance ;
  LocationPermission? permission ;
  WeatherModel?weatherModel;
  int code = 0 ;
  Weather weather = Weather();
  var weatherData;
  String? title , message;

  
  //var KTextFieldDecoration;
  
  //get KTextFieldDecoration => null;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpermission();
  }



  void getpermission () async{
    permission = await geolocatorPlatform.checkPermission();
    if( permission== LocationPermission.denied ){
      print('permission denied');
      permission = await geolocatorPlatform.requestPermission();
      if ( permission!= LocationPermission.denied){
        if( permission == LocationPermission.deniedForever){
          print(
    'permission permanently denid,please provide permission to the app from device settings');
        setState(() {
          isDataLoaded = true ;
          isErrorOcured = true;
          title = 'permision permanently denied';
          message= 'please provide permission to the app from device settings';
        });
        }else{
          print( 'permission granted ');
          updateUI();
        }
      }else {
        print( 'User denied the request');
        updateUI(cityname: 'tehran');
      }
    }else{

      updateUI();
    }
  }

  void updateUI({String? cityname}) async{
    weatherData = null ;
    if(cityname == null || cityname == ''){
      if(!await geolocatorPlatform.isLocationServiceEnabled()){
      setState(() {
        isErrorOcured = true ;
        isDataLoaded = true ;
        title = 'location is turned off';
        message = 'Please enable the location service to see weather condition for your location';
       return;
      });
    }
      weatherData = await weather.getlocationWeather();
    }else{
      weatherData = await weather.getCityWeather(cityname);
    }
    if(weatherData==null){
      setState(() {
        title = 'City not found';
        message = 'Please make sure you have entered the right city name';
        isDataLoaded = true;
        isErrorOcured = true;
        return;
      });


    }
      code = weatherData ['weather'][0]['id'];
      weatherModel = WeatherModel(
        description : weatherData['weather'][0]['description'],
         location : weatherData['name']+','+weatherData['sys']['country'],
         temperature : weatherData['main']['temp'],
         feelslike :  weatherData['main']['feels_like'],
         humidity:  weatherData['main']['humidity'],
         wind :  weatherData['wind']['speed'],
         icon : 'images/weather-icons/${getIconPrefix(code)}${kWeatherIcons[code.toString()]!['icon']}.svg',
      );

      setState(() {
         isDataLoaded = true;
         isErrorOcured = false;
      });

     isDataLoaded = true;
     print(latitud);
     print(longitud);

  }

  @override
  Widget build(BuildContext context) {
     if(!isDataLoaded){
       return  LoadingWidget();
     }else{
    return  Scaffold(
      resizeToAvoidBottomInset:false ,
      backgroundColor: Color.fromRGBO(41, 79, 105, 1),
      body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: TextField(

                        decoration:kFieldDecoration,
                        onSubmitted:(String typedName){
                          setState(() {
                            isDataLoaded = false;
                            updateUI(cityname: typedName);
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child:Padding(
                      padding: const EdgeInsets.all(12),
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            isDataLoaded = false;
                            getpermission();
                          });

                        },
                        style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.blueGrey,
                         // backgroundColor: Colors.white10,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),

                          ),
                        ),
                        child:Container(

                          height: 60,
                          child: Row(
                            children: [
                              Text('My Location' , style:kTextFieldTexeStyle,),
                              SizedBox(width: 8,),
                              Icon(Icons.gps_fixed , color: Colors.white60,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              isErrorOcured?
              ErrorMesaage(title: title!, message: message!):
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment :MainAxisAlignment.center,
                      children:[
                        Icon(Icons.location_city , color: KMidlightColor ,),
                        SizedBox(width: 12),
                        Text( weatherModel!.location!, 
                        style:kLocationTextStyle),
                      ],
                    ),
                    SizedBox(height: 25),
                    Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                      SvgPicture.asset(
                    weatherModel!.icon!,
                    height: 280,
                    color: KlightColor,

                    ),
                   
                    Column(children: [
                      Text('${weatherModel!.temperature!.round()}°' , style:  kTempTextStyle , ),
                    Text(weatherModel!.description!.toUpperCase(), style: kLocationTextStyle ,),
                    ],
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () { 
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Historyview()));
                    },
                    child: Text("HISTORY"),)
                    ],))
                  ],
              
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.blueGrey,
                  child: Container(height: 90,
                   child: Row(
                     mainAxisAlignment :MainAxisAlignment.spaceEvenly,
                     crossAxisAlignment:CrossAxisAlignment.center ,
                     children: [
                       DetailsWidget(
                         title: 'FEELS LIKE ',
                         value: '${weatherModel!=null? weatherModel!.feelslike!.round():0}°',
                       ),
                       Padding(
                         padding: const EdgeInsets.all(15),
                         child: VerticalDivider( thickness: 2),
                       ),
                       DetailsWidget(
                         title: 'HUMIDITY ',
                         value: '${weatherModel!=null? weatherModel!.humidity! :0}%',
                       ),
                       Padding(
                         padding: const EdgeInsets.all(15),
                         child: VerticalDivider( thickness: 2),
                       ),
                       DetailsWidget(
                         title: 'WIND ',
                         value: '${weatherModel!=null? weatherModel!.wind!.round():0}',
                       ),
                     ],
                   ),
                  ),

                ),
              ),
            ],
          ),
        
      ),
    );
  }
  }
}

  


  //var id = decodedData['weather'][0]['id'];
  //var temperature =decodedData['main']['temp'];
  //var cityname = decodedData['name'];

  //print(id);
  //print(temperature);
  //print(cityname);

