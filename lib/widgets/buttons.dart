import 'package:armanludocall/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import '../utilities.dart' as utilities;

class connectButtons extends StatefulWidget {
  const connectButtons({super.key});

  @override
  State<connectButtons> createState() => _connectButtonsState();
}

class _connectButtonsState extends State<connectButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                setState(() {});
                globals.callId = 1;
                utilities.getToken();
                utilities.setUrl();
              },
              child: const Text('User 1'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                setState(() {});
                globals.callId = 2;
                utilities.getToken();
                utilities.setUrl();
              },
              child: const Text('User 2'),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow),
              ),
              onPressed: () {
                setState(() {});
                globals.callId = 3;
                utilities.getToken();
                utilities.setUrl();
              },
              child: const Text(
                'User 3',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                setState(() {});
                globals.callId = 4;
                utilities.getToken();
                utilities.setUrl();
              },
              child: const Text('User 4'),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.purple),
              ),
              onPressed: () {
                setState(() {});
                globals.callId = 5;
                utilities.getToken();
                utilities.setUrl();
              },
              child: const Text('User 5'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
              ),
              onPressed: () {
                setState(() {});
                globals.callId = 6;
                utilities.getToken();
                utilities.setUrl();
              },
              child: const Text('User 6'),
            ),
          ],
        ),
      ]),
    );
  }
}
