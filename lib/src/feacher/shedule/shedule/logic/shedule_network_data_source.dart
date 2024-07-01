
import 'package:http/http.dart' as http;
import 'package:untitled1/logic/ConnetionCheck.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/src/feacher/shedule/shedule/model/lesson.dart';
import 'package:untitled1/src/feacher/shedule/shedule/widget/screen/shedule_screen.dart';

abstract class SheduleNetworkDataSource{

}

class SheduleNetworkDataSourceImpl extends SheduleNetworkDataSource{
  
  Future<Map<DateTime, List<Lesson>>> getData() async {

    String? raspisjson = '';

    isConnected = await CheckConnection();
    raspisjson = await getRaspisanie();
    // if (isConnected) {
    //   final Uri uri = Uri.parse(
    //     urls[selectedRaspis.tabIndex] + selectedRaspis.id.toString(),
    //   );
    //   final response = await http.Client().get(uri);
    //   if (response.statusCode == 200) {
    //     raspisjson = response.body;
    //     await setRaspisanie(response.body, DateTime.now());
    //     getSheduleFromJson(raspisjson);
    //   } else {
    //     getSheduleFromJson(raspisjson!);
    //   }
    // }
    return raspPerDate;
  }

  Map<DateTime, List<Lesson>> getSheduleFromJson(String json){
    // final jsonmap = jsonDecode(json);
    //     final rasplist = jsonmap['data']['rasp'] as List;
    //     for (int i = 0; i < rasplist.length; i++) {
    //       raspisanie.add(Lesson.fromJson(rasplist[i] as Map<String, dynamic>));
    //     }
    //     final firstIndexForRasp = raspisanie.indexOf(
    //       raspisanie.firstWhere(
    //         (element) => DateTime.parse(element.date).isAfter(threeMonthAgo),
    //       ),
    //     );
    //     for (int j = firstIndexForRasp; j < raspisanie.length; j++) {
    //       raspPerDate[DateTime.parse(raspisanie[j].date)] = raspisanie
    //           .where((element) => element.date == raspisanie[j].date)
    //           .toList();
    //     }
        return raspPerDate;
  }

}