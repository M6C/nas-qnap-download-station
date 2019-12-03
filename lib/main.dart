import 'package:flutter/material.dart';
import 'package:nas_qnap_download_station/ui/TaskAddUrlPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QNap Download Station',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskAddUrlPage(title: 'Task Add Url'),
    );
  }
}
