
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  //const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

Map mapFloors = {
  '1': {
    0: 'lib/images/1 korpus/1kc.png',
    1: 'lib/images/1 korpus/1k1.png',
    2: 'lib/images/1 korpus/1k2.png',
    3: 'lib/images/1 korpus/1k3.png',
    4: 'lib/images/1 korpus/1k4.png',
  },
  '2': {
    0: 'lib/images/2 korpus/2kc.png',
    1: 'lib/images/2 korpus/2k1.png',
    2: 'lib/images/2 korpus/2k2.png',
    3: 'lib/images/2 korpus/2k3.png',
    4: 'lib/images/2 korpus/2k4.png',
  },
  '3': {
    0: 'lib/images/3 korpus/3kc.png',
    1: 'lib/images/3 korpus/3k1.png',
    2: 'lib/images/3 korpus/3k2.png',
    3: 'lib/images/3 korpus/3k3.png',
    4: 'lib/images/3 korpus/3k4.png',
    5: 'lib/images/3 korpus/3k5.png',
  },
  '4': {
    0: 'lib/images/4 korpus/4kc.png',
    1: 'lib/images/4 korpus/4k1.png',
    2: 'lib/images/4 korpus/4k2.png',
    3: 'lib/images/4 korpus/4k3.png',
    4: 'lib/images/4 korpus/4k4.png',
  },
  'п': {
    1: 'lib/images/potoch korpus/pk1.png',
    2: 'lib/images/potoch korpus/pk2.png',
  },
};

Map<String, Map<int, List<Auditory>>> mapAudit = {
  '1': {
    0: [Auditory(number: '3.212', type: '???', offset: Offset(180, 286), height: 34, width: 22,),],
    1: [Auditory(number: '3.212', type: '???', offset: Offset(180, 286), height: 34, width: 22,),],
  },
  '2':  {
    0: [],
    1: [],
    2: [],
    3: [],
    4: [],
  },
  '3':  {
    0: [],
    1: [],
    2: [
      Auditory(number: '3.211', type: '???', offset: Offset(-166, 3), width: 20, height: 14,),
      Auditory(number: '3.210', type: '???', offset: Offset(-151, 20), width: 28, height: 19,),
      Auditory(number: '3.212', type: '???', offset: Offset(-151, -15), width: 49, height: 20,),
      Auditory(number: '3.213', type: '???', offset: Offset(-119, -15), width: 13, height: 20,),
      Auditory(number: '3.209', type: '???', offset: Offset(-118, 20), width: 34, height: 19,),
      Auditory(number: '3.214', type: '???', offset: Offset(-105, -15), width: 13, height: 20,),
      Auditory(number: '3.208a', type: '???', offset: Offset(-94, 20), width: 12, height: 19,),
      Auditory(number: '3.208', type: '???', offset: Offset(-69, 20), width: 12, height: 19,),
      Auditory(number: '3.215', type: '???', offset: Offset(-57, -15), width: 31, height: 20,),
      Auditory(number: '3.207', type: '???', offset: Offset(-36, 20), width: 12, height: 19,),
      Auditory(number: '3.216', type: '???', offset: Offset(-35, -15), width: 12, height: 20,),
      Auditory(number: '3.206', type: '???', offset: Offset(-13, 20), width: 30, height: 19,),
      Auditory(number: '3.217', type: '???', offset: Offset(-23, -15), width: 12, height: 20,),
      Auditory(number: '3.205', type: '???', offset: Offset(19, 20),  width: 32, height: 19,),
      Auditory(number: '3.218', type: '???', offset: Offset(12, -15), width: 57, height: 20,),
      Auditory(number: '3.204', type: '???', offset: Offset(42, 20),  width: 10, height: 19,),
      Auditory(number: '3.219', type: '???', offset: Offset(63, -15), width: 48, height: 20,),
      Auditory(number: '3.203', type: '???', offset: Offset(53, 20),  width: 10, height: 19,),
      Auditory(number: '3.202', type: '???', offset: Offset(73, 20),  width: 26, height: 19,),
      Auditory(number: '3.220', type: '???', offset: Offset(99, 20),        width: 23, height: 19,),
      Auditory(number: 'Туалет', type: 'Мужской', offset: Offset(116, -15), width: 9, height: 20, ),
      Auditory(number: 'Туалет', type: 'Женский', offset: Offset(125, -15), width: 9, height: 20, ),
      Auditory(number: '3.200', type: '???', offset: Offset(128, 20),      width: 33, height: 19,),
      Auditory(number: '3.222', type: '???', offset: Offset(147, -15),     width: 32, height: 20,),
      Auditory(number: '3.201', type: '???', offset: Offset(155, 20),      width: 18, height: 19,),
    ],
    3: [
      Auditory(number: '3.312', type: '???',  offset: Offset(-172, 18), width: 10, height: 19,),
      Auditory(number: '3.312a', type: '???', offset: Offset(-163, -17), width: 27, height: 19,),
      Auditory(number: '3.311', type: '???', offset: Offset(-140, 18),   width: 50, height: 20,),
      Auditory(number: '3.313', type: '???', offset: Offset(-119, -17),  width: 13, height: 19,),
      Auditory(number: '3.310б', type: '???', offset: Offset(-107, 18),  width: 12, height: 19,),
      Auditory(number: '3.314', type: '???', offset: Offset(-105, -17),  width: 13, height: 19,),
      Auditory(number: '3.310a', type: '???', offset: Offset(-87, 18),   width: 23, height: 19,),
      Auditory(number: '3.310', type: '???', offset: Offset(-58, 18), width: 31, height: 19,),
      Auditory(number: '3.315', type: '???', offset: Offset(-50, -17),width: 42, height: 19,),
      Auditory(number: '3.309', type: '???', offset: Offset(-23, 18), width: 10, height: 19,),
      Auditory(number: '3.316', type: '???', offset: Offset(-5, -17), width: 45, height: 20,),
      Auditory(number: '3.308', type: '???', offset: Offset(-13, 18), width: 10, height: 19,),
      Auditory(number: '3.307', type: '???', offset: Offset(14, 18),  width: 42, height: 20,),
      Auditory(number: '3.318a', type: '???', offset: Offset(35, -17),width: 12, height: 19,),
      Auditory(number: '3.306', type: '???', offset: Offset(43, 18),  width: 10, height: 20,),
      Auditory(number: '3.319', type: '???', offset: Offset(64, -17), width: 45, height: 19,),
      Auditory(number: '3.305', type: '???', offset: Offset(63, 18),  width: 27, height: 20,),
      Auditory(number: '3.304a', type: '???', offset: Offset(83, 18),     width: 10, height: 19,),
      Auditory(number: 'Туалет', type: 'Мужской', offset: Offset(116, -17),  width: 9, height: 20, ),
      Auditory(number: 'Туалет', type: 'Женский', offset: Offset(126, -17),  width: 9, height: 20, ),
      Auditory(number: '3.303', type: '???', offset: Offset(140, 18),    width: 31, height: 19,),
      Auditory(number: '3.322', type: '???', offset: Offset(147, -17), width: 32, height: 20,),
      Auditory(number: '3.301a', type: '???', offset: Offset(166, 0), width: 20, height: 13,),
    ],
    4: [],
    5: [],
  },
  // '4':  {
  //   0: [],
  //   1: [],
  //   2: [],
  //   3: [],
  //   4: [],
  // },
  'п':  {
    1: [],
    2: [],
  },
};


class _MapScreenState extends State<MapScreen> {

  String selectedKorpus = '1';
  int selectedFloor = 1;

  Auditory? startPathAuditory;
  Auditory? endPathAuditory;

  void _initStartPathAuditory(Auditory aud){
    setState(() {
      startPathAuditory = aud;
    });
  }

  void _initEndPathAuditory(Auditory aud){
    setState(() {
      endPathAuditory = aud;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Карта')
      ),
      body: Stack(
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
                        child: Center(child: Image.asset(mapFloors[selectedKorpus][selectedFloor])),
                      ),
                      Stack(
                        children: 
                        List.generate(
                          mapAudit[selectedKorpus]![selectedFloor]!.toList().length, 
                          (index) => 
                          ShowBottomSheetExample(auditory: mapAudit[selectedKorpus]![selectedFloor]![index], AAudInit: _initStartPathAuditory, BAudInit: _initEndPathAuditory,)
                        ), 
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      selectedKorpus = '1';
                    });
                  }, 
                  child: Text('1к'), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedKorpus == '1' ? null : Theme.of(context).canvasColor,
                    shape: CircleBorder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      selectedKorpus = '2';
                    });
                  }, 
                  child: Text('2к'), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedKorpus == '2' ? null : Theme.of(context).canvasColor,
                    shape: CircleBorder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      selectedKorpus = '3';
                    });
                  }, 
                  child: Text('3к'), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedKorpus == '3' ? null : Theme.of(context).canvasColor,
                    shape: CircleBorder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      selectedKorpus = 'п';
                    });
                  }, 
                  child: Text('Пк'), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedKorpus == 'п' ? null : Theme.of(context).canvasColor,
                    shape: CircleBorder(),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: (){
                //     setState(() {
                //       selectedKorpus = 4;
                //     });
                //   }, 
                //   child: Text('4к'), 
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: selectedKorpus == 4 ? null : Theme.of(context).canvasColor,
                //     shape: CircleBorder(),
                //   ),
                // ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column( 
            children: List.generate(mapAudit[selectedKorpus]!.keys.length, (index) => 
              ElevatedButton(
                  onPressed: (){
                    setState(() {
                      selectedFloor = index;
                    });
                  }, 
                  child: Text('$index'), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedFloor == index ? null : Theme.of(context).canvasColor,
                    shape: CircleBorder(),
                  ),
                ),
                )
            ),
          )
        ],
      ),
    );
  }
}

class ShowBottomSheetExample extends StatefulWidget {
  const ShowBottomSheetExample({super.key, required this.auditory, required this.AAudInit, required this.BAudInit});

  final Auditory auditory;

  final Function AAudInit;
  final Function BAudInit;

  @override
  State<ShowBottomSheetExample> createState() => _ShowBottomSheetExampleState();
}

class _ShowBottomSheetExampleState extends State<ShowBottomSheetExample> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
      offset: widget.auditory.offset,
      child: 
        SizedBox(
          width: widget.auditory.width,
          height: widget.auditory.height,
          child: ElevatedButton(
            child: const Text(''),
            style: ElevatedButton.styleFrom(
              shape: LinearBorder(),
              backgroundColor: Color.fromARGB(130, 233, 26, 26),
              shadowColor: Color.fromARGB(0, 15, 15, 15),
              // fixedSize: size,
              // minimumSize: Size(1,1)
            ),
            onPressed: () {
              Scaffold.of(context).showBottomSheet<void>(
                (BuildContext context) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromARGB(255, 77, 77, 77)),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(25))
                    ),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(widget.auditory.number, style: TextStyle(fontSize: 20),),
                            ),
                            Expanded(child: Container(),), 
                            IconButton(
                              onPressed: (){ Navigator.pop(context); }, 
                              icon: Icon(Icons.close)
                            ) 
                          ]
                        ),
                        Align(alignment: Alignment.centerLeft, child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(widget.auditory.type,),
                        )),
                        Expanded(child: Container()),
                        SizedBox(height: 20,)
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class Auditory{

  Auditory({required this.offset, required this.width, required this.height, required this.number, required this.type});

  final String number;
  final String type;

  final Offset offset;
  final double width;
  final double height;
}