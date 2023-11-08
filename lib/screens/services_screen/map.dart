
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  //const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

Map mapFloors = {
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

Map<String, Map<int, List<Auditory>>> mapAudit = {
  '1': {
    0: [
      Auditory(number: '1.001', type: '???', offset: Offset(-52, 53), width: 13, height: 23,),
      Auditory(number: '1.002', type: '???', offset: Offset(-68, 53), width: 15, height: 23,),
      Auditory(number: '1.003', type: '???', offset: Offset(-91, 53), width: 29, height: 23,),
      Auditory(number: '1.004', type: '???', offset: Offset(-114, 53), width: 13, height: 23,),
      Auditory(number: '1.005', type: '???', offset: Offset(-149, 60), width: 55, height: 41,),
      Auditory(number: '1.006', type: '???', offset: Offset(-164, 31), width: 25, height: 13,),
      Auditory(number: '1.007', type: '???', offset: Offset(-164, 16), width: 25, height: 13,),
      Auditory(number: '1.008', type: '???', offset: Offset(-164, -6), width: 25, height: 27,),
      Auditory(number: '1.009', type: '???', offset: Offset(-164, -31), width: 25, height: 22,),
      Auditory(number: '1.010', type: '???', offset: Offset(-164, -73), width: 25, height: 29,),
      Auditory(number: '1.011', type: '???', offset: Offset(-164, -95), width: 25, height: 13,),
      Auditory(number: '1.012', type: '???', offset: Offset(-164, -110), width: 25, height: 13,),
      Auditory(number: '1.013', type: '???', offset: Offset(-123, -74), width: 25, height: 25,),
      Auditory(number: '1.014', type: '???', offset: Offset(-123, -54), width: 25, height: 13,),
      Auditory(number: '1.015', type: '???', offset: Offset(-123, -34), width: 25, height: 25,),
      Auditory(number: '1.016', type: '???', offset: Offset(-123, -6), width: 25, height: 28,),
      Auditory(number: '1.017', type: '???', offset: Offset(-82, 13), width: 14, height: 20,),
      Auditory(number: '1.018', type: '???', offset: Offset(-67, 13), width: 14, height: 20,),
      Auditory(number: '1.019', type: 'Гардероб', offset: Offset(8, 13), width: 71, height: 20,),
      Auditory(number: '1.021', type: '???', offset: Offset(116, -8), width: 28, height: 31,),
      Auditory(number: '1.022', type: '???', offset: Offset(116, -33), width: 28, height: 18,),
      Auditory(number: '1.023', type: '???', offset: Offset(116, -72), width: 28, height: 57,),
      Auditory(number: '1.023a', type: '???', offset: Offset(154, -100), width: 45, height: 30,),
      Auditory(number: '1.023б', type: '???', offset: Offset(161, -75), width: 30, height: 17,),
      Auditory(number: '1.023в', type: '???', offset: Offset(161, -44), width: 30, height: 42,),
      Auditory(number: '1.024', type: '???', offset: Offset(161, -1), width: 30, height: 15,),
      Auditory(number: '1.025', type: '???', offset: Offset(161, 15), width: 30, height: 15,),
      Auditory(number: '1.026', type: '???', offset: Offset(165, 29), width: 24, height: 10,),
      Auditory(number: '1.027', type: '???', offset: Offset(143, 57), width: 67, height: 45,),
      Auditory(number: '1.028', type: '???', offset: Offset(101, 51), width: 15, height: 25,),
      Auditory(number: '1.029', type: '???', offset: Offset(69, 51), width: 48, height: 25,),
      Auditory(number: '1.031', type: 'Буфет', offset: Offset(31, 51), width: 25, height: 25,),
    ],
    1: [
      Auditory(number: '1.101', type: '???', offset: Offset(-56, 48), width: 13, height: 22,),
      Auditory(number: '1.102', type: '???', offset: Offset(-68, 48), width: 10, height: 22,),
      Auditory(number: '1.103', type: '???', offset: Offset(-80, 48), width: 10, height: 22,),
      Auditory(number: '1.104', type: '???', offset: Offset(-92, 48), width: 12, height: 22,),
      Auditory(number: '1.105', type: '???', offset: Offset(-113, 55), width: 27, height: 39,),
      Auditory(number: '1.106', type: 'Приемная ректора', offset: Offset(-138, 22), width: 24, height: 27,),
      Auditory(number: '1.107', type: '???', offset: Offset(-138, -11), width: 24, height: 14,),
      Auditory(number: '1.107', type: '???', offset: Offset(-138, -46), width: 24, height: 13,),
      Auditory(number: '1.109', type: '???', offset: Offset(-138, -75), width: 24, height: 12,),
      Auditory(number: '1.110', type: '???', offset: Offset(-138, -88), width: 24, height: 12,),
      Auditory(number: '1.111', type: '???', offset: Offset(-101, -88), width: 24, height: 12,),
      Auditory(number: '1.112', type: '???', offset: Offset(-101, -75), width: 24, height: 12,),
      Auditory(number: '1.113', type: '???', offset: Offset(-101, -62), width: 24, height: 12,),
      Auditory(number: '1.114', type: '???', offset: Offset(-101, -50), width: 24, height: 12,),
      Auditory(number: '1.115', type: '???', offset: Offset(-101, -38), width: 24, height: 10,),
      Auditory(number: '1.116', type: '???', offset: Offset(-101, -12), width: 24, height: 40,),
      Auditory(number: '1.117', type: '???', offset: Offset(-67, 12), width: 11, height: 19,),
      Auditory(number: '1.118', type: '???', offset: Offset(-56, 12), width: 10, height: 19,),
      Auditory(number: '1.119', type: '???', offset: Offset(-45, 12), width: 10, height: 19,),
      Auditory(number: '1.120', type: '???', offset: Offset(-35, 12), width: 9, height: 19,),
      Auditory(number: '1.121', type: '???', offset: Offset(-22, 12), width: 16, height: 19,),
      Auditory(number: '1.122', type: '???', offset: Offset(-3, 12), width: 19, height: 19,),
      Auditory(number: '1.123б', type: '???', offset: Offset(13, 12), width: 12, height: 19,),
      Auditory(number: '1.123', type: '???', offset: Offset(28, 12), width: 18, height: 19,),
      Auditory(number: '1.123a', type: '???', offset: Offset(45, 12), width: 15, height: 19,),
      Auditory(number: '1.124', type: '???', offset: Offset(60, 12), width: 14, height: 19,),
      Auditory(number: '1.125', type: '???', offset: Offset(75, 12), width: 16, height: 19,),
      Auditory(number: '1.126', type: '???', offset: Offset(119, -4), width: 26, height: 13,),
      Auditory(number: '1.127', type: '???', offset: Offset(119, -16), width: 26, height: 10,),
      Auditory(number: '1.128', type: '???', offset: Offset(119, -29), width: 26, height: 13,),
      Auditory(number: '1.129', type: '???', offset: Offset(119, -43), width: 26, height: 13,),
      Auditory(number: '1.130', type: '???', offset: Offset(119, -56), width: 26, height: 11,),
      Auditory(number: '1.131', type: '???', offset: Offset(121, -66), width: 22, height: 9,),
      Auditory(number: '1.132', type: '???', offset: Offset(119, -78), width: 26, height: 15,),
      Auditory(number: '1.133', type: '???', offset: Offset(119, -91), width: 26, height: 11,),
      Auditory(number: '1.134', type: '???', offset: Offset(160, -89), width: 28, height: 13,),
      Auditory(number: '1.135', type: '???', offset: Offset(160, -70), width: 28, height: 23,),
      Auditory(number: '1.136', type: '???', offset: Offset(160, -51), width: 28, height: 13,),
      Auditory(number: '1.137', type: '???', offset: Offset(160, -33), width: 28, height: 22,),
      Auditory(number: '1.138', type: '???', offset: Offset(160, -15), width: 28, height: 13,),
      Auditory(number: '1.139', type: '???', offset: Offset(151, 11), width: 10, height: 15,),
      Auditory(number: '1.140', type: '???', offset: Offset(165, 11), width: 18, height: 15,),
      Auditory(number: '1.141', type: '???', offset: Offset(144, 53), width: 60, height: 42,),
      Auditory(number: '1.142', type: '???', offset: Offset(106, 48), width: 15, height: 21,),
      Auditory(number: '1.143', type: '???', offset: Offset(76, 48), width: 45, height: 21,),
      ],
    2: [
      Auditory(number: '1.201', type: 'Спортивный зал', offset: Offset(139, -34), width: 75, height: 108,),
      Auditory(number: '1.202', type: '???', offset: Offset(161, 37), width: 30, height: 32,),
      Auditory(number: '1.203а', type: '???', offset: Offset(162, 75), width: 28, height: 42,),
      Auditory(number: '1.203', type: '???', offset: Offset(129, 75), width: 38, height: 42,),
      Auditory(number: '1.204', type: '???', offset: Offset(102, 69), width: 13, height: 23,),
      Auditory(number: '1.205', type: '???', offset: Offset(69, 69), width: 50, height: 23,),
      Auditory(number: '1.206', type: '???', offset: Offset(36, 69), width: 14, height: 23,),
      Auditory(number: '1.207', type: '???', offset: Offset(20, 69), width: 14, height: 23,),
      Auditory(number: '1.208', type: '???', offset: Offset(5, 69), width: 14, height: 23,),
      Auditory(number: '1.209', type: '???', offset: Offset(-18, 69), width: 28, height: 23,),
      Auditory(number: '1.210', type: '???', offset: Offset(-48, 69), width: 28, height: 23,),
      Auditory(number: '1.211', type: '???', offset: Offset(-70, 69), width: 15, height: 23,),
      Auditory(number: '1.212', type: '???', offset: Offset(-93, 69), width: 27, height: 23,),
      Auditory(number: '1.213', type: '???', offset: Offset(-114, 69), width: 15, height: 23,),
      Auditory(number: '1.214', type: '???', offset: Offset(-150, 77), width: 55, height: 43,),
      Auditory(number: '1.215', type: '???', offset: Offset(-150, 40), width: 55, height: 30,),
      Auditory(number: '1.216', type: 'Туалет Женский', offset: Offset(-86, 30), width: 11, height: 20,),
      Auditory(number: '1.217', type: '???', offset: Offset(-72, 30), width: 15, height: 20,),
      Auditory(number: '1.218', type: '???', offset: Offset(-57, 30), width: 12, height: 20,),
      Auditory(number: '1.219', type: '???', offset: Offset(-44, 30), width: 12, height: 20,),
      Auditory(number: '1.220', type: '???', offset: Offset(-23, 30), width: 25, height: 20,),
      Auditory(number: '1.221', type: '???', offset: Offset(-1, 30), width: 17, height: 20,),
      Auditory(number: '1.222', type: '???', offset: Offset(16, 30), width: 17, height: 20,),
      Auditory(number: '1.223', type: '???', offset: Offset(34, 30), width: 17, height: 20,),
      Auditory(number: '1.224', type: '???', offset: Offset(52, 30), width: 17, height: 20,),
      Auditory(number: '1.225', type: '???', offset: Offset(69, 30), width: 17, height: 20,),
      Auditory(number: 'Актовый зал', type: 'Актовый зал', offset: Offset(-144, -30), width: 65, height: 110,),
    ],
    3: [
      Auditory(number: '1.301', type: '???', offset: Offset(116, 29), width: 12, height: 18,),
      Auditory(number: '1.302', type: '???', offset: Offset(134, 29), width: 22, height: 18,),
      Auditory(number: '1.303', type: '???', offset: Offset(162, 67), width: 28, height: 62,),
      Auditory(number: '1.304', type: '???', offset: Offset(129, 75), width: 38, height: 42,),
      Auditory(number: '1.305', type: '???', offset: Offset(102, 69), width: 13, height: 23,),
      Auditory(number: '1.306', type: '???', offset: Offset(69, 69), width: 50, height: 23,),
      Auditory(number: '1.307', type: '???', offset: Offset(25, 69), width: 35, height: 23,),
      Auditory(number: '1.308', type: '???', offset: Offset(-6, 69), width: 26, height: 23,),
      Auditory(number: '1.309', type: '???', offset: Offset(-34, 69), width: 29, height: 23,),
      Auditory(number: '1.310', type: '???', offset: Offset(-56, 69), width: 15, height: 23,),
      Auditory(number: '1.311', type: '???', offset: Offset(-85, 69), width: 42, height: 23,),
      Auditory(number: '1.312', type: '???', offset: Offset(-113, 69), width: 15, height: 23,),
      Auditory(number: '1.313а', type: '???', offset: Offset(-137, 77), width: 30, height: 42,),
      Auditory(number: '1.313б', type: '???', offset: Offset(-165, 77), width: 25, height: 42,),
      Auditory(number: '1.313', type: '???', offset: Offset(-159, 41), width: 34, height: 29,),
      Auditory(number: '1.314', type: '???', offset: Offset(-132, 33), width: 20, height: 14,),
      Auditory(number: '1.315', type: 'Туалет Женский', offset: Offset(-86, 30), width: 12, height: 20,),
      Auditory(number: '1.316', type: '???', offset: Offset(-72, 30), width: 15, height: 20,),
      Auditory(number: '1.317', type: '???', offset: Offset(-50, 30), width: 25, height: 20,),
      Auditory(number: '1.318', type: '???', offset: Offset(-23, 30), width: 25, height: 20,),
      Auditory(number: '1.319', type: '???', offset: Offset(8, 30), width: 32, height: 20,),
      Auditory(number: '1.320', type: '???', offset: Offset(35, 30), width: 20, height: 20,),
      Auditory(number: '1.321', type: '???', offset: Offset(52, 30), width: 17, height: 20,),
      Auditory(number: '1.322', type: 'Туалет Мужской', offset: Offset(69, 30), width: 17, height: 20,),
    ],
    4: [
      Auditory(number: '1.401', type: '???', offset: Offset(-122, -18), width: 110, height: 60,),
      Auditory(number: '1.402', type: '???', offset: Offset(-55, -18), width: 23, height: 60,),
      Auditory(number: '1.403', type: '???', offset: Offset(12, -18), width: 108, height: 60,),
      Auditory(number: '1.404', type: '???', offset: Offset(78, -18), width: 23, height: 60,),
      Auditory(number: '1.405', type: '???', offset: Offset(133, -18), width: 85, height: 60,),
    ],
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
    1: [
      Auditory(number: '3.101', type: '???', offset: Offset(-52, 29), width: 46, height: 19,),
      Auditory(number: '3.102', type: '???', offset: Offset(-81, 29), width: 11, height: 19,),
      Auditory(number: '3.103', type: '???', offset: Offset(-93, 29), width: 11, height: 19,),
      Auditory(number: '3.104', type: '???', offset: Offset(-106, 29), width: 11, height: 19,),
      Auditory(number: '3.105', type: '???', offset: Offset(-140, 29), width: 28, height: 19,),
      Auditory(number: '3.106a', type: '???', offset: Offset(-160, 29), width: 10, height: 19,),
      Auditory(number: '3.106', type: '???', offset: Offset(-166, 12), width: 20, height: 15,),
      Auditory(number: '3.107', type: '???', offset: Offset(-138, -6), width: 23, height: 19,),
      Auditory(number: '3.108', type: 'Туалет Женский', offset: Offset(-119, -6), width: 14, height: 19,),
      Auditory(number: '3.109', type: 'Туалет Мужской', offset: Offset(-105, -6), width: 14, height: 19,),
      Auditory(number: '3.110', type: '???', offset: Offset(-61, -6), width: 22, height: 19,),
      Auditory(number: '3.111', type: '???', offset: Offset(-39, -6), width: 21, height: 19,),
      Auditory(number: '3.112', type: '???', offset: Offset(-11, -6), width: 32, height: 19,),
      Auditory(number: '3.115', type: '???', offset: Offset(46, -6), width: 10, height: 19,),
      Auditory(number: '3.116', type: '???', offset: Offset(65, -6), width: 27, height: 19,),
      Auditory(number: '3.117', type: '???', offset: Offset(117, -6), width: 9, height: 19,),
      Auditory(number: '3.118', type: '???', offset: Offset(127, -6), width: 9, height: 19,),
      Auditory(number: '3.119', type: '???', offset: Offset(148, -6), width: 31, height: 19,),
      Auditory(number: '3.120', type: '???', offset: Offset(170, -6), width: 12, height: 19,),
      Auditory(number: '3.121', type: '???', offset: Offset(162, 29), width: 30, height: 19,),
      Auditory(number: '3.122', type: '???', offset: Offset(135, 29), width: 25, height: 19,),
      Auditory(number: '3.123', type: '???', offset: Offset(106, 29), width: 12, height: 19,),
      Auditory(number: '3.124', type: '???', offset: Offset(94, 29), width: 10, height: 19,),
      Auditory(number: '3.125', type: '???', offset: Offset(84, 29), width: 10, height: 19,),
      Auditory(number: '3.126', type: '???', offset: Offset(64, 29), width: 30, height: 19,),
      Auditory(number: '3.127', type: 'Буфет', offset: Offset(39, 29), width: 19, height: 19,),
    ],
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
    4: [
      Auditory(number: '3.401', type: '???', offset: Offset(115, -13), width: 5, height: 12,),
      Auditory(number: '3.402', type: '???', offset: Offset(120, -13), width: 5, height: 12,),
      Auditory(number: '3.403', type: '???', offset: Offset(127, -17), width: 8, height: 20,),
      Auditory(number: '3.404', type: '???', offset: Offset(147, -17), width: 32, height: 20,),
      Auditory(number: '3.405', type: '???', offset: Offset(171, 18), width: 11, height: 20,),
      Auditory(number: '3.406', type: '???', offset: Offset(160, 18), width: 10, height: 20,),
      Auditory(number: '3.407', type: '???', offset: Offset(150, 18), width: 10, height: 20,),
      Auditory(number: '3.408', type: '???', offset: Offset(129, 18), width: 32, height: 20,),
      Auditory(number: '3.409', type: '???', offset: Offset(107, 18), width: 10, height: 20,),
      Auditory(number: '3.410', type: '???', offset: Offset(95, 18), width: 12, height: 20,),
      Auditory(number: '3.411', type: '???', offset: Offset(68, 18), width: 39, height: 20,),
    ],
    5: [],
  },
  '4':  {
    1: [],
    2: [],
    3: [],
    4: [],
  },
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
                          child: Center(child: Image.asset(mapFloors[selectedKorpus][selectedFloor])),
                        ),
                        Stack(
                          children: [
                            ShowBottomSheetExample(
                              auditory: Auditory(number: '3.401', type: '???', offset: Offset(115, -13), width: 5, height: 12,),
                              AAudInit: _initStartPathAuditory, 
                              BAudInit: _initEndPathAuditory,),
                              
                          ]
                          
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
                        selectedFloor = 0;
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
                        selectedFloor = 0;
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
                        selectedFloor = 0;
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
                        selectedKorpus = '4';
                        selectedFloor = 1;
                      });
                    }, 
                    child: Text('4к'), 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedKorpus == '4' ? null : Theme.of(context).canvasColor,
                      shape: CircleBorder(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        selectedKorpus = 'п';
                        selectedFloor = 1;
                      });
                    }, 
                    child: Text('Пк'), 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedKorpus == 'п' ? null : Theme.of(context).canvasColor,
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Column( 
              children: List.generate(mapFloors[selectedKorpus]!.keys.length, (index) => 
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        //selectedFloor = index;
                        selectedFloor = mapFloors[selectedKorpus]!.keys.elementAt(index);
                      });
                    }, 
                    //child: Text('$index'), 
                    child: Text('${mapFloors[selectedKorpus]!.keys.elementAt(index)}'), 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedFloor == mapFloors[selectedKorpus]!.keys.elementAt(index) ? null : Theme.of(context).canvasColor,
                      shape: CircleBorder(),
                    ),
                  ),
                  )
              ),
            )
          ],
        ),
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
              backgroundColor: Color.fromARGB(0, 233, 26, 26),
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