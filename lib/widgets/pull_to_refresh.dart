import 'package:flutter/material.dart';

class PullToRefreshWidget extends StatefulWidget {
  const PullToRefreshWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PullToRefreshWidgetState createState() => _PullToRefreshWidgetState();
}

class _PullToRefreshWidgetState extends State<PullToRefreshWidget> {
  List<String> items = List<String>.generate(20, (index) => "Item $index");

  Future<void> _refreshData() async {
    // Simulate a delay for fetching new data
    await Future.delayed(Duration(seconds: 2));

    // Here you can add new items or refresh your data from an API
    setState(() {
      items = List<String>.generate(20, (index) => "Updated Item $index");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pull to Refresh Example"),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
            );
          },
        ),
      ),
    );
  }
}


