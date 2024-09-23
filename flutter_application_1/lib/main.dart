import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/edit_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/templete.dart';

void main()
{
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        'temp_page': (context) => Templete_page(),
        'edit_page': (context) => EditPage(),
      },
    );
  }
}