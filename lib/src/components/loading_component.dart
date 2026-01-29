import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/utils/constants.dart';
import 'package:lottie/lottie.dart';

Widget loading() {
  return Center(child: Lottie.asset(loadingAnimation, width: 150, height: 150));
}
