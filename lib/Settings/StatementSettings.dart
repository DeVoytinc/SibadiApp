import 'package:flutter/material.dart';

class StatementSettings extends StatefulWidget {
  const StatementSettings({super.key});

  @override
  State<StatementSettings> createState() => _StatementSettingsState();
}

bool isOtlichnik = false;

class _StatementSettingsState extends State<StatementSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройка ведомости'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: (){
                      showDialog(context: context, builder: (context) => new AlertDialog(
                        title: Text('Скрыть предметы'),
                        content: Text('Скрытие ненужных дисциплин увеличит скорость получения данных с сайта для личной ведомости. Советуем скрыть ненужные предметы физ-культуры.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(); // dismisses only the dialog and returns nothing
                            },
                            child: new Text('OK'),
                          ),
                        ],
                      )
                      );
                    }, 
                  ),
                  Text(
                    'Скрыть предметы из ведомости', 
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              )
            ),
          ),
          Divider(),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: (){
                          showDialog(context: context, builder: (context) => new AlertDialog(
                            title: Text('Стать отличником'),
                            content: Text('Вдруг вы хотите пошутить над друзьми или получить эстетическое наслаждение посмотрев на отличные оценки у себя в ведомости. \nТеперь не надо учиться ради хороших оценок.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(); // dismisses only the dialog and returns nothing
                                },
                                child: new Text('OK'),
                              ),
                            ],
                          )
                          );
                        }, 
                      ),
                      Text(
                        'Стать отличником', 
                        style: TextStyle(fontSize: 17),
                      ),
                      Expanded(child: Container()),
                      Switch.adaptive(value: isOtlichnik, onChanged: ((value) {
                        setState(() {
                          isOtlichnik = value;
                          
                        });
                      }),)
                      
                    ],
                  ),
                ),
                
              ],
            )
          ),
        ]
      ),
    );
  }
}