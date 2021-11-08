import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; //for bringing json

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [];
    getJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JSON TEST"),
      ),
      body: Center(
          child: data.isEmpty
              ? const Text("data is not available")
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text('Code : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(data[index]['code'].toString())
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Name : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(data[index]['name'].toString())
                            ],
                          ),
                          Row(
                            children: [
                              const Text('DEPT : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(data[index]['dept'].toString())
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Phone : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(data[index]['phone'].toString())
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: data.length,
                )),
    );
  }

  Future<String> getJson() async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/zeushahn/Test/main/student2.json');
    var response = await http.get(url);
    print(response.body);
    setState(() {
      var dataConvert = json.decode(utf8.decode(response.bodyBytes));
      List result = dataConvert['results'];
      data.addAll(result);
    });

    return response.body;
  }
}
