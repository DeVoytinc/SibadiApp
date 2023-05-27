import 'package:flutter/material.dart';

import '../elemensts/discipMarks.dart';


class PersonalStatementItem extends StatefulWidget {
  const PersonalStatementItem({super.key, required this.inputdata,});

  final DiscipStatementData inputdata;


  @override
  State<PersonalStatementItem> createState() => _PersonalStatementItemState();
}

class _PersonalStatementItemState extends State<PersonalStatementItem> {
  bool isActive = false;


  Widget KTmarks(String text, String mark1, String mark2){
    return Expanded(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(child: Text(text))),
          Expanded(
            flex: 1,
            child: Center(child: Text(mark1))),
          Expanded(
            flex: 1,
            child: Center(child: Text(mark2))),
          Expanded(
            flex: 3, 
            child: Container()),
        ],
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    if (widget.inputdata.discType == 'Курсовая работа' || 
      widget.inputdata.discType == 'Курсовой проект' || 
      widget.inputdata.discType == 'Практика')
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.inputdata.disciplineName,
                              style: TextStyle(
                                fontSize: 18,
                              )
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: 
                            // widget.inputdata.result == 'Отл' ? Theme.of(context).colorScheme.tertiary :
                            // widget.inputdata.result == 'Хор' ? Theme.of(context).colorScheme.background : 
                            // widget.inputdata.result == 'Удв' ? Theme.of(context).colorScheme.surface :
                          Theme.of(context).colorScheme.scrim,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              widget.inputdata.result,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      
       ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isActive = !isActive;
              });
            },
            child: Container(
            //height: 100,
            //margin: EdgeInsets.all(10),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.inputdata.disciplineName,
                                    style: TextStyle(
                                      fontSize: 18,
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(child: Text('КТ 1:')),
                                        Expanded(
                                          child: Text(
                                            widget.inputdata.marksKT1!.result, 
                                            style: TextStyle(
                                              color: Colors.white,
                                              // int.parse(widget.inputdata.result) >= 90 ? Theme.of(context).colorScheme.tertiary :
                                              //   int.parse(widget.inputdata.result) >= 75 ? Theme.of(context).colorScheme.background : 
                                              //   int.parse(widget.inputdata.result) >= 50 ? Theme.of(context).colorScheme.surface :
                                               // Theme.of(context).colorScheme.scrim,
                                              fontSize: 20),)),
                                        Expanded(child: Text('КТ 2:')),
                                        Expanded(
                                          child: Text(
                                            widget.inputdata.marksKT2!.result, 
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20
                                              ),
                                            )
                                          ),
                                        
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: widget.inputdata.result == 'Отл' ? Theme.of(context).colorScheme.tertiary :
                                widget.inputdata.result == 'Хор' ? Theme.of(context).colorScheme.background : 
                                widget.inputdata.result == 'Удв' ? Theme.of(context).colorScheme.surface :
                                Theme.of(context).colorScheme.scrim,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    widget.inputdata.result,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
                ),
          ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
          height: isActive ? 100 : 0,
          color: Theme.of(context).canvasColor,
          child: Column(
            children: [
              AnimatedPadding(
                duration: Duration(milliseconds: 700),
                curve: Curves.ease,
                padding: isActive ? 
                  EdgeInsets.symmetric(horizontal: 10) :
                  EdgeInsets.symmetric(horizontal: 350),
                child: Container(
                  color: Theme.of(context).dividerColor,
                  height: 1,
                ),
              ),
              KTmarks('лек.', 
                widget.inputdata.marksKT1!.lection, 
                widget.inputdata .marksKT2!.lection
              ),
              AnimatedPadding(
                duration: Duration(milliseconds: 700),
                curve: Curves.ease,
                padding: isActive ? 
                  EdgeInsets.symmetric(horizontal: 10) :
                  EdgeInsets.symmetric(horizontal: 350),
                child: Container(
                  color: Theme.of(context).dividerColor,
                  height: 1,
                ),
              ),
              KTmarks('пр.', 
                widget.inputdata.marksKT1!.practic, 
                widget.inputdata.marksKT2!.practic
              ),
              AnimatedPadding(
                duration: Duration(milliseconds: 700),
                curve: Curves.ease,
                padding: isActive ? 
                  EdgeInsets.symmetric(horizontal: 10) :
                  EdgeInsets.symmetric(horizontal: 350),
                child: Container(
                  color: Theme.of(context).dividerColor,
                  height: 1,
                ),
              ),
              KTmarks('лаб.', 
                widget.inputdata.marksKT1!.lab, 
                widget.inputdata.marksKT2!.lab
              ),
              AnimatedPadding(
                duration: Duration(milliseconds: 700),
                curve: Curves.ease,
                padding: isActive ? 
                  EdgeInsets.symmetric(horizontal: 10) :
                  EdgeInsets.symmetric(horizontal: 350),
                child: Container(
                  color: Theme.of(context).dividerColor,
                  height: 1,
                ),
              ),
              KTmarks('др.', 
                widget.inputdata.marksKT1!.other, 
                widget.inputdata.marksKT2!.other
              ),
              //SizedBox(height: 10,)
            ]
          ),
    
        )
        ],
      ),
    );

  }

}