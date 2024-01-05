import 'package:flutter/material.dart';
import '../Utils/constantValues.dart';

class PackingListPage extends StatefulWidget {
  const PackingListPage({super.key});
  @override
  _PackingListPageState createState() => _PackingListPageState();
}

class _PackingListPageState extends State<PackingListPage> {

  List<String> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Packing List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ItemEntry(
                  item: items[index],
                  onDelete: () {
                    setState(() {
                      items.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onSubmitted: (value) {
                setState(() {
                  items.add(value);
                });
              },
              decoration: InputDecoration(
                labelText: 'Add item',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (items.isNotEmpty) {
                        items.add(items.last);
                      } else {
                        items.add('New Item');
                      }
                    });
                  },
                ),
              ),
            ),
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 50,
                      width: 100,
                      child: FilledButton(onPressed: () {}, child: Text('Delete'))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 50,
                      width: 100,
                      child: FilledButton(onPressed: () {}, child: Text('Delete'))),
                )
              ]
          )

        ],
      ),
    );
  }
}

class ItemEntry extends StatelessWidget {
  final double listPadding = 8;
  final String item;
  final VoidCallback onDelete;

  const ItemEntry({required this.item, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(listPadding),
        ),
        tileColor: Constant.mainGreenColor,
        title: Text(
          item,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete, // Change delete icon color to red
          ),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
