
import 'dart:html';

import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget{

  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Text('pib-21-05'),
          Text('ПИБ-21Э1'),
        ]
      ),
    );
  }
}

class MyDrawerButton extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}