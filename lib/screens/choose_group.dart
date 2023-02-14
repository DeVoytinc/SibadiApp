
import 'package:flutter/material.dart';
import 'package:untitled1/screens/autorizationWiget.dart';
import 'package:untitled1/screens/choose_zachetkanumber.dart';

import '../main.dart';

late Group selectedGroup;
var searchGroups = groups;

class ChooseGroup extends StatefulWidget{
  ChooseGroup({Key? key}) : super(key: key);

  @override
  _ChooseGroupState createState() => _ChooseGroupState();
}

class _ChooseGroupState extends State<ChooseGroup> with SingleTickerProviderStateMixin{

  void goBack(BuildContext context){
    Navigator.pop(context);
  }

  void goToNextPage(BuildContext context){
    Navigator.push(
      context, 
      new MaterialPageRoute(builder: (BuildContext context) => 
        new ChooseZachetca()
      )
    );
  }

  @override
  void initState() {
    setState(() {
      //getData(selectedDate);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 60, 116, 213),
          // The search area here
        title: Container(
          child: Center(
            child: Text("Номер группы",),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Colors.white,),
          onPressed: () {
            //runApp(MaterialApp(home: Autorisation()));
            goBack(context);
          },
        ),
        actions: [Icon(Icons.arrow_back,
          color: Color.fromARGB(255, 60, 116, 213),
          ),
        ]
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
            child: TextField(
               decoration: const InputDecoration(
                  labelText: 'Поиск',
                   suffixIcon: Icon(Icons.search,
                  color:Color.fromARGB(255, 60, 116, 213),
                  ),
                  ),
              //controller: TextEditingController(),
              onChanged: ((value) {
                setState(() {
                  searchGroups = groups.where((element) => 
                  element.name.toLowerCase().startsWith(value.toLowerCase())).toList();
                });
              }
            ),
            ),
          ),
          const SizedBox(
              height: 20,
            ),
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: getGroups(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    controller: ScrollController(),
                    itemCount: searchGroups.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          selectedGroup = searchGroups[index];
                          setSelectedGroup();
                          goToNextPage(context);
                        },
                        child: Container(
                          
                          margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                          decoration: BoxDecoration (
                          borderRadius: BorderRadius.circular(6),
                          color: Color.fromARGB(255, 60, 116, 213),
                          ),
                          height: 75,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Container()),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Text(
                                          (index + 1).toString(),
                                          style: TextStyle(
                                          fontSize: 25,
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              searchGroups[index].name,
                                              style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(255, 255, 255, 255),
                                              ),
                                            ),
                                            Text(
                                              searchGroups[index].fack,
                                              style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(144, 255, 255, 255),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                          
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ),
                      );
                    }
                  );

                },
              ),
            ),
          ),
        ],
      ),
    //)
    );
  }
}