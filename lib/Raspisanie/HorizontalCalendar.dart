
// import 'package:flutter/material.dart';

// class HorizontalCalendar extends StatelessWidget {
//   const HorizontalCalendar({super.key});


//   late PageController daysController;


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       width: double.infinity,
//       color: Theme.of(context).appBarTheme.backgroundColor,
//       child: PageView.builder(
//         scrollDirection: Axis.horizontal,
//         controller: daysController,
//         onPageChanged:(value) => setState(() {
//           userinputrasp = false;
//           if (value < daypageindex && userinputcalendar){
//             raspController.jumpToPage(selectedIndex-7);
//           }
//           else if (value > daypageindex && userinputcalendar){
//             raspController.jumpToPage(selectedIndex+7);
//           }
//           userinputcalendar = true;
//           userinputrasp = true;
//           daypageindex = value;
//         }
//         ),
//         itemCount: 26, 
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: Row(
//               children: [
//                 RaspisanieDayConstructor(0 + 7 * index),
//                 RaspisanieDayConstructor(1 + 7 * index),
//                 RaspisanieDayConstructor(2 + 7 * index),
//                 RaspisanieDayConstructor(3 + 7 * index),
//                 RaspisanieDayConstructor(4 + 7 * index),
//                 RaspisanieDayConstructor(5 + 7 * index),
//                 RaspisanieDayConstructor(6 + 7 * index),
                
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }  
// }

