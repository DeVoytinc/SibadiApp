import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/firebase/firebase_auth_user.dart';
import 'package:untitled1/main.dart';
//import 'package:untitled1/elemensts/drawer.dart';
import 'package:untitled1/mycolors.dart';
import 'package:untitled1/screens/autorizationWiget.dart';
import 'package:untitled1/screens/choose_group.dart';
import 'package:untitled1/screens/choose_zachetkanumber.dart';
import 'package:untitled1/screens/services_screen/about_app_screen.dart';
import 'package:untitled1/screens/services_screen/bibly_auth_screen.dart';
import 'package:untitled1/screens/services_screen/block_screen.dart';
import 'package:untitled1/screens/services_screen/fitness_screen.dart';
import 'package:untitled1/screens/services_screen/map.dart';
import 'package:untitled1/screens/services_screen/money_screen.dart';
// import 'package:http/http.dart' as http; 
// import 'package:html/parser.dart';

ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);

class TopTabBar extends StatefulWidget{
  TopTabBar({Key? key,}) : super(key: key);

  @override
  _TopTabBarState createState() => _TopTabBarState();
}

class _TopTabBarState extends State<TopTabBar> with SingleTickerProviderStateMixin{
  // late TabController _tabController;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  // getData() async {
  //   // if (disciplines.isNotEmpty) {
  //   //   return disciplines;
  //   // }
  //   disciplines.clear();
  //   var client = http.Client();
  //   final response =
  //   await client.get(Uri.parse('https://vk.com/wall-154434845?own=1'));
    
  //   if (response.statusCode == 200) {
  //     //var document = parse(response.body, encoding:'utf-8');
  //     //var table = document.getElementsByClassName('_post_content');
      
  //     //disciplines.add('хуй');
  //     return disciplines;
  //   }
  //   return disciplines;
  // }

  @override
  void initState() {
    super.initState();
   // _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
   // _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
        key: scaffoldKey,
        //backgroundColor: Theme.of(context).colorScheme.secondary,
        drawer: //MyDrawer(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Drawer(
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60,),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: mygreenDark,
                    ),
                    child: const Center(
                      child: Icon(Icons.person, size: 35,),
                      // child: Text(
                      //   '5',
                      //   style: TextStyle(
                      //     fontSize: 40,
                      //     color: Colors.white,
                      //   ),
                      // )
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    selectedGroup.name,
                    style: const TextStyle(
                      fontSize: 30
                      ),
                    ),
                    const SizedBox(height: 5,),
                  Text(
                    selectedZachetka.name,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  //SizedBox(height: 20,),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Divider(),
                  ),
                  TextButton(onPressed: (){
                    Navigator.push(
                      context, 
                      new MaterialPageRoute(
                        builder: (BuildContext context) => 
                          new AboutApp())
                    );
                    }, child: const Text('О приложении', style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w400
                  ),)),
                  //SizedBox(height: 20,),
                  // Container(
                  //   child: Row(children: [
                  //     Icon(Icons.settings),
                  //     Text('Настройки')
                  //   ]),
                  // ),
                  Expanded(child: Container(),),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Divider(),
                  ), 
                  Container(
                    child: Row(
                      children: [
                      Container(
                        child: TextButton(
                        onPressed: () { 
                          clearSharedPrefrences();
                          Navigator.pushAndRemoveUntil(
                          context, 
                          new MaterialPageRoute(builder: (BuildContext context) => 
                            new Autorisation()
                          ), (Route<dynamic> route) => false);
                          if (FirebaseAuth.instance.currentUser != null)
                            Auth().signOut(); 
                          },


                        child: const Text(
                          'Выйти',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ), 
                        ),
                      ),
                      Expanded(child: Container()),
                      // Container(
                      //   child: TextButton(
                      //   onPressed: () { Auth().signOut(); },
                      //   child: Text(
                      //     'Выйти из аккаунта google',
                      //     style: TextStyle(
                      //       color: Colors.red,
                      //       fontSize: 16,
                      //     ),
                      //   ), 
                      //   ),
                      // ),

                    // IconButton(
                    //   isSelected: dartMode,
                    //   onPressed: () {
                    //     final provider = Provider.of<ThemeProvider>(context, listen: false);
                    //     provider.toggleTheme(dartMode);
                    //     setState(() {
                    //       dartMode = !dartMode;
                    //     });
                    // }, icon: Icon(_chandeLightMode()))
                  ],))
                ]
              ),
            ),
          ),
        ),
        body: Center(
          // child: Column(children: [
          //     Lottie.network('https://assets8.lottiefiles.com/packages/lf20_dsxct2el.json', height: 300),
          //     const Text('В разработке', style: TextStyle(fontSize: 17),),

          // ],)
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () { 
                        Navigator.push(
                          context, 
                          new MaterialPageRoute(
                            builder: (BuildContext context) => 
                              new MapScreen())
                              //new BlockScreen())
                        );
                       },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).canvasColor,
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                        fixedSize: const Size(100, 100),
                      ),
                      child: const Icon(Icons.map, size: 70,),
                    ),
                  ),
                const Text("Карта")
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () { 
                        Navigator.push(
                          context, 
                          new MaterialPageRoute(
                            builder: (BuildContext context) => 
                              //new Spravki())
                              new BlockScreen())
                        );
                       },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).canvasColor,
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                        fixedSize: const Size(100, 100),
                      ),
                      child:  const Icon(Icons.description_outlined, size: 70,),
                    ),
                  ),
                const Text("Справки")
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () { 
                        Navigator.push(
                          context, 
                          new MaterialPageRoute(
                            builder: (BuildContext context) => 
                              //new Spravki())
                              new AboutMoneyScreen())
                        );
                       },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).canvasColor,
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                        fixedSize: const Size(100, 100),
                      ),
                      child:  const Icon(Icons.attach_money, size: 70,),
                    ),
                  ),
                const Text("Стипендии")
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () { 
                        Navigator.push(
                          context, 
                          new MaterialPageRoute(
                            builder: (BuildContext context) => 
                              //new Spravki())
                              new BibliyAuthScreen())
                        );
                       },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).canvasColor,
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                        fixedSize: const Size(100, 100),
                      ),
                      child:  const Icon(Icons.menu_book_sharp, size: 70,),
                    ),
                  ),
                const Text("Библиотека")
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () { Navigator.push(
                          context, 
                          new MaterialPageRoute(
                            builder: (BuildContext context) => 
                              //new Spravki())
                              new BlockScreen())
                        ); },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).canvasColor,
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                        fixedSize: const Size(100, 100),
                      ),
                      child:  const Icon(Icons.portrait_rounded, size: 70,),
                    ),
                  ),
                const Text("Портфолио")
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () { 
                        FirebaseAuth.instance
                        .idTokenChanges()
                        .listen((User? user) {
                          if (user == null) {
                            print('User is currently signed out!');
                            Navigator.push(
                              context, 
                              new MaterialPageRoute(builder: (BuildContext context) => 
                                new FireAuth()
                              )
                            );
                            return;
                          } else {
                            Navigator.push(
                              context, 
                              new MaterialPageRoute(
                                builder: (BuildContext context) => 
                                  new FitnessScreen())
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).canvasColor,
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                        fixedSize: const Size(100, 100),
                      ),
                      child:  const Icon(Icons.fitness_center_rounded, size: 70,),
                    ),
                  ),
                const Center(child: Text("Планер тренировок"))
                ],
              ),
            ],
          )
        ),
        appBar: AppBar(
          //backgroundColor: MediaQuery.of(context.),
          title: const Padding(
            padding: EdgeInsets.only(top: 0.0, right: 50),
            child: Center(
              child: Text(
                'Сервисы',
                style: TextStyle(
                  //color: myblue,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () async {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu, 
              //color: myblue,
              ),
    
          ),
          // bottom: PreferredSize(
          //   preferredSize: Size.fromHeight(kToolbarHeight),
          //   child: Container(
            //color: Colors.white,
            // child: TabBar(
            //   indicatorColor: myblue,
            //   controller: _tabController,
            //   tabs: <Widget>[
            //     Tab(
            //       child: Text(
            //         'Новости',
            //         style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
            //           fontSize: 20,
            //         ),
            //         //textScaleFactor: 1.3,
            //       ),
            //     ),
            //     Tab(
            //       child: Text(
            //         'Для вас',
            //         style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
            //           fontSize: 20,
            //         ),
            //       ),
            //     ),
            //     Tab(
            //       child: Text(
            //         'Профком',
            //         style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
            //           fontSize: 20,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            //)
          //),
        ),
    );

  _chandeLightMode(){
    if (dartMode){
      return Icons.lightbulb_outline;
    }
    else{
      return Icons.highlight;
    }
  }
}