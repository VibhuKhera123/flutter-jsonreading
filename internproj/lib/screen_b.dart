import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internproj/dataModel.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'package:internproj/screen_c.dart';

class ScreenB extends StatefulWidget {
  //pasing parent id for checking whig parent was tapped
  int? parentId;
  final List items;
  int itemIndex;
  ScreenB({
    super.key,
    required this.parentId,
    required this.items,
    required this.itemIndex,
  });

  @override
  State<ScreenB> createState() => _ScreenBState();
}

class _ScreenBState extends State<ScreenB> {
  Future<List<DataModel>> readData() async {
    final data = await root_bundle.rootBundle.loadString('sources/data.json');
    final list = json.decode(data) as List;
    return list.map((e) => DataModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    int tapedIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.items[widget.itemIndex].name}"),
      ),
      body: FutureBuilder(
        future: readData(),
        builder: (context, data) {
          if (data.hasError) {
            return Text('${data.error}');
          } else if (data.hasData) {
            var items = data.data as List;
            int count = 0;
            var indexOfObj = [];

            //check for number of objects gaving same parent and storing their index in the list
            if (count == 0) {
              for (var i = 0; i < items.length; i++) {
                if (items[i].parent == widget.parentId) {
                  indexOfObj.add(i);
                  count++;
                }
              }
            }

            //check weather child is present or not
            if (count > 0) {
              return ListView.builder(
                itemCount: indexOfObj.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    splashColor: Colors.blue,
                    onTap: () async {
                      setState(() {
                        tapedIndex = items[indexOfObj[index]].id;
                        widget.parentId = tapedIndex;
                        for (int i = 0; i < items.length; i++) {
                          if (items[i].parent == widget.parentId) {
                            indexOfObj.add(i);
                            count++;
                          }
                        }
                      });
                    },
                    child: Card(
                      elevation: 20,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: SizedBox(
                        height: 150,
                        width: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "id: ${items[indexOfObj[index]].id.toString()}\nname: ${items[indexOfObj[index]].name.toString()}\nslug: ${items[indexOfObj[index]].slug.toString()}\nParent: ${items[indexOfObj[index]].parent.toString()}",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            } else {
              return ScreenC(
                items: items,
                tapedItem: widget.parentId,
              );
            }
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
