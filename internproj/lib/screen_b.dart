import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internproj/dataModel.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'package:internproj/screen_c.dart';

class ScreenB extends StatefulWidget {
  //pasing parent id for checking whig parent was tapped
  final int? parentId;
  final List items;
  final int itemIndex;
  const ScreenB({
    super.key,
    required this.parentId,
    required this.items,
    required this.itemIndex,
  });

  @override
  State<ScreenB> createState() => _ScreenBState();
}

class _ScreenBState extends State<ScreenB> {
  //reading data from json
  Future<List<DataModel>> readData() async {
    final data = await root_bundle.rootBundle.loadString('sources/data.json');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => DataModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    var indexOfChildSub = [];
    int childSub;
    int count = 0;

    var indexOfObj = [];
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.items[widget.itemIndex].name}"),
      ),
      body: FutureBuilder(
        future: readData(),
        builder: (context, data) {
          //check for proper reading of the data
          if (data.hasError) {
            return Text('${data.error}');
          } else if (data.hasData) {
            //storing data items in a list
            var items = data.data as List;
            //check for number of objects gaving same parent and storing their index in the list
            for (var i = 0; i < items.length; i++) {
              if (items[i].parent == widget.parentId) {
                indexOfObj.add(i);
                count += count;
              }
            }
            //check weather child is present or not
            return ListView.builder(
                itemCount: indexOfObj.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    splashColor: Colors.blue,
                    onTap: () async {
                      childSub = items[indexOfObj[index]].id;
                      int subChildCount = 0;
                      for (int i = 0; i < items.length; i++) {
                        if (items[i].parent == childSub) {
                          subChildCount++;
                          indexOfChildSub.add(i);
                        }
                      }
                      //check for sub child
                      if (subChildCount > 0) {
                        return showModalBottomSheet(
                            elevation: 30,
                            isScrollControlled: true,
                            context: context,
                            builder: ((BuildContext context) {
                              return SizedBox(
                                height: 400,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: subChildCount,
                                      itemBuilder: ((context, index) {
                                        return Card(
                                          elevation: 20,
                                          margin: const EdgeInsets.all(8),
                                          child: SingleChildScrollView(
                                            child: SizedBox(
                                              height: 150,
                                              width: 300,
                                              child: Center(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                          "id: ${items[indexOfChildSub[index]].id.toString()}\nName: ${items[indexOfChildSub[index]].name}\nParent: ${items[indexOfChildSub[index]].parent.toString()}"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    )
                                  ],
                                ),
                              );
                            }));
                      } else {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ScreenC(
                              items: items,
                              tapedItem: childSub,
                              
                            ),
                          ),
                        );
                      }
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
                                "id: ${items[indexOfObj[index]].id.toString()}\nname: ${items[indexOfObj[index]].name.toString()}\nslug: ${items[indexOfObj[index]].slug.toString()}",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
