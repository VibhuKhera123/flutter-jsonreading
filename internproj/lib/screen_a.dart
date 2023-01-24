import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:internproj/dataModel.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'package:internproj/screen_b.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //function to read data from json file and store it in a list of map
  Future<List<DataModel>> readData() async {
    final data = await root_bundle.rootBundle.loadString('sources/data.json');
    final list = json.decode(data) as List;
    return list.map((e) => DataModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen A'),
      ),
      body: FutureBuilder(
        future: readData(),
        builder: (context, data) {
          //check for proper reading of the data
          if (data.hasError) {
            return Text("${data.error}");
          } else if (data.hasData) {
            var items = data.data as List;
            //finding parent catagorie in the list
            var parentCat = [];

            for (int i = 0; i < items.length; i++) {
              if (items[i].parent == 0) {
                parentCat.add(i);
              }
            }
            //displaying the elements
            return ListView.builder(
              itemCount: parentCat.length,
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.blue.withAlpha(50),
                  onTap: () async {
                    final parentId = items[parentCat[index]].id;

                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ScreenB(
                          parentId: parentId,
                          items: items,
                          itemIndex: parentCat[index],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 20,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: SizedBox(
                      height: 150,
                      width: 200,
                      child: Center(
                        child: Text(items[parentCat[index]].name.toString()),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
