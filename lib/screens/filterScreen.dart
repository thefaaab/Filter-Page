import 'package:filter/model/filter.model.dart';
import 'package:filter/services/data_service.dart';
import 'package:filter/utility/colors.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  final DataService dataService = DataService();
  FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: font,
          iconSize: 20,
        ),
        title: const Text(
          'Filter Options',
          style:
              TextStyle(fontSize: 22, color: font, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      backgroundColor: bg,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: dataService.getData(),
          builder: (context, snapshot) {
            var data = snapshot.data ?? [];

            if (data.isEmpty) {
              return const Center(child: Text('No data found'));
            }

            return FilterList(filterdata: data);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('SHOW 64 RESULTS'),
        backgroundColor: Colors.black54,
      ),
    );
  }
}

class FilterList extends StatefulWidget {
  final List<FilterData> filterdata;
  const FilterList({super.key, required this.filterdata});

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  @override
  Widget build(BuildContext context) {
    var data = widget.filterdata;
    return ListView(children: [
      SizedBox(
        height: 48,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: data
              .expand(
                (element) => element.taxonomies.where((e) => e.isChecked).map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RawChip(
                          label: Text(e.name ?? ''),
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () {
                            setState(() {
                              e.isChecked = !e.isChecked;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
              )
              .toList(),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(5),
        height: 240,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: listView,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text('Sort by',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.radio_button_checked),
                    color: radio,
                  ),
                  const Text(
                    'Nearest to me',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    '(default)',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.radio_button_unchecked),
                    color: font,
                  ),
                  const Text(
                    'Trending this week',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.radio_button_unchecked),
                    color: Colors.black87,
                  ),
                  const Text(
                    'Newest Added',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.radio_button_unchecked),
                    color: Colors.black87,
                  ),
                  const Text(
                    'Alphabetical',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ...List.generate(
        data.length,
        (i) => Card(
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ExpansionTile(
            textColor: font,
            title: Row(
              children: [
                Text(
                  data[i].name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (data[i].taxonomyCounnt != 0)
                  Text(
                    '\t(${data[i].taxonomyCounnt})',
                    style: const TextStyle(
                        color: radio, fontWeight: FontWeight.bold),
                  )
              ],
            ),
            children: [
              for (Taxonomy taxonomy in data[i].taxonomies)
                ListTile(
                  leading: taxonomy.isChecked
                      ? const Icon(
                          Icons.radio_button_checked,
                          color: radio,
                        )
                      : const Icon(Icons.radio_button_off),
                  onTap: () {
                    setState(() {
                      taxonomy.isChecked = !taxonomy.isChecked;
                    });
                  },
                  title: Text(taxonomy.name ?? ''),
                )
            ],
          ),
        ),
      ),
    ]);
  }
}
