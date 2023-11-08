import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:untitled1/screens/services_screen/bibly_auth_screen.dart';


class BiblyScreen extends StatefulWidget {
  BiblyScreen({super.key, required this.login, required this.pass});

  String login;
  String pass;

  @override
  State<BiblyScreen> createState() => _BiblyScreenState();
}

class _BiblyScreenState extends State<BiblyScreen> {

  String generateUrlEncodedString(Map<String, String> data) {
  return data.entries
      .map((e) => '${e.key}=${Uri.encodeQueryComponent(e.value)}')
      .join('&');
  }

  final cookies = <String, String>{};
  final httpClient = http.Client();
  final cookieRegExp = RegExp(r'^([^=]+)=([^;]+)');


  void parseCookies(http.Response response) {
    final cookiesSet = response.headers['set-cookie'];
    if (cookiesSet != null) {
      final result = cookieRegExp.matchAsPrefix(cookiesSet);
      if (result != null) {
        final name = result[1]!;
        final value = result[2]!;
        cookies[name] = value;
      }
    }
  }

  /// Получаем куки сессии.
  Future<void> getSessionCookie() async {
    final response = await httpClient.get(
      Uri.parse('https://bek.sibadi.org/MegaPro/Web'),
    );
    parseCookies(response);
  }

  /// Регистрируем вход читателя.
  Future<http.Response> regReader(String name, String id) async {
    final response = await httpClient.post(
      Uri.parse('https://bek.sibadi.org/MegaPro/Web/Home/RegRdr'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        if (cookies.isNotEmpty) 'Cookie': generateUrlEncodedString(cookies),
        'Origin': 'https://bek.sibadi.org',
        'Referer': 'https://bek.sibadi.org/MegaPro/Web',
      },
      body: generateUrlEncodedString({'name': name, 'id': id}),
    );
    parseCookies(response);
    return response;
  }

  /// Получаем страницу с читательским билетом.
  Future<http.Response> getPage(Uri uri, String name, String id) async {
    final response = await httpClient.post(
      uri,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        if (cookies.isNotEmpty) 'Cookie': generateUrlEncodedString(cookies),
        'Origin': 'https://bek.sibadi.org',
        'Referer': 'https://bek.sibadi.org/MegaPro/Web',
      },
      body: generateUrlEncodedString({'rdr_name': name, 'rdr_id': id}),
    );
    parseCookies(response);
    return response;
  }

  Future<bool> biblyAuthorization(
    String login, 
    String pass) async {
      await getSessionCookie();
      await regReader(login, pass);
      final response = await getPage(
        Uri.parse('https://bek.sibadi.org/MegaPro/Web/Search/Simple'),
        login,
        pass,
      );
      parseCookies(response);
      var document = parse(response.body, encoding:'utf-8');
      var table = document.getElementsByClassName('cab_name');
      return table.isNotEmpty;
  }


  Future<http.Response> handBooks() async {
    final response = await httpClient.get(
      Uri.parse("https://bek.sibadi.org/MegaPro/Web/BookList/Hand"),
      headers: {
        'Content-Type': 'text/html; charset=utf-8',
        if (cookies.isNotEmpty) 'Cookie': generateUrlEncodedString(cookies),
        'Origin': 'https://bek.sibadi.org',
        'Referer': 'https://bek.sibadi.org/MegaPro/Web',
      },
    );
    parseCookies(response);
    print(response.body);
    var document = parse(response.body, encoding:'utf-8');
    //var table = document.getElementsByClassName('cab_name');
    var table = document.getElementsByTagName("tr");
    for (int i = 1; i < table.length; i++){
      var book = Book(
        index: table[i].nodes[1].text!, 
        code: table[i].nodes[3].text!, 
        name: table[i].nodes[5].text!, 
        pc: table[i].nodes[7].text!, 
        start: DateFormat('dd.mm.yyyy').parse(table[i].nodes[9].text!), 
        end: DateFormat('dd.mm.yyyy').parse(table[i].nodes[11].text!)
      );
      books.add(book);
    }
    return response;
  }

  List books = [];

  // void getBooksFromResponse(List table){
    
  // }

//https://bek.sibadi.org/MegaPro/Web/BookList/Hand

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text("Библиотека")),
      body: FutureBuilder(
      future: biblyAuthorization(
        widget.login,
        widget.pass,
      ),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (
          snapshot.connectionState == ConnectionState.done && 
          snapshot.data)
          {
          return FutureBuilder(
            future: handBooks(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting){
                return const Center(child:CircularProgressIndicator());
              }
              else{
                bool hasDolg = false;
                for (var i = 0; i < books.length; i++) {
                  if (DateTime.now().isBefore(books[i].end)){
                    hasDolg = true;
                  }
                }

                return Center(
                  child: Container(
                    //padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        hasDolg ? 
                        Card(
                          color: Colors.amber,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "\nУ тебя есть должок!\n",
                              style: TextStyle(
                                color: Colors.black
                              ),
                            )
                          )
                        )
                        : SizedBox() ,
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: books.length,
                              itemBuilder: (BuildContext context, int index){
                                return BookCard(book: books[index]);
                              }
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            }
          );
          
        }
        else {
          return Center(
            child: Column(
              children: [
                Text(
                  "Не удалось войти",
                ),
                ElevatedButton(onPressed: (){
                  Navigator.push(
                    context, 
                    new MaterialPageRoute(builder: (BuildContext context) => 
                      BibliyAuthScreen()
                    )
                  );
                }, child: Text("Вернуться к авторизации"))
              ],
            ),
          );
        }
      }
      )
    );
  }

}

class BookCard extends StatefulWidget {
  const BookCard({super.key, required this.book});
  final Book book;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {

   bool isOpen = false;

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        setState(() {
          isOpen = !isOpen;
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: DateTime.now().isBefore(widget.book.end) ? Theme.of(context).cardColor : const Color.fromARGB(255, 138, 19, 11),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Text(isOpen ? widget.book.name : widget.book.name.substring(0, 100) + "..."),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Дата выдачи"),
                        Text(DateFormat('dd.mm.yyyy').format(widget.book.start)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Дата возврата"),
                        Text(DateFormat('dd.mm.yyyy').format(widget.book.end)),
                      ],
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Book{
  Book({
    required this.index, 
    required this.code, 
    required this.name, 
    required this.pc, 
    required this.start, 
    required this.end, 
  });

  String index;
  String code;
  String name;
  String pc;
  DateTime start;
  DateTime end;

}