

import 'package:http/http.dart' as http;
import 'dart:convert';



List<BaseList> ListInRaspisanie = [];

String turl = '';
String tsearchWor = '';
int ttabindex = 0;


Future<List<BaseList>> getListInRaspisanie(String url, String searchWord, int tabIndex) async {
  if (url == turl && tsearchWor == searchWord && ListInRaspisanie.isNotEmpty)
    return ListInRaspisanie;
  ListInRaspisanie.clear();
  Uri uri = Uri.parse(url);
  final response =
  await http.Client().get(uri);
  if (response.statusCode == 200) {
    final jsonmap = jsonDecode(response.body);
    var rasplist = jsonmap['data'];
    for (int i = 0; i < rasplist.length; i++){
      if (BaseList.fromJson(rasplist[i]).name.toLowerCase().contains(searchWord.toLowerCase())){
        ListInRaspisanie.add(BaseList.fromJson(rasplist[i]));
        ListInRaspisanie.last.tabIndex = tabIndex;
      }
    }
    return ListInRaspisanie;
  }
  return ListInRaspisanie;
}


class BaseList{
   String name ='';
   int id = 0;
  late int tabIndex;

  BaseList({
    required this.name,
    required this.id,
    required this.tabIndex,
  });

  BaseList.fromJson(Map<String, dynamic> json){
    name = json['name'];
    id = json['id'];
    if (json['tabIndex'] != null) {
      tabIndex = json['tabIndex'];
    }
  }

 static Map<String, dynamic> toMap(BaseList base) => {
        'name': base.name,
        'id': base.id,
        'tabIndex': base.tabIndex,
  };

  static String encode(List<BaseList> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => BaseList.toMap(music))
            .toList(),
      );

  static List<BaseList> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<BaseList>((item) => BaseList.fromJson(item))
          .toList();
}