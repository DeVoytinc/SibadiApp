import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/screens/autorizationWiget.dart';
import 'package:untitled1/screens/choose_zachetkanumber.dart';

late Group selectedGroup;
var searchGroups = groups;

class ChooseGroup extends StatefulWidget{
  const ChooseGroup({super.key});

  @override
  _ChooseGroupState createState() => _ChooseGroupState();
}

class _ChooseGroupState extends State<ChooseGroup> with SingleTickerProviderStateMixin{

  void goBack(BuildContext context){
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }

  Future<void> goToNextPage(BuildContext context) async{
    final List<Zachetka> zach = await getZachetcki();
    if (zach.isEmpty){
      selectedZachetka = const Zachetka(kod: '?', name: '?');
      await setSelectedZachetka();
      await Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (BuildContext context) => 
          const MyHomePage()
        ), (Route<dynamic> route) => false);
    } else {
      await Navigator.push(
        context, 
        new MaterialPageRoute(builder: (BuildContext context) => 
          new ChooseZachetca()
        )
      );
    }
  }

  @override
  void initState() {
    setState(() {
      //getData(selectedDate);
    });
    super.initState();
  }

  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 106, 255),
        title: const Center(
          child: const Text("Номер группы",),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
          color: Colors.white,),
          onPressed: () {
            goBack(context);
          },
        ),
        actions: const [Icon(Icons.arrow_back,
          color: Color.fromARGB(255, 20, 106, 255),
          ),
        ]
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
            child: TextField(
              controller: searchTextController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Поиск',
                labelStyle: TextStyle(color: Colors.black38),
                suffixIcon: Icon(Icons.search,
                  color:Color.fromARGB(255, 20, 106, 255),
                ),
              ),
              onEditingComplete: () {
                setState(() {
                  searchGroups = groups.where((element) => 
                  element.name.toLowerCase().startsWith(searchTextController.text.toLowerCase())).toList();
                });
              }
            ,
            ),
          ),
          const SizedBox(
              height: 20,
            ),
          Expanded(
            child: FutureBuilder(
              future: getGroups(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done){
                  return ListView.builder(
                    controller: ScrollController(),
                    itemCount: searchGroups.length,
                    itemBuilder: (BuildContext context, int index) => GestureDetector(
                        onTap: () {
                          selectedGroup = searchGroups[index];
                          setSelectedGroup();
                          goToNextPage(context);
                        },
                        child: Container(
                          
                          margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                          decoration: BoxDecoration (
                          borderRadius: BorderRadius.circular(6),
                          color: const Color.fromARGB(255, 20, 106, 255),
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
                                    Padding(
                                      padding: const EdgeInsets.only(right: 13.0),
                                      child: Text(
                                        (index + 1).toString(),
                                        style: const TextStyle(
                                        fontSize: 25,
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              searchGroups[index].name,
                                              style: const TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(255, 255, 255, 255),
                                              ),
                                            ),
                                            Text(
                                              searchGroups[index].fack,
                                              style: const TextStyle(
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
                      )
                  );
                }
                else{
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
}
