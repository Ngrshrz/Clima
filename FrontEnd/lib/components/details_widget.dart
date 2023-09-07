
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../utilities/constants.dart';

class DetailsWidget extends StatelessWidget {
  final String title , value ;
  const DetailsWidget({
    required this.title , required this.value
  }) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment :MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text( value, style: kDetailsTextStyle, ),
            Visibility(
                visible: title.trim()== 'WIND' ? true : false,
                child:  Text(' km/hr', style: kDetailsTitleTextStyle,)),
          ],
        ),
        Text(title , style:kDetailsTitleTextStyle)
      ],
    );
  }
}