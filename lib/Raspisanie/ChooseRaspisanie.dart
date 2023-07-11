import 'package:flutter/material.dart';
import 'package:untitled1/Raspisanie/getAudsInRaspisanie.dart';

import 'ListviewOtherRaspisanie.dart';
import 'sorttabForRaspisanie.dart';

class ChooseRaspisanie extends StatefulWidget {
  ChooseRaspisanie({super.key, required this.funct});

  final Function(BaseList) funct;

  @override
  State<ChooseRaspisanie> createState() => _ChooseRaspisanieState();
}

int tabIndex = 0;

class _ChooseRaspisanieState extends State<ChooseRaspisanie> {
  

  changeSortTabIndex(int i){
    setState(() {
      tabIndex = i;
      
    });
  }

  String searchWord = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Найти расписание'),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        color: Theme.of(context).canvasColor,
        child: Column(
          children: [
            Row(
              children: [
                SortTabRaspisanie(index: 0, label: 'Группы', funk: changeSortTabIndex,),
                SortTabRaspisanie(index: 1, label: 'Аудитории',funk: changeSortTabIndex,),
                SortTabRaspisanie(index: 2, label: 'Преподователи',funk: changeSortTabIndex,),
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
                      suffixIcon: Icon(Icons.search,
                      color:Colors.white38,
                      ),
                      ),
                  //controller: TextEditingController(),
                  onChanged: ((value) {
                    setState(() {
                      searchWord = value;
                    });
                  }
                ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: ListViewOtherrasrisanie(tabIndex: tabIndex, func: widget.funct, searchWord: searchWord,)
              ),
            )
          ]
        ),
      ),
      
    );
  }
}