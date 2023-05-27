import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/customSplashscreen.dart';
import 'package:untitled1/screens/autorizationWiget.dart';
import 'package:untitled1/mycolors.dart';
import 'package:untitled1/screens/choose_group.dart';
import 'package:untitled1/screens/choose_zachetkanumber.dart';
import 'package:untitled1/Raspisanie/timetable.dart';
import 'package:untitled1/screens/home_wiget.dart';
import 'package:provider/provider.dart';
import 'Raspisanie/getAudsInRaspisanie.dart';
import 'Statement/statement.dart';
import 'firebase_options.dart';
import 'logic/ConnetionCheck.dart';


List disciplines = [];
bool isautorizesd = false;
bool dartMode = false;


main() async {


  WidgetsFlutterBinding.ensureInitialized();

  await CheckConnection();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(255, 30, 30, 30),
    systemNavigationBarColor: Color.fromARGB(255, 30, 30, 30),
    //systemNavigationBarColor: Color.fromARGB(255, 0, 85, 255),
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);



  var savedGroup = await getSelectedGroup();
  var savedZachetka = await getSelectedZachetka();
  savedRaspis = await getListRaspisaniy();
  if(savedGroup == null || savedZachetka == null) {
    isautorizesd = false;
  }
  else{
    selectedGroup = savedGroup;
    selectedZachetka = savedZachetka;
    isautorizesd = true;
  }
  runApp(isautorizesd ? MyApp() : MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Autorisation()));
}

void clearSharedPrefrences() async{
  var prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future setListRaspisaniy(List<BaseList> r) async{
  var prefs = await SharedPreferences.getInstance();
  prefs.setString('listraspis', BaseList.encode(r));
}

Future<List<BaseList>> getListRaspisaniy() async{
  var prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('listraspis')) {
    String strraspis = await prefs.getString('listraspis')!;
    List<BaseList> raspisJsonMap = BaseList.decode(strraspis);
    return raspisJsonMap;
  } 
  else {
    List<BaseList> list = [];
    return list;
  }

}

Future setRaspisanie(String r, DateTime date) async{
  var prefs = await SharedPreferences.getInstance();
  prefs.setString('raspis', r);
  prefs.setString('raspisdate', date.toString());
}

late DateTime? dateFromLastSave;
Future<String?> getRaspisanie() async{
  var prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('raspisdate')){
    dateFromLastSave = DateTime.parse(prefs.getString('raspisdate')!);
  }else{
    dateFromLastSave = null;
  }
  return prefs.getString('raspis');
}

Future setSelectedGroup() async{
  var prefs = await SharedPreferences.getInstance();
  prefs.setString('group', jsonEncode(selectedGroup.toJson()));
}

Future setSelectedZachetka() async{
  
  var prefs = await SharedPreferences.getInstance();
  prefs.setString('zachetka', jsonEncode(selectedZachetka.toJson()));
}

Future<Group?> getSelectedGroup() async{
  var prefs = await SharedPreferences.getInstance();
  var group = prefs.getString('group');
  if (group == null) return null;
  return Group.fromJson(jsonDecode(group));
}

Future<Zachetka?> getSelectedZachetka() async{
  var prefs = await SharedPreferences.getInstance();
  var zachetka = prefs.getString('zachetka');
  if (zachetka == null) return null;
  return Zachetka.fromJson(jsonDecode(zachetka));
}

class ThemeProvider extends ChangeNotifier {

  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn) {
  themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
  notifyListeners();
  }
}

// light Theme
ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
      primaryColor: Color.fromARGB(255, 52, 65, 255),
      //colorScheme: ColorScheme.fromSwatch().copyWith(primary: Color.fromARGB(255, 108, 189, 255)),
      
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Color.fromARGB(255, 108, 189, 255),
        background: myyellow,
        secondary: myviolet,
        tertiary: mygreen,
        scrim: myred,
        surface: myorange,
      ),
      scaffoldBackgroundColor: Color.fromARGB(255, 235, 235, 235),
      //bottomAppBarColor: Color.fromARGB(255, 255, 255, 255),
      canvasColor: Colors.white,
      
      appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      titleTextStyle: GoogleFonts.alumniSans(
        textStyle: TextStyle(
          fontSize: 40,
          // fontWeight: FontWeight.w300,
          color:  Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      //color: Color.fromARGB(255, 18, 21, 27),
    ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
      )
      );
      
}

// dark Theme
ThemeData darkThemeData(BuildContext context) {
  Color myblue = Color.fromARGB(255, 73, 83, 224);
  Color mybackground = Color.fromARGB(255, 20, 20, 20);
  Color secondary = Color.fromARGB(255, 30, 30, 30);

  return ThemeData.dark().copyWith(
    primaryColor: myblue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: myblue,
      background: myyellowDark,
      secondary: myvioletDark,
      tertiary: mygreenDark,
      scrim: myredDark,
      surface: myorangeDark
    ),
    cardColor: secondary,
    scaffoldBackgroundColor: mybackground,
    drawerTheme: DrawerThemeData(backgroundColor: secondary),
    canvasColor: secondary,
    
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return myblue;
        }
        return Colors.white;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.blue[900];
        }
        return Colors.white38;
      }),
    ),

    appBarTheme: AppBarTheme(
      //backgroundColor: Color.fromARGB(255, 52, 65, 255),
      //titleTextStyle: TextStyle(color:Color.fromARGB(255, 0, 106, 25)),
      titleTextStyle: TextStyle(fontSize: 30, fontWeight:FontWeight.w300),
      color: secondary,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _){
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightThemeData(context),
          darkTheme: darkThemeData(context),
          themeMode: themeProvider.themeMode,
          home: MyCustomSplashScreen(),
        );
      }
    );
  }
}

  
class MyHomePage extends StatefulWidget {
  const MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String title = 'Главная';
  //static List<String> titles = <String>['Главная', 'Расписание', 'Ведомость', 'Карта', 'Мероприятия'];
  int _selectedIndex = 1;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }


  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    TopTabBar(),
    TimeTable(),
    TopTabBarStatement(),
    const Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
    const Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
    const Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];


 @override
  void initState() {
    setState(() {
    
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: dartMode ? lightThemeData(context) : darkThemeData(context), 
        child: BottomNavigationBar(
        //backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        //showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        selectedLabelStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
          fontSize: 13,
        ),
        unselectedLabelStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
          fontSize: 13,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map_outlined, 
            ),
            label: "Карта",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time, 
            ),
            label: "Расписание",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book_outlined, 
            ),
            label: "Ведомость",
          ),
        ]
      ),
      )
    );
  }
}

