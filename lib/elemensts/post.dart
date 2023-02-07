import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:untitled1/mycolors.dart';



class Post extends StatelessWidget{

@override
      Widget build(BuildContext context) {
     return Container(
        //color: background,
        height: 600,
        child: Container(
          margin: EdgeInsets.all(7),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              //color: Colors.white,
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    color: Theme.of(context).cardColor,
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          margin: EdgeInsets.all(17),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage('https://sun9-31.userapi.com/impg/xhytZCoBRhLJmY59NfstV2q1TZlYJWSWrI1qKw/7Rh7HtvZWmQ.jpg?size=2161x2160&quality=95&sign=2a0eed41b1983888bab44144c837bc8c&type=album'),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 30),
                                  child: Text(
                                    'Профком',
                                    style: TextStyle(
                                      fontSize: 20
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'сегодня в 17:40',
                                    style: TextStyle(
                                      color: Colors.grey,
                                        fontSize: 15
                                    ),
                                  ),
                                )
                              ]
                            ),
                          )
                        )
                      ],
                    )
                  ),

                  // Container(
                  //   height: 320,
                  //   color: Colors.deepPurpleAccent,
                  // ),
                  
                  Image.network(
                    'https://sun9-32.userapi.com/impg/cHKMDVDpF6V4oxwWQN2qp_DcNyaZ4dL7NMlwnQ/-AHNGQSTDIs.jpg?size=1200x1200&quality=95&sign=51ed8a1ef90b33c26f51dd98c936e97c&c_uniq_tag=Y1pIH-BClFdtZqtLukHYJTnZ-Ov79Qb8mZdL72NyOAM&type=album', fit: BoxFit.fill,),
                  Expanded(
                    child: Container(
                      //color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  
  }

}