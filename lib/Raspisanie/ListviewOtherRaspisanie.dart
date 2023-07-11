import 'package:flutter/material.dart';
import 'package:untitled1/Raspisanie/timetable.dart';
import 'package:untitled1/main.dart';

import 'getAudsInRaspisanie.dart';

//List<BaseList> favoritelist = [];

// ignore: must_be_immutable
class ListViewOtherrasrisanie extends StatefulWidget {
  //const ListViewOtherrasrisanie({super.key});
  ListViewOtherrasrisanie(
    {super.key,
    required this.tabIndex,
    required this.func,
    required this.searchWord});

  String searchWord;
  Function(BaseList) func;
  int tabIndex = 0;

  @override
  State<ListViewOtherrasrisanie> createState() => _ListViewOtherrasrisanieState();
}

class _ListViewOtherrasrisanieState extends State<ListViewOtherrasrisanie> {


  List<String> urls = [
    'https://umu.sibadi.org/api/raspGrouplist',
    'https://umu.sibadi.org/api/raspAudlist',
    'https://umu.sibadi.org/api/raspTeacherlist',
  ];



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getListInRaspisanie(urls[widget.tabIndex], widget.searchWord, widget.tabIndex),
        builder: (context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: ListInRaspisanie.length,
                itemBuilder: (BuildContext context, int j) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 7),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                        ),
                        onPressed: () {
                          savedRaspis.add(ListInRaspisanie[j]); 
                          if (savedRaspis.length >= 7){
                            savedRaspis.removeAt(1);
                          }
                          setListRaspisaniy(savedRaspis);
                          widget.func(ListInRaspisanie[j]);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Text(
                              ListInRaspisanie[j].name,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Expanded(child: Container()),
                            // IconButton(
                            //   icon: Icon(
                            //     savedRaspis.contains(ListInRaspisanie[j]) ? Icons.bookmark : Icons.bookmark_border_rounded,
                            //     color: Colors.white60,
                            //   ),
                            //   onPressed: () {
                            //     setState(() {
                            //       savedRaspis.add(ListInRaspisanie[j]); 
                            //     });
                            //     },
                            // )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        });
  }
}
