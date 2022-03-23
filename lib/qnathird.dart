import 'package:flutter/material.dart';

class QnaThirdPage extends StatelessWidget {
  const QnaThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "My Page",
              style: TextStyle(
                color: Colors.pink[200],
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white),
        body: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.person_add),
                  iconSize: 40,
                  onPressed: () {},
                ),
                title: Row(
                  children: [
                    Text(
                      "ID",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text(":"),
                    SizedBox(width: 10),
                    Text(
                      "스파르타 팀 13",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text(
                      'MYPOINT',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 40),
                    Text('350')
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
