import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:untitled1/screens/services_screen/bibly_auth_screen.dart';

class BiblyScreen extends StatefulWidget {
  BiblyScreen({required this.login, required this.pass, super.key});

  String login;
  String pass;

  @override
  State<BiblyScreen> createState() => _BiblyScreenState();
}

class _BiblyScreenState extends State<BiblyScreen> {
  String generateUrlEncodedString(Map<String, String> data) => data.entries
      .map((e) => '${e.key}=${Uri.encodeQueryComponent(e.value)}')
      .join('&');

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
    String pass,
  ) async {
    await getSessionCookie();
    await regReader(login, pass);
    final response = await getPage(
      Uri.parse('https://bek.sibadi.org/MegaPro/Web/Search/Simple'),
      login,
      pass,
    );
    parseCookies(response);
    final document = parse(response.body, encoding: 'utf-8');
    final table = document.getElementsByClassName('cab_name');
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
    final document = parse(response.body, encoding: 'utf-8');
    final table = document.getElementsByTagName("tr");
    for (int i = 1; i < table.length; i++) {
      final book = Book(
        index: table[i].nodes[1].text!,
        code: table[i].nodes[3].text!,
        name: table[i].nodes[5].text!,
        pc: table[i].nodes[7].text!,
        start: DateFormat('dd.mm.yyyy').parse(table[i].nodes[9].text!),
        end: DateFormat('dd.mm.yyyy').parse(table[i].nodes[11].text!),
      );
      books.add(book);
    }
    return response;
  }

  List<Book> books = [];

//https://bek.sibadi.org/MegaPro/Web/BookList/Hand

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Библиотека")),
        body: FutureBuilder(
          future: biblyAuthorization(
            widget.login,
            widget.pass,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return FutureBuilder(
                future: handBooks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    bool hasDolg = false;
                    for (var i = 0; i < books.length; i++) {
                      if (DateTime.now().isBefore(books[i].end)) {
                        hasDolg = true;
                      }
                    }

                    return Center(
                      child: Container(
                        //padding: EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            if (hasDolg)
                              Card(
                                color: Colors.amber,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),),
                                child: const Center(
                                  child: Text(
                                    "\nУ тебя есть должок!\n",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            else
                              const SizedBox(),
                            Expanded(
                              child: ListView.builder(
                                itemCount: books.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        BookCard(book: books[index]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    const Text(
                      "Не удалось войти",
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const BibliyAuthScreen(),
                          ),
                        );
                      },
                      child: const Text("Вернуться к авторизации"),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      );
}

class BookCard extends StatefulWidget {
  const BookCard({required this.book, super.key});
  final Book book;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          setState(() {
            isOpen = !isOpen;
          });
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: DateTime.now().isBefore(widget.book.end)
              ? Theme.of(context).cardColor
              : const Color.fromARGB(255, 138, 19, 11),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Text(isOpen
                    ? widget.book.name
                    : "${widget.book.name.substring(0, 100)}...",),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text("Дата выдачи"),
                          Text(DateFormat('dd.mm.yyyy')
                              .format(widget.book.start),),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Дата возврата"),
                          Text(
                              DateFormat('dd.mm.yyyy').format(widget.book.end),),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class Book {
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
