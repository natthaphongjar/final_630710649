import 'package:final_630710649/API/api.dart';
import 'package:final_630710649/pages/votepage.dart';
import 'package:flutter/material.dart';

import '../dialog.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  var data;
  var api = Api();

  bool active = false;

  void initState() {
    getData();
  }

  void next_page() {
    print('next page');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Vote_result()));
  }

  void vote(var id, var team, var count) async {
    var m = {'id': id, 'voteCount': ++count};
    var post = await api.submit(m);

    showMyDialog(
        context, 'SUCCESS', 'YOU VOTED $team \n Data Saved successfully');
    print('vote $id $count');
  }

  void getData() async {
    data = await api.fetch();
    print("data is ");
    print(data[0]['flagImage']);

    setState(() {
      active = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, right: 32, left: 32),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0)),
                child: Center(
                    child: Image.asset(
                  'assets/logo.jpg',
                  width: 160,
                  height: 160,
                )),
              ),
            ),
            if (!active) Expanded(flex: 5, child: CircularProgressIndicator()),
            if (active)
              Expanded(
                  flex: 6,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return detail(data[index]);
                      })),
            InkWell(
              onTap: () {
                next_page();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 32, left: 32),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0)),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("View RESULT"),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget detail(var data) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 32, left: 32),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Image.network(
                          'http://103.74.252.66:8888${data['flagImage']}',
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['team'],
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'GROUP ${data['group']}',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: ElevatedButton(
                    onPressed: () {
                      vote(data['id'], data['team'], data['voteCount']);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'VOTE',
                        style: TextStyle(fontSize: 25),
                      ),
                    )),
              )
            ],
          )),
    );
  }
}
