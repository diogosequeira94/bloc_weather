import 'package:flutter/material.dart';

class CitySelectionScreen extends StatefulWidget {
  @override
  _CitySelectionScreenState createState() => _CitySelectionScreenState();
}

class _CitySelectionScreenState extends State<CitySelectionScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City'),
      ),
      body: Form(
        child: Row(
          children: [
            Expanded(child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'City',
                  hintText: 'Lisbon',
                ),
              ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                Navigator.pop(context, _textController.text);
              },
            )
          ],
        ),
      ),
    );
  }
}
