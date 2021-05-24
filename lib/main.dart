import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jungledevs/android/app.dart';
import 'package:jungledevs/ios/app.dart';

void main() => Platform.isIOS ? runApp(IOSApp()) : runApp(AndroidApp());
