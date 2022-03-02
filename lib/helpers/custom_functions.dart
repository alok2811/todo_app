
import 'package:flutter/material.dart';

class CustomFunctions{

  static showLoadingDialog(BuildContext context){
    return showDialog(
      barrierDismissible: false,
      context: context , builder: (BuildContext context) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: CircularProgressIndicator(),),
        );
    },
    );
  }

 static hideLoadingDialog(BuildContext context){
    Navigator.pop(context);
  }

}