import 'package:flutter/material.dart';

class AboutMoneyScreen extends StatelessWidget {
  AboutMoneyScreen({super.key});

  final TextStyle h1 = TextStyle(
    fontSize: 25,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Стипендии"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('О стипендиях', style: h1,),
              ),
              Text('Виды стипендий:', style: TextStyle(fontSize: 18),),
              Text('1. Государственная академическая стипендия'),
              Text('2. Повышенная государственная академическая стипендия'),
              Text('3. государственная социальная стипендия и повышенная государственная' + 
              'социальная стипендия для нуждающихся студентов 1-2 курсов, успевающих на 4 и 5'),
              Text('4. стипендия Президента РФ и Правительства РФ'),
              Text('5. именные стипендии'),

              SizedBox(height: 10,),
              Text('Все цифры представленные далее взяты из приказа ' +
              ' "Об установлении размера стипендии и других ' +
              'форм материальной поддержки с 01.09.2022" который '+ 
              'расположен на официальном сайте СибАДИ '),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('Государственная академическая стипендия', style: h1,),
              ),
              Text('Государственная академическая стипендия - ' + 
              'это обычная выплата, которую получают за хорошую учебу в вузе.' + 
              'Чтобы ее получать, не нужно собирать никакие документы и участвовать' +
              'в конкурсах, достаточно быть студентом бюджетного отделения, учиться' +
              'на хорошо и отлично и сдавать все вовремя.'),
              Text(''),
              Text('Размер государственной академической стипендии составляет'),
              Text('2927,83 р.', style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),

              Text('При условии если вы являетесь студентом 1 курса и набрали ' +
              'по результатам ЕГЭ 250 баллов и более (180 баллов и более по ' +
              'программам "Архитектура") вам положена увеличенная на 60% стипендия -'),
              Text('4684,53 р.', style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),

              Text('Если же вы учитесь на "отлично" или студент первого курса и получили по ' +
              'баллам ЕГЭ 205-249 баллов (165-179 по программам "Архитектура") то ваша ' +
              'стипендия увеличена на 50% и составляет 4391,75 р.'),
              Text('4391,75 р.', style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),

              Text('Увеличенную на 25% стипендию получают студенты имещие более половины ' +
              'оценок "отлично", а также студенты первого курса набравшие по результатам ' +
              'ЕГЭ 180-204 балла (150-164 балла по программам "Архитектура")'),
              Text('3659.79 р.', style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),

              Text('Увеличенную на 15-20% стипендию получают студенты обучающиеся на "хорошо"'),
              Text('3367.00 - 3513.40 р.', style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('Государственная социальная стипендия (социалка)', style: h1,),
              ),
              Text('Для получения этой стипендии необходимо обратиться в многофункциональный' +
              'центр (МФЦ) либо в "Любава" и принести туда все необходимые документы.' +
              'Если вам положена социальная стипендия, то вам дадут документ который необходимо ' +
              'отнести в деканат и там заполнить заявление. \nНа самом деле получить социальную' +
              'стипендию проще чем кажется, и рекомендую это дело не откладывать после поступления.' +
              'А получить социальную стипендию вы можете почти со 100% вероятностью если проживаете' +
              'в общежитии или отдельно от родителей.'),
              SizedBox(height: 10,),

              Text('После того как вы успешно подали заявление на социалку вы получите ' + 
              'единовременную выплату в размере'),
              Text('1000 р.', style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),

              Text('Сама социальная стипендия приходит одним платежом с государственной '+ 
              'академической стипендией и составляет'),
              Text('4391.74 р.', style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),

              Text('Если вы студент первого и второго курса и учитесь на "хорошо" и ' + 
              '"отлично" то вы можете написать заявление на повышенную социалку которая '+
              'будет суммироваться с обычной социалкой.'),
              Text('5000,00 р.', style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),
              
              Text('Также не стоит забывать о материалке (материальной помощи), '+
              'заявление на которую можно также написать в деканате раз в семестр. '+
              'Размер этой выплаты каждый семестр может различаться но обычно составляет около'),
              Text('10 000,00 р.', style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('Повышенная государственная академическая стипендия', style: h1,),
              ),
              Text('На данную стипендию могут рассчитывать студенты имеющие достижения в ' +
              'какой - либо одной или нескольких областях деятельности (учебной, ' + 
              'культурно-творческой, спортивной, научно-исследовательской, общественной)' +
              'Размер стипендии определяется в зависимости от курса обучения.'),
              
              SizedBox(height: 20,),
              
              Table(
                border: TableBorder.all(color: Colors.white),
                children: [
                  TableRow(
                    children: [
                      Text('Критерии по видам деятельности', textAlign: TextAlign.center,),
                      Text('1 курс', textAlign: TextAlign.center,),
                      Text('2 курс', textAlign: TextAlign.center,),
                      Text('3 курс', textAlign: TextAlign.center,),
                      Text('4 курс', textAlign: TextAlign.center,),
                      Text('5-6 курс', textAlign: TextAlign.center,),
                      Text('Магистранты', textAlign: TextAlign.center,),
                    ]
                  ),
                  TableRow(
                    children: [
                      Text('Учебная деятельность', textAlign: TextAlign.center,),
                      Text('5652.17', textAlign: TextAlign.center,),
                      Text('6173.91', textAlign: TextAlign.center,),
                      Text('6434.78', textAlign: TextAlign.center,),
                      Text('6695.65', textAlign: TextAlign.center,),
                      Text('6956.52', textAlign: TextAlign.center,),
                      Text('7217.39', textAlign: TextAlign.center,),
                    ]
                  ),
                  TableRow(
                    children: [
                      Text('Научно-исследовательская деятельность', textAlign: TextAlign.center,),
                      Text('5652.17', textAlign: TextAlign.center,),
                      Text('6173.91', textAlign: TextAlign.center,),
                      Text('6434.78', textAlign: TextAlign.center,),
                      Text('6695.65', textAlign: TextAlign.center,),
                      Text('6956.52', textAlign: TextAlign.center,),
                      Text('7217.39', textAlign: TextAlign.center,),
                    ]
                  ),
                  TableRow(
                    children: [
                      Text('Общественная деятельность', textAlign: TextAlign.center,),
                      Text('5391.30', textAlign: TextAlign.center,),
                      Text('5886.95', textAlign: TextAlign.center,),
                      Text('6134.78', textAlign: TextAlign.center,),
                      Text('6382.61', textAlign: TextAlign.center,),
                      Text('6630.43', textAlign: TextAlign.center,),
                      Text('6878.26', textAlign: TextAlign.center,),
                    ]
                  ),
                  TableRow(
                    children: [
                      Text('культурно-творческая деятельность', textAlign: TextAlign.center,),
                      Text('5391.30', textAlign: TextAlign.center,),
                      Text('5886.95', textAlign: TextAlign.center,),
                      Text('6134.78', textAlign: TextAlign.center,),
                      Text('6382.61', textAlign: TextAlign.center,),
                      Text('6630.43', textAlign: TextAlign.center,),
                      Text('6878.26', textAlign: TextAlign.center,),
                    ]
                  ),
                  TableRow(
                    children: [
                      Text('Спортивная деятельность', textAlign: TextAlign.center,),
                      Text('5391.30', textAlign: TextAlign.center,),
                      Text('5886.95', textAlign: TextAlign.center,),
                      Text('6134.78', textAlign: TextAlign.center,),
                      Text('6382.61', textAlign: TextAlign.center,),
                      Text('6630.43', textAlign: TextAlign.center,),
                      Text('6878.26', textAlign: TextAlign.center,),
                    ]
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('Итог', style: h1,),
              ),
              Text('В результате несложных подсчетов уже на первом курсе есть возможность получать около 15 000 р. учась на "отлично" и оформив социальную стипендию, а собрав ко второму курсу какие либо грамоты или другие документы подтверждающие участие в какой либо деятельности можно получать уже около 20 000 р'),
            ],
          ),
        ),
      ),
    );
  }
}