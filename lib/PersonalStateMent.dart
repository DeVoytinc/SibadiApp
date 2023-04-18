
import 'package:flutter/material.dart';

String groupLink = '?group=13226';

class PersonalStatementItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
    height: 100,
    margin: EdgeInsets.all(10),
    child: Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 100,
              color: Color.fromARGB(255, 14, 110, 165),
              child: Container(
                margin: EdgeInsets.only(left: 7),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: Theme.of(context).canvasColor,
                    child: Row(
                      children: [
                        Container(
                          width: 220,
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                              'Основы программирования',
                              style: TextStyle(
                                fontSize: 18,
                              )
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 85),
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                color: Color.fromARGB(255, 146, 228, 149),
                                child: Center(
                                  child: Text(
                                    '80',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    )
  );

  }

}