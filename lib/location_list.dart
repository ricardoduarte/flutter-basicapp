import 'package:flutter/material.dart';
import 'models/location.dart';
import 'components/location_tile.dart';
import 'location_detail.dart';
import 'styles.dart';

const ListItemHeight = 245.0;

class LocationList extends StatefulWidget {
  @override
  createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  List<Location> locations = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() => loading = true);
    final locations = await Location.fetchAll();
    setState(() {
      this.locations = locations;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Locations', style: Styles.navBarTitle)),
      body: RefreshIndicator(
        onRefresh: loadData,
        child: Column(
          children: [
            renderProgressBar(context),
            Expanded(child: renderListView(context)),
          ],
        ),
      ),
    );
  }

  Widget renderProgressBar(BuildContext context) {
    return (loading
        ? const LinearProgressIndicator(
            value: null,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          )
        : Container());
  }

  Widget renderListView(BuildContext context) {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: _listViewItemBuilder,
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    final location = locations[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationDetail(location.id),
            ));
      },
      child: Container(
        height: ListItemHeight,
        child: Stack(
          children: [
            _tileImage(location.url, MediaQuery.of(context).size.width, ListItemHeight),
            _tileFooter(location),
          ],
        ),
      ),
    );
  }

  Widget _tileImage(String url, double width, double height) {
    Image? image;
    try {
      image = Image.network(url, fit: BoxFit.cover);
    }
    catch (e) {
      print('could not load image from $url');
    }

    return Container(
      constraints: const BoxConstraints.expand(),
      child: image,
    );
  }

  Widget _tileFooter(Location location) {
    final info = LocationTile(location: location, darkTheme: true);
    final overlay = Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: Styles.horizontalPaddingDefault),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      child: info,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [overlay],
    );
  }

  Widget _itemTitle(Location location) {
    return Text(location.name, style: Styles.textDefault);
  }
}
