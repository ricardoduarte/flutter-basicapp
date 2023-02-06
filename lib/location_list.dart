import 'package:flutter/material.dart';
import 'models/location.dart';
import 'package:basic/location_detail.dart';
import 'styles.dart';

class LocationList extends StatefulWidget {
  @override
  createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  List<Location> locations = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final locations = await Location.fetchAll();
    setState(() {
      this.locations = locations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Locations', style: Styles.navBarTitle)),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: _listViewItemBuilder,
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    final location = locations[index];
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      leading: _itemThumbnail(location),
      title: _itemTitle(location),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationDetail(location.id),
            ));
      },
    );
  }

  Widget _itemThumbnail(Location location) {
    return Container(
      constraints: BoxConstraints.tightFor(width: 100.0),
      child: Image.network(location.url, fit: BoxFit.fitWidth),
    );
  }

  Widget _itemTitle(Location location) {
    return Text(location.name, style: Styles.textDefault);
  }
}
