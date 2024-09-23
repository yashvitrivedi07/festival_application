import 'dart:io';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/model/quote_model.dart';
import 'package:flutter_application_1/utils/festival_list.dart';
import 'package:flutter_application_1/utils/all_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';


class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool isquote = false;
  bool iswish = false;
  bool iscolor = false;
  bool isfont = false;
  bool isborder = false;
  bool isalign = false;

  String print = "";
  Color bg_color = Colors.white;
  Color font_color = Colors.black;
  int font_size = 14;
  int border_size = 25;
  String font = "";
  String border = "";
  TextAlign textAlign = TextAlign.center;
  Alignment allalign = Alignment.center;

  GlobalKey imageKey = GlobalKey();

  Future<String> getPath() async {

    final documentsDir = await getApplicationDocumentsDirectory();
    if(Platform.isAndroid)
    {
      return '/storage/emulated/D/Download';
    }
    else{
      final downloadsDir = await getDownloadsDirectory();
      return downloadsDir?.path ?? documentsDir.path;
    }
  }
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final List<dynamic> index =
        (ModalRoute.of(context)!.settings.arguments as Set).toList();

    final QuoteModel fest = index[0] as QuoteModel;
    final String temps = index[1] as String;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Edit Page",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),

        actions: [
          IconButton(onPressed: () async{
          RenderRepaintBoundary boundary = imageKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
          final ui.Image image = await boundary.toImage();
          final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
            final Uint8List pngBytes = byteData!.buffer.asUint8List();

            try{
              await ImageGallerySaver.saveImage(pngBytes);
              log("saved");
            }
            catch(e)
            {
              log("exc${e.toString()}");
            }
          
          }, icon: Icon(Icons.save)),

          IconButton(onPressed: () async {

            RenderRepaintBoundary boundary = imageKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
            final ui.Image image = await boundary.toImage();
            final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
            final Uint8List pngBytes = byteData!.buffer.asUint8List();
          }, icon: Icon(Icons.share))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(20),
                        height: size.height * .7,
                        width: size.width * .7,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(border),
                              scale: border_size.toDouble()),
                          borderRadius: BorderRadius.circular(15),
                          color: bg_color,
                          shape: BoxShape.rectangle,
                        ),
                        child: Container(
                          alignment: allalign,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(temps), fit: BoxFit.cover),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Text(
                              print,
                              style: TextStyle(
                                color: font_color,
                                fontFamily: font,
                                fontSize: font_size.toDouble(),
                              ),
                              textAlign: textAlign,
                            ),
                          ),
                        )),
                  ),
                  Visibility(
                    visible: isquote,
                    child: Align(
                      alignment: Alignment.bottomCenter, // Align at the bottom
                      child: Container(
                          height: size.height * .3,
                          width: size.width * 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade600.withOpacity(.5),
                            border: Border.all(color: Colors.black),
                          ),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: fest.learningQuotes.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        print = fest.learningQuotes[index];
                                      });
                                    },
                                    child: Text(fest.learningQuotes[index]));
                              })),
                    ),
                  ),
                  Visibility(
                    visible: iswish,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      // Align at the bottom
                      child: Container(
                          height: size.height * .3,
                          width: size.width * 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade600.withOpacity(.5),
                            border: Border.all(color: Colors.black),
                          ),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,

                              itemCount: fest.wishes.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  width: size.width,
                                  height: size.height * 0.2,
                                  child: ElevatedButton(
                                    
                                      onPressed: () {
                                        setState(() {
                                          print = fest.wishes[index];
                                        });
                                      },
                                      child: Text(fest.wishes[index],),style: ElevatedButton.styleFrom(
                                                          padding: EdgeInsets.all(10),
                                                          

                                      ),),
                                );
                              })),
                    ),
                  ),
                  Visibility(
                    visible: iscolor,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: size.height * .3,
                        width: size.width * 100,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.grey.shade600.withOpacity(.5)),
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("bg color"),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: all_colors.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          bg_color = all_colors[
                                              index]; // Update the selected color
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundColor: all_colors[index],
                                          radius: 20, // Adjust size as needed
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("font color"),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: all_colors.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          font_color = all_colors[index];
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundColor: all_colors[index],
                                          radius: 20,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isfont,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: size.height * .3,
                        width: size.width * 100,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade600.withOpacity(.5),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(5),
                                    child: const Text("Font STyle")),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {});
                                            font_size += 1;
                                          },
                                          icon: Icon(Icons.add)),
                                      Text(font_size.toString()),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {});
                                            font_size -= 1;
                                          },
                                          icon: Icon(Icons.remove)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: GridView.builder(
                                padding: const EdgeInsets.all(8),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 8 / 3,
                                ),
                                itemCount: Myfonts.values.length,
                                itemBuilder: (context, index) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        font = Myfonts.values[index].name;
                                      });
                                    },
                                    child: Text(Myfonts.values[index].name),
                                    style: ButtonStyle(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isalign,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: size.height * .3,
                        width: size.width * 100,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade600.withOpacity(.5),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: GridView.builder(
                                padding: const EdgeInsets.all(8),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 8 / 3,
                                ),
                                itemCount: alignment.length,
                                itemBuilder: (context, index) {
                                  return IconButton(
                                    onPressed: () {
                                      setState(() {});
                                      if (alignment[index]['type'] ==
                                          'textalign')
                                        textAlign = alignment[index]["align"];
                                      else if (alignment[index]['type'] ==
                                          'align')
                                        allalign = alignment[index]["align"];
                                    },
                                    icon: Image.asset(alignment[index]["icon"]),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isborder,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: size.height * .3,
                        width: size.width * 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700.withOpacity(.5),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(5),
                                    child: const Text("Font STyle")),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {});
                                            border_size += 1;
                                          },
                                          icon: Icon(Icons.add)),
                                      Text(border_size.toString()),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {});
                                            border_size -= 1;
                                          },
                                          icon: Icon(Icons.remove)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: frames.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        border = frames[index];
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                          frames[index],
                                          fit: BoxFit.cover,
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
                    ),
                  )
                ],
              ),
            ),
            // Add the buttons at the bottom
            Container(
                height: size.height * .1,
                width: size.width * 100,
                color: Colors.black,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            isquote = !isquote;
                            iscolor = false;
                            isfont = false;
                            isborder = false;
                            iswish = false;
                            isalign = false;
                          });
                        },
                        label: Text(
                          "Quote",
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: isquote
                            ? Icon(Icons.format_quote, color: Colors.white)
                            : Icon(Icons.format_quote, color: Colors.grey),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            isquote = false;
                            iscolor = false;
                            isfont = false;
                            isborder = false;
                            isalign = false;

                            iswish = !iswish;
                          });
                        },
                        label: Text(
                          "Wishes",
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: isquote
                            ? Icon(Icons.abc, color: Colors.white)
                            : Icon(Icons.abc, color: Colors.grey),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            iscolor = !iscolor;
                            isquote = false;
                            isfont = false;
                            isborder = false;
                            iswish = false;
                            isalign = false;
                          });
                        },
                        label: Text("Color",
                            style: TextStyle(color: Colors.white)),
                        icon: iscolor
                            ? Icon(Icons.color_lens, color: Colors.white)
                            : Icon(Icons.color_lens, color: Colors.grey),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            iscolor = false;
                            isquote = false;
                            isborder = false;
                            iswish = false;
                            isalign = false;

                            isfont = !isfont;
                          });
                        },
                        label:
                            Text("Font", style: TextStyle(color: Colors.white)),
                        icon: isfont
                            ? Icon(Icons.font_download, color: Colors.white)
                            : Icon(Icons.font_download, color: Colors.grey),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            isquote = false;
                            iscolor = false;
                            isfont = false;
                            isborder = false;
                            iswish = false;

                            isalign = !isalign;
                          });
                        },
                        label: Text(
                          "Text Align",
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: isalign
                            ? Icon(Icons.align_horizontal_left_outlined,
                                color: Colors.white)
                            : Icon(Icons.align_horizontal_left_outlined,
                                color: Colors.grey),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            iscolor = false;
                            isquote = false;
                            isfont = false;
                            iswish = false;
                            isalign = false;

                            isborder = !isborder;
                          });
                        },
                        label: Text("Border",
                            style: TextStyle(color: Colors.white)),
                        icon: isborder
                            ? Icon(Icons.border_all, color: Colors.white)
                            : Icon(Icons.border_all, color: Colors.grey),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
