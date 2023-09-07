
 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 const apikey='26905d293d6915645d8591d3fa27c2e2';
 const openWeatherMapUrl = "http://www.matingoshtasbi.com";

 const KlightColor = Colors.white;
 const KMidlightColor = Colors.white ;
 const kTextFieldTexeStyle = TextStyle(
  fontSize: 16 ,
  color: KMidlightColor,
 );

  var kLocationTextStyle = GoogleFonts.monda (
  fontSize: 20,
  color: KMidlightColor ,
 );
 var kTempTextStyle = GoogleFonts.daysOne(
  fontSize: 80 ,
 );

  var kDetailsTextStyle = GoogleFonts.monda(
  fontSize: 20 ,
  color: KMidlightColor ,
  fontWeight: FontWeight.bold,
 );

 var kDetailsTitleTextStyle = GoogleFonts.monda(
  fontSize: 16,
  color: Colors.white60,
  fontWeight: FontWeight.bold,
 );


 // ignore: constant_identifier_names
 const kFieldDecoration = InputDecoration(
  fillColor: Colors.blueGrey ,
  filled: true ,
  border: OutlineInputBorder(
   borderRadius: BorderRadius.all(Radius.circular(10)),
   borderSide: BorderSide.none,
  ),
  hintText: 'Enter city Name',
  hintStyle: kTextFieldTexeStyle,
  prefixIcon: Icon(Icons.search),
 );

 var kDetailsSuffixTextStyle = GoogleFonts.monda(
  fontSize: 12,
  color: KMidlightColor ,
 );











