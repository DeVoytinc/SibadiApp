import 'package:flutter/material.dart';
import 'package:untitled1/elemensts/discipMarks.dart';

class PersonalStatementItem extends StatefulWidget {
  const PersonalStatementItem({
    required this.inputdata,
    super.key,
  });

  final DiscipStatementData inputdata;

  @override
  State<PersonalStatementItem> createState() => _PersonalStatementItemState();
}

class _PersonalStatementItemState extends State<PersonalStatementItem> {
  bool isActive = false;

  Widget ktMarks(String text, String mark1, String mark2) => Expanded(
        child: Row(
          children: [
            Expanded(
              child: Center(child: Text(text)),
            ),
            Expanded(
              child: Center(child: Text(mark1)),
            ),
            Expanded(
              child: Center(child: Text(mark2)),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (widget.inputdata.discType == 'Курсовая работа' ||
        widget.inputdata.discType == 'Курсовой проект' ||
        widget.inputdata.discType == 'Практика') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: DecoratedBox(
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.inputdata.disciplineName,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.scrim,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                widget.inputdata.result,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
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
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: DecoratedBox(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.inputdata.disciplineName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        left: 8.0,
                                        right: 8.0,),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Expanded(child: Text('КТ 1:')),
                                        Expanded(
                                          child: Text(
                                            widget.inputdata.marksKT1!.result,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        const Expanded(child: Text('КТ 2:')),
                                        Expanded(
                                          child: Text(
                                            widget.inputdata.marksKT2!.result,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: widget.inputdata.result == 'Отл'
                                    ? Theme.of(context).colorScheme.tertiary
                                    : widget.inputdata.result == 'Хор'
                                        ? Theme.of(context)
                                            .colorScheme
                                            .background
                                        : widget.inputdata.result == 'Удв'
                                            ? Theme.of(context)
                                                .colorScheme
                                                .surface
                                            : Theme.of(context)
                                                .colorScheme
                                                .scrim,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    widget.inputdata.result,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
            height: isActive ? 100 : 0,
            color: Theme.of(context).canvasColor,
            child: Column(
              children: [
                AnimatedPadding(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.ease,
                  padding: isActive
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
                  padding: isActive
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
                  padding: isActive
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
                  padding: isActive
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
    );
  }
}
