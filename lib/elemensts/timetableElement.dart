import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/mycolors.dart';
import 'package:flutter/foundation.dart';

// class TimetableElement extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 50),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             alignment: Alignment.topRight,
//             width: 50,
//             height: 30,
//             decoration: BoxDecoration(
//               // borderRadius: BorderRadius.only(
//               //   topLeft: Radius.circular(0),
//               //   bottomLeft: Radius.circular(0),
//               //   topRight: Radius.circular(10),
//               //   bottomRight: Radius.circular(10),
//               // ),
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             color: Theme.of(context).canvasColor,
//             ),
//             child: Center(child: Text('1')),
//           ),
//           Expanded(
//             child: Container(
//               margin: EdgeInsets.only(left: 10),
//               child: Container(
//                 margin: EdgeInsets.only(right: 10),
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), 
//                 //color: Colors.white
//                 ),
//                 child: IntrinsicHeight(
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                           //margin: EdgeInsets.only(left: 40),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(vertical: 20),
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), 
//                             //color: mygreen
//                             ),
//                             child: Center(
//                               child: Column(
//                                 children: [
//                                   Expanded(child: Container(),),
//                                   Expanded(
//                                     child: Column(
//                                       children: [
//                                         Text(
//                                           '16:40',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         SizedBox(height: 7,),
//                                         Container(
//                                           color: Colors.white,
//                                           height: 1,
//                                           width: 50,
//                                         ),
//                                         SizedBox(height: 7,),
//                                         Text(
//                                           '16:40',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Expanded(child: Container(),),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       ),
//                       Expanded(
//                         flex: 4,
//                         child: Container(
//                           margin: EdgeInsets.all(10),
//                           child: Column(
//                             children: [
//                               Text(
//                                 'discipline',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   //color: Colors.black,
//                                 )
//                                 ),
//                               Text(
//                                 'discipline',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   //color: Colors.black,
//                                 )
//                               ),
//                             ],
//                           ),
                                          
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           //SizedBox(height: 100,)
//         ],
//       ),
//     );
    
//   }

// }

class TimetableTimeElement extends StatelessWidget{
  TimetableTimeElement({
    super.key, 
    required this.lessonNumber, 
    required this.timeLesson,
    required this.color,
  });

  int lessonNumber;
  String timeLesson;
  Color color;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12, left: 12, right: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topRight,
            width: 45,
            height: 30,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(0),
              //   bottomLeft: Radius.circular(0),
              //   topRight: Radius.circular(10),
              //   bottomRight: Radius.circular(10),
              // ),
              borderRadius: BorderRadius.circular(8),
            color: color,
            ),
            child: Center(child: Text(
              lessonNumber.toString(),
              style: TextStyle(fontSize: 18),
              )),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft ,
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(10),
                //   bottomLeft: Radius.circular(10),
                //   topRight: Radius.circular(0),
                //   bottomRight: Radius.circular(0),
                // ),
                borderRadius: BorderRadius.circular(8),
              color: color,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  timeLesson,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          //SizedBox(height: 100,)
        ],
      ),
    );
    
  }

}