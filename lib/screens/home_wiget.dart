import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/main.dart';
//import 'package:untitled1/elemensts/drawer.dart';
import 'package:untitled1/mycolors.dart';
import 'package:untitled1/screens/choose_group.dart';
import 'package:untitled1/screens/choose_zachetkanumber.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        //backgroundColor: Theme.of(context).colorScheme.secondary,
        drawer: //MyDrawer(),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Drawer(
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60,),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mygreenDark,
                    ),
                    child: Center(
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
                  SizedBox(height: 10,),
                  Text(
                    selectedGroup.name,
                    style: TextStyle(
                      fontSize: 30
                      ),
                    ),
                    SizedBox(height: 5,),
                  Text(
                    selectedZachetka.name,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  //SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Divider(),
                  ),
                  TextButton(onPressed: (){}, child: Text('О приложении', style: TextStyle(
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
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Divider(),
                  ), 
                  Container(child: Row(
                    children: [
                    Container(
                      child: TextButton(
                      onPressed: () { clearSharedPrefrences(); main(); },
                      child: Text(
                        'Выйти',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ), 
                      ),),
                      Expanded(child: Container()),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network('https://assets8.lottiefiles.com/packages/lf20_dsxct2el.json', height: 300),
              const Text('В разработке', style: TextStyle(fontSize: 17),),
            ]
          ),
        ),
        appBar: AppBar(
          //backgroundColor: MediaQuery.of(context.),
          title: Padding(
            padding: const EdgeInsets.only(top: 0.0, right: 50),
            child: Center(
              child: Text(
                'Карта',
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
            icon: Icon(
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
  }

  _chandeLightMode(){
    if (dartMode){
      return Icons.lightbulb_outline;
    }
    else{
      return Icons.highlight;
    }
  }
}