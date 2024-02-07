import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/firebase_options.dart';
import 'package:untitled1/logic/ConnetionCheck.dart';
import 'package:untitled1/mycolors.dart';
import 'package:untitled1/screens/autorizationWiget.dart';
import 'package:untitled1/screens/choose_group.dart';
import 'package:untitled1/screens/choose_zachetkanumber.dart';
import 'package:untitled1/screens/home_wiget.dart';
import 'package:untitled1/splash_screen.dart';
import 'package:untitled1/src/feacher/progress_report/widget/screen/report_card_screen.dart';
import 'package:untitled1/src/feacher/shedule/getAudsInRaspisanie.dart';
import 'package:untitled1/src/feacher/shedule/shedule/widget/screen/shedule_screen.dart';

bool isautorizesd = false;
bool dartMode = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CheckConnection();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 30, 30, 30),
      systemNavigationBarColor: Color.fromARGB(255, 30, 30, 30),
      //systemNavigationBarColor: Color.fromARGB(255, 0, 85, 255),
    ),
  );
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  final savedGroup = await getSelectedGroup();
  final savedZachetka = await getSelectedZachetka();
  savedRaspis = await getListRaspisaniy();
  if (savedGroup == null || savedZachetka == null) {
    isautorizesd = false;
  } else {
    selectedGroup = savedGroup;
    selectedZachetka = savedZachetka;
    isautorizesd = true;
  }
  runApp(const MyApp());
}

Future<void> clearSharedPrefrences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

Future<void> setListRaspisaniy(List<BaseList> r) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('listraspis', BaseList.encode(r));
}

Future<List<BaseList>> getListRaspisaniy() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('listraspis')) {
    final String strraspis = prefs.getString('listraspis')!;
    final List<BaseList> raspisJsonMap = BaseList.decode(strraspis);
    return raspisJsonMap;
  } else {
    final List<BaseList> list = [];
    return list;
  }
}

Future<void> setRaspisanie(String r, DateTime date) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('raspis', r);
  await prefs.setString('raspisdate', date.toString());
}

late DateTime? dateFromLastSave;
Future<String?> getRaspisanie() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('raspisdate')) {
    dateFromLastSave = DateTime.parse(prefs.getString('raspisdate')!);
  } else {
    dateFromLastSave = null;
  }
  return prefs.getString('raspis');
}

Future<void> setSelectedGroup() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('group', jsonEncode(selectedGroup.toJson()));
}

Future<void> setSelectedZachetka() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('zachetka', jsonEncode(selectedZachetka.toJson()));
}

Future<Group?> getSelectedGroup() async {
  final prefs = await SharedPreferences.getInstance();
  final group = prefs.getString('group');
  if (group == null) return null;
  return Group.fromJson(jsonDecode(group) as Map<String, dynamic>);
}

Future<Zachetka?> getSelectedZachetka() async {
  final prefs = await SharedPreferences.getInstance();
  final zachetka = prefs.getString('zachetka');
  if (zachetka == null) return null;
  return Zachetka.fromJson(jsonDecode(zachetka) as Map<String, dynamic>);
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
ThemeData lightThemeData(BuildContext context) => ThemeData.light().copyWith(
      primaryColor: const Color.fromARGB(255, 52, 65, 255),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromARGB(255, 108, 189, 255),
        background: myyellow,
        secondary: myviolet,
        tertiary: mygreen,
        scrim: myred,
        surface: myorange,
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 235, 235, 235),
      //bottomAppBarColor: Color.fromARGB(255, 255, 255, 255),
      canvasColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        titleTextStyle: GoogleFonts.alumniSans(
          textStyle: const TextStyle(
            fontSize: 40,
            // fontWeight: FontWeight.w300,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        //color: Color.fromARGB(255, 18, 21, 27),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
      ),
    );

// dark Theme
ThemeData darkThemeData(BuildContext context) {
  const Color myblue = Color.fromARGB(255, 73, 83, 224);
  const Color mybackground = Color.fromARGB(255, 20, 20, 20);
  const Color secondary = Color.fromARGB(255, 30, 30, 30);

  return ThemeData.dark().copyWith(
    primaryColor: myblue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: myblue,
      background: myyellowDark,
      secondary: myvioletDark,
      tertiary: mygreenDark,
      scrim: myredDark,
      surface: myorangeDark,
    ),
    cardColor: secondary,
    scaffoldBackgroundColor: mybackground,
    drawerTheme: const DrawerThemeData(backgroundColor: secondary),
    canvasColor: secondary,
    //useMaterial3: true,

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

    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
      color: secondary,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightThemeData(context),
            darkTheme: darkThemeData(context),
            themeMode: themeProvider.themeMode,
            home: isautorizesd
                ? MyCustomSplashScreen()
                : StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.data == null) {
                          return Autorisation();
                        } else {
                          return const ChooseGroup();
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
          );
        },
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    TopTabBar(),
    const TimeTable(),
    const TopTabBarStatement(),
  ];

  @override
  void initState() {
    setState(() {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
            selectedLabelStyle:
                Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                      fontSize: 13,
                    ),
            unselectedLabelStyle:
                Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                      fontSize: 13,
                    ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.grid_view_rounded,
                ),
                label: "Сервисы",
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
            ],
          ),
        ),
      );
}
