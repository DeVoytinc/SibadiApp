import 'package:flutter/material.dart';
import 'package:untitled1/elemensts/discipMarks.dart';

class CommonStatementItem extends StatefulWidget {
  const CommonStatementItem({
    required this.inputdata,
    super.key,
  });

  final DiscipStatementData inputdata;

  @override
  State<CommonStatementItem> createState() => _CommonStatementItemState();
}

class _CommonStatementItemState extends State<CommonStatementItem> {
  //late DiscipStatementData discipdata;
  bool showInfo = false;

  Widget ktMarks(String text, String mark1, String mark2) => Expanded(
        child: Row(
          children: [
            Expanded(
              flex: 20,
              child: Center(child: Text(text)),
            ),
            Expanded(
              flex: 13,
              child: Center(child: Text(mark1)),
            ),
            Expanded(
              flex: 13,
              child: Center(child: Text(mark2)),
            ),
            Expanded(
              flex: 13,
              child: Container(),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (widget.inputdata.discType == 'Курсовой проект' ||
        widget.inputdata.discType == 'Курсовая работа') {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Center(child: Text(widget.inputdata.number)),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.only(
                        topRight: const Radius.circular(15),
                        bottomRight: Radius.circular(showInfo ? 0 : 15.0),
                        topLeft: const Radius.circular(15),
                        bottomLeft: Radius.circular(showInfo ? 0 : 15.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Center(child: Text(widget.inputdata.zachetka)),
                        ),
                        Expanded(
                          flex: 2,
                          child: DecoratedBox(
                            //color: Theme.of(context).,
                            decoration: BoxDecoration(
                              color: widget.inputdata.result == 'Отл'
                                  ? Theme.of(context).colorScheme.tertiary
                                  : widget.inputdata.result == 'Хор'
                                      ? Theme.of(context).colorScheme.background
                                      : widget.inputdata.result == 'Удв'
                                          ? Theme.of(context)
                                              .colorScheme
                                              .surface
                                          : Theme.of(context).colorScheme.scrim,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Center(child: Text(widget.inputdata.result)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    ///////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////
    else {
      final int result = int.parse(
        widget.inputdata.result == '' ? '-1' : widget.inputdata.result,
      );
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Center(child: Text(widget.inputdata.number)),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 8,
              child: GestureDetector(
                onTap: () => setState(() {
                  showInfo = !showInfo;
                }),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                      //height: asdf ? 100.0 : 50.0,
                      height: 50,
                      //color: Theme.of(context).canvasColor,
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.only(
                          topRight: const Radius.circular(15),
                          bottomRight: Radius.circular(showInfo ? 0 : 15.0),
                          topLeft: const Radius.circular(15),
                          bottomLeft: Radius.circular(showInfo ? 0 : 15.0),
                        ),
                      ),

                      //duration: Duration(milliseconds: 400),

                      // 5 - 90 и больше
                      // 4 - 75 и больше
                      // 3 - 50 и больше
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child:
                                Center(child: Text(widget.inputdata.zachetka)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                widget.inputdata.marksKT1!.result.toString(),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                widget.inputdata.marksKT2!.result.toString(),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: result >= 90
                                    ? Theme.of(context).colorScheme.tertiary
                                    : result >= 75
                                        ? Theme.of(context).colorScheme.surface
                                        : result >= 50
                                            ? Theme.of(context)
                                                .colorScheme
                                                .background
                                            : Theme.of(context)
                                                .colorScheme
                                                .scrim,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Center(
                                child: Text(
                                  widget.inputdata.result,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                      height: showInfo ? 140.0 : 0,
                      //color: Theme.of(context).canvasColor,
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(showInfo ? 15 : 0),
                          topRight: Radius.circular(showInfo ? 0 : 15),
                          bottomLeft: Radius.circular(showInfo ? 15 : 0),
                          topLeft: Radius.circular(showInfo ? 0 : 15),
                        ),
                      ),
                      child: Column(
                        children: [
                          AnimatedPadding(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.ease,
                            padding: showInfo
                                ? const EdgeInsets.symmetric(horizontal: 10)
                                : const EdgeInsets.symmetric(horizontal: 350),
                            child: Container(
                              color: Theme.of(context).dividerColor,
                              height: 1,
                            ),
                          ),
                          ktMarks(
                            'лек.',
                            widget.inputdata.marksKT1!.lection,
                            widget.inputdata.marksKT2!.lection,
                          ),
                          AnimatedPadding(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.ease,
                            padding: showInfo
                                ? const EdgeInsets.symmetric(horizontal: 10)
                                : const EdgeInsets.symmetric(horizontal: 350),
                            child: Container(
                              color: Theme.of(context).dividerColor,
                              height: 1,
                            ),
                          ),
                          ktMarks(
                            'пр.',
                            widget.inputdata.marksKT1!.practic,
                            widget.inputdata.marksKT2!.practic,
                          ),
                          AnimatedPadding(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.ease,
                            padding: showInfo
                                ? const EdgeInsets.symmetric(horizontal: 10)
                                : const EdgeInsets.symmetric(horizontal: 350),
                            child: Container(
                              color: Theme.of(context).dividerColor,
                              height: 1,
                            ),
                          ),
                          ktMarks(
                            'лаб.',
                            widget.inputdata.marksKT1!.lab,
                            widget.inputdata.marksKT2!.lab,
                          ),
                          AnimatedPadding(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.ease,
                            padding: showInfo
                                ? const EdgeInsets.symmetric(horizontal: 10)
                                : const EdgeInsets.symmetric(horizontal: 350),
                            child: Container(
                              color: Theme.of(context).dividerColor,
                              height: 1,
                            ),
                          ),
                          ktMarks(
                            'др.',
                            widget.inputdata.marksKT1!.other,
                            widget.inputdata.marksKT2!.other,
                          ),
                          //SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
