import 'package:flutter/material.dart';

class ScreenC extends StatefulWidget {
  final int tapedItem;
  final List items;
  const ScreenC({
    super.key,
    required this.items,
    required this.tapedItem,
  });

  @override
  State<ScreenC> createState() => _ScreenCState();
}

class _ScreenCState extends State<ScreenC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen C"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: ((context, index) {
              for (var i = 0; i < widget.items.length; i++) {
                if (widget.items[i].id == widget.tapedItem) {
                  return Card(
                    elevation: 20,
                    child: SizedBox(
                      height: 500,
                      width: 280,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "id: ${widget.items[i].id.toString()}\nParent: ${widget.items[i].parent.toString()}\nName: ${widget.items[i].name}\nSlug: ${widget.items[i].slug}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  );
                }
              }
              return const CircularProgressIndicator.adaptive();
            }),
          ),
        ),
      ),
    );
  }
}
