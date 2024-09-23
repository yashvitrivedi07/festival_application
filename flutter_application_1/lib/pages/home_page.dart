import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/quote_model.dart';
import 'package:flutter_application_1/utils/festival_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isgrid = false;
  QuoteModel model = QuoteModel.fromMap(data: allData.asMap());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "festivals",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
                isgrid = !isgrid;
              },
              icon: isgrid ? Icon(Icons.grid_view) : Icon(Icons.menu))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: isgrid
              ? Center(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: indianFestivals.length,
                    itemBuilder: (BuildContext context, int index) {
                      final festivals =
                          allData[index]; // Make sure this is correct

                      return Card(
                        child: Container(
                          child: Image.asset(festivals.image),
                        ),
                      );
                    },
                  ),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: indianFestivals.length,
                  itemBuilder: (BuildContext context, int index) {
                    final festivals = allData[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'temp_page',
                            arguments: festivals);
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.blueGrey.shade900, width: .5)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(festivals.image)),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
