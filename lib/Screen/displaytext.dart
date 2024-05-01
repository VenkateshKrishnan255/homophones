import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../AppData/appdatatext.dart';

class DisplayText extends StatelessWidget {
  final AppDataText appDataText; //Object Creation -AppDataText
  const DisplayText({super.key, required this.appDataText}); //We Store Data in appDataText Variale

  @override
  Widget build(BuildContext context) {
    return Stack(
      //Last in first out
      children: [
        Container(
          //Box anything
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(20),
            //We decorate the box
          ),

        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              appDataText.text,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Urbanist',
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
