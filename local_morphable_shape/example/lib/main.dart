import 'package:dimension/dimension.dart';
import 'package:flutter/material.dart';

import 'edit_shape_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shape Editor',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: Colors.amber,
        sliderTheme: SliderTheme.of(context).copyWith(
          inactiveTrackColor: Colors.black.withOpacity(0.2),
          thumbColor: Colors.amber,
          activeTrackColor: Colors.amber,
          overlayColor: Colors.amber.withOpacity(0.2),
        ),
      ),
      home: EditShapePage(),
    );
  }
}
