import 'package:flutter/material.dart';

/*This is a simple button componet*/
class AddEventButtonComponent extends StatefulWidget {
  @override
  _AddEventButtonComponentState createState() => _AddEventButtonComponentState();
}

class _AddEventButtonComponentState extends State<AddEventButtonComponent> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      height: 60.0,
      margin: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        color: Color(0xFFF8B83E),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: (size.width * 0.9) * 0.1,
              child:Icon(Icons.add, color: Colors.white,),
            ),
            Container(
              width: (size.width * 0.9) * 0.8,
              child: Text('CREATE EVENT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
            )
          ],
        ),
        onPressed: (){},
      ),
    );
  }
}