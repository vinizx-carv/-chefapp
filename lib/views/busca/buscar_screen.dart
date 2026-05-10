import 'package:flutter/material.dart';

class TelaBuscar extends StatelessWidget {
  const TelaBuscar({super.key});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: 50,

      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item $index'),
        );
      },
    );
  }
}