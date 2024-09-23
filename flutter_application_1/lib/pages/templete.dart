import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/quote_model.dart';
import 'package:flutter_application_1/pages/home_page.dart';

class Templete_page extends StatefulWidget {
  const Templete_page({super.key});

  @override
  State<Templete_page> createState() => _Templete_pageState();
}

class _Templete_pageState extends State<Templete_page> {
  @override
  Widget build(BuildContext context) {
    final QuoteModel fest =
        ModalRoute.of(context)!.settings.arguments as QuoteModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Template Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: fest.template.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      final temp = fest.template[index];
                      setState(() {
                        Navigator.pushNamed(context, 'edit_page',
                            arguments: {fest, temp});
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            fest.template[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
