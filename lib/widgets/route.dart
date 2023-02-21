import 'package:flutter/material.dart';

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: ((context) => page)));
}

void next(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: ((context) => page)));
}

// create stateful class

