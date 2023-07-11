import 'package:flutter/material.dart';

class Spravki extends StatefulWidget {
  const Spravki({super.key});

  @override
  State<Spravki> createState() => _SpravkiState();
}

class _SpravkiState extends State<Spravki> {
  int PFcount = 0;
  int GeneralCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заказать справку'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Text(
              'Заявки принимаются с понедельника по среду, получить справку можно в пятницу после 15:00'),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Фамилия',
            ),
            onChanged: ((value) {}),
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Имя',
            ),
            onChanged: ((value) {}),
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Отчество (при наличии)',
            ),
            onChanged: ((value) {}),
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Группа',
            ),
            onChanged: ((value) {}),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text('Пенсионный фонд (ПФ)'),
              Expanded(child: Container()),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      if (PFcount < 5){
                        setState(() {
                          PFcount++;
                        });
                      }
                    },
                    icon: Icon(Icons.keyboard_arrow_up_outlined)),
                  Container(
                    child: Text(
                      PFcount.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (PFcount > 0){
                          setState(() {
                            PFcount--;
                          });
                        }
                      },
                      icon: Icon(Icons.keyboard_arrow_down_outlined)),
                ],
              )
            ],
          ),
          Row(
            children: [
              Text('Соц. службы/По месту требования (Общая)'),
              Expanded(child: Container()),
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        if (GeneralCount < 5){
                          setState(() {
                            GeneralCount++;
                          });
                        }
                      },
                      icon: Icon(Icons.keyboard_arrow_up_outlined)),
                  Container(
                    child: Text(
                      GeneralCount.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (GeneralCount > 0){
                          setState(() {
                            GeneralCount--;
                          });
                        }
                      },
                      icon: Icon(Icons.keyboard_arrow_down_outlined)),
                ],
              )
            ],
          ),
          Expanded(child: Container()),
          ElevatedButton(onPressed: () {}, child: Text('Отправить'))
        ]),
      ),
    );
  }
}
