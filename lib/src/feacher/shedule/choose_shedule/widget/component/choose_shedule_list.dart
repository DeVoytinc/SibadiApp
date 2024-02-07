import 'package:flutter/material.dart';
import 'package:untitled1/src/feacher/shedule/getAudsInRaspisanie.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/src/feacher/shedule/shedule/widget/screen/shedule_screen.dart';

class ListViewOtherrasrisanie extends StatefulWidget {
  ListViewOtherrasrisanie({
    required this.tabIndex,
    required this.func,
    required this.searchWord,
    super.key,
  });

  String searchWord;
  Function(BaseList) func;
  int tabIndex = 0;

  @override
  State<ListViewOtherrasrisanie> createState() =>
      _ListViewOtherrasrisanieState();
}

class _ListViewOtherrasrisanieState extends State<ListViewOtherrasrisanie> {
  List<String> urls = [
    'https://umu.sibadi.org/api/raspGrouplist',
    'https://umu.sibadi.org/api/raspAudlist',
    'https://umu.sibadi.org/api/raspTeacherlist',
  ];

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: getListInRaspisanie(
          urls[widget.tabIndex],
          widget.searchWord,
          widget.tabIndex,
        ),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: ListInRaspisanie.length,
              itemBuilder: (BuildContext context, int j) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 7,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    style: const ButtonStyle(
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () {
                      savedRaspis.add(ListInRaspisanie[j]);
                      if (savedRaspis.length >= 7) {
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
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      );
}
