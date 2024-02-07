// ignore_for_file: unnecessary_parenthesis

import 'package:flutter/material.dart';
import 'package:untitled1/src/feacher/shedule/choose_shedule/widget/component/choose_shedule_list.dart';
import 'package:untitled1/src/feacher/shedule/getAudsInRaspisanie.dart';
import 'package:untitled1/src/feacher/shedule/choose_shedule/widget/component/sorttabForRaspisanie.dart';

class ChooseRaspisanie extends StatefulWidget {
  const ChooseRaspisanie({super.key, required this.funct});

  final void Function(BaseList) funct;

  @override
  State<ChooseRaspisanie> createState() => _ChooseRaspisanieState();
}

int tabIndex = 0;

class _ChooseRaspisanieState extends State<ChooseRaspisanie> {
  void changeSortTabIndex(int i) {
    setState(() {
      tabIndex = i;
    });
  }

  String searchWord = '';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Найти расписание'),
          elevation: 0,
        ),
        body: Container(
          width: double.infinity,
          color: Theme.of(context).canvasColor,
          child: Column(
            children: [
              Row(
                children: [
                  SortTabRaspisanie(
                    index: 0,
                    label: 'Группы',
                    funk: changeSortTabIndex,
                  ),
                  SortTabRaspisanie(
                    index: 1,
                    label: 'Аудитории',
                    funk: changeSortTabIndex,
                  ),
                  SortTabRaspisanie(
                    index: 2,
                    label: 'Преподователи',
                    funk: changeSortTabIndex,
                  ),
                ],
              ),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      //fillColor: Colors.amber,
                      labelText: 'Поиск',
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.white38,
                      ),
                    ),
                    //controller: TextEditingController(),
                    onChanged: ((value) {
                      setState(() {
                        searchWord = value;
                      });
                    }),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: ListViewOtherrasrisanie(
                    tabIndex: tabIndex,
                    func: widget.funct,
                    searchWord: searchWord,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
