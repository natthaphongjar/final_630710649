import 'package:flutter/material.dart';

import '../API/api.dart';

class Vote_result extends StatefulWidget {
  const Vote_result({Key? key}) : super(key: key);

  @override
  State<Vote_result> createState() => _Vote_resultState();
}

class _Vote_resultState extends State<Vote_result> {
  @override
  var data;

  bool active = false;

  void initState() {
    getData();
  }

  void getData() async {
    var api = Api();
    data = await api.fetch(detail: 'vote');
    print("data is ");
    print(data[0]);

    setState(() {
      active = true;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          "VOTE RESULT",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(image: new AssetImage("assets/bg.png"), fit: BoxFit.cover,),
        ),
        child: Column(
          children: [
            if (!active) Expanded(flex: 5, child: CircularProgressIndicator()),
            if (active)
              Expanded(
                  flex: 6,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return detail(data[index]);
                      })),
          ],
        ),
      ),
    );
  }


  Widget detail(var data) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0 , right: 32 , left: 32),
      child: Row(

        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.network(
                    'http://103.74.252.66:8888${data['flagImage']}',
                    width: 120,
                    height: 120,
                  ),
                ),
                Text(
                  data['team'],
                  style: TextStyle(fontSize: 25 , color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('${data['voteCount']}' , style: TextStyle(fontSize: 35 ,color: Colors.white),),
          )
        ],
      ),
    );
  }
}
