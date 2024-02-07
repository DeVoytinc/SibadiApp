import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  //const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

Map<String, dynamic> mapFloors = {
  '1': {
    0: 'lib/images/1 korpus/1.0.png',
    1: 'lib/images/1 korpus/1.1.png',
    2: 'lib/images/1 korpus/1.2.png',
    3: 'lib/images/1 korpus/1.3.png',
    4: 'lib/images/1 korpus/1.4.png',
  },
  '2': {
    0: 'lib/images/2 korpus/2.0.png',
    1: 'lib/images/2 korpus/2.1.png',
    2: 'lib/images/2 korpus/2.2.png',
    3: 'lib/images/2 korpus/2.3.png',
    4: 'lib/images/2 korpus/2.4.png',
  },
  '3': {
    0: 'lib/images/3 korpus/3.0.png',
    1: 'lib/images/3 korpus/3.1.png',
    2: 'lib/images/3 korpus/3.2.png',
    3: 'lib/images/3 korpus/3.3.png',
    4: 'lib/images/3 korpus/3.4.png',
    5: 'lib/images/3 korpus/3.5.png',
  },
  '4': {
    1: 'lib/images/4 korpus/4.1.png',
    2: 'lib/images/4 korpus/4.2.png',
    3: 'lib/images/4 korpus/4.3.png',
    4: 'lib/images/4 korpus/4.4.png',
  },
  'п': {
    1: 'lib/images/potoch korpus/p.1.png',
    2: 'lib/images/potoch korpus/p.2.png',
  },
};

class _MapScreenState extends State<MapScreen> {
  String selectedKorpus = '1';
  int selectedFloor = 1;

  Auditory? startPathAuditory;
  Auditory? endPathAuditory;

  void _initStartPathAuditory(Auditory aud) {
    setState(() {
      startPathAuditory = aud;
    });
  }

  void _initEndPathAuditory(Auditory aud) {
    setState(() {
      endPathAuditory = aud;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Карта'),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              InteractiveViewer(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Center(
                                child: Image.asset(mapFloors[selectedKorpus]
                                    [selectedFloor] as String)),
                          ),
                          Stack(
                            children: [
                              ShowBottomSheetExample(
                                auditory: Auditory(
                                  number: '3.401',
                                  type: '???',
                                  offset: const Offset(115, -13),
                                  width: 5,
                                  height: 12,
                                ),
                                AAudInit: _initStartPathAuditory,
                                BAudInit: _initEndPathAuditory,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedKorpus = '1';
                          selectedFloor = 0;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedKorpus == '1'
                            ? null
                            : Theme.of(context).canvasColor,
                        shape: const CircleBorder(),
                      ),
                      child: const Text('1к'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedKorpus = '2';
                          selectedFloor = 0;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedKorpus == '2'
                            ? null
                            : Theme.of(context).canvasColor,
                        shape: const CircleBorder(),
                      ),
                      child: const Text('2к'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedKorpus = '3';
                          selectedFloor = 0;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedKorpus == '3'
                            ? null
                            : Theme.of(context).canvasColor,
                        shape: const CircleBorder(),
                      ),
                      child: const Text('3к'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedKorpus = '4';
                          selectedFloor = 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedKorpus == '4'
                            ? null
                            : Theme.of(context).canvasColor,
                        shape: const CircleBorder(),
                      ),
                      child: const Text('4к'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedKorpus = 'п';
                          selectedFloor = 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedKorpus == 'п'
                            ? null
                            : Theme.of(context).canvasColor,
                        shape: const CircleBorder(),
                      ),
                      child: const Text('Пк'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class ShowBottomSheetExample extends StatefulWidget {
  const ShowBottomSheetExample(
      {required this.auditory,
      required this.AAudInit,
      required this.BAudInit,
      super.key});

  final Auditory auditory;

  final Function AAudInit;
  final Function BAudInit;

  @override
  State<ShowBottomSheetExample> createState() => _ShowBottomSheetExampleState();
}

class _ShowBottomSheetExampleState extends State<ShowBottomSheetExample> {
  @override
  Widget build(BuildContext context) => Center(
        child: Transform.translate(
          offset: widget.auditory.offset,
          child: SizedBox(
            width: widget.auditory.width,
            height: widget.auditory.height,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const LinearBorder(),
                backgroundColor: const Color.fromARGB(0, 233, 26, 26),
                shadowColor: const Color.fromARGB(0, 15, 15, 15),
                // fixedSize: size,
                // minimumSize: Size(1,1)
              ),
              onPressed: () {
                Scaffold.of(context).showBottomSheet<void>(
                  (BuildContext context) => Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 77, 77, 77)),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(25)),
                      ),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  widget.auditory.number,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                widget.auditory.type,
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                );
              },
              child: const Text(''),
            ),
          ),
        ),
      );
}

class Auditory {
  Auditory(
      {required this.offset,
      required this.width,
      required this.height,
      required this.number,
      required this.type});

  final String number;
  final String type;

  final Offset offset;
  final double width;
  final double height;
}
