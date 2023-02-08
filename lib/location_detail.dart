import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/location.dart';
import 'components/location_tile.dart';
import 'styles.dart';

const BannerImageHeight = 245.0;
const BodyVerticalPadding = 20.0;
const FooterHeight = 100.0;

class LocationDetail extends StatefulWidget {
  final int locationID;

  LocationDetail(this.locationID);

  @override
  createState() => _LocationDetailState(locationID);
}

class _LocationDetailState extends State<LocationDetail> {
  final int locationID;
  Location location = Location.blank();

  _LocationDetailState(this.locationID);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final location = await Location.fetchByID(locationID);

    if (mounted) {
      setState(() {
        this.location = location;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name, style: Styles.navBarTitle),
      ),
      body: Stack(
        children: [
          _renderBody(location),
          _renderFooter(location),
        ],
      ),
    );
  }

  Widget _renderBody(Location location) {
    var result = <Widget>[];
    result.add(_bannerImage(location.url, BannerImageHeight));
    result.add(_renderHeader());
    result.addAll(_renderFacts(location));
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: result,
      ),
    );
  }

  Widget _renderHeader() {
    return Container(
        padding: const EdgeInsets.symmetric(
            vertical: BodyVerticalPadding,
            horizontal: Styles.horizontalPaddingDefault),
        child: LocationTile(location: location, darkTheme: false));
  }

  List<Widget> _renderFacts(Location location) {
    var result = <Widget>[];
    if (location.facts != null) {
      for (int i = 0; i < location.facts!.length; i++) {
        result.add(_sectionTitle(location.facts![i].title));
        result.add(_sectionText(location.facts![i].text));
      }
    }
    return result;
  }

  Widget _sectionTitle(String text) {
    return Container(
      padding: const EdgeInsets.fromLTRB(Styles.horizontalPaddingDefault, 25.0,
          Styles.horizontalPaddingDefault, 0.0),
      child: Text(
        text.toUpperCase(),
        textAlign: TextAlign.left,
        style: Styles.headerLarge,
      ),
    );
  }

  Widget _sectionText(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 10.0, horizontal: Styles.horizontalPaddingDefault),
      child: Text(text, style: Styles.textDefault),
    );
  }

  Widget _renderFooter(Location location) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
          height: FooterHeight,
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: _renderBookButton(),
          ),
        ),
      ],
    );
  }

  Widget _bannerImage(String url, double height) {
    Image? image;
    try {
      if (url.isNotEmpty) {
        image = Image.network(url, fit: BoxFit.fitWidth);
      }
    } catch (e) {
      print('could not load image from $url');
    }

    return Container(
      constraints: BoxConstraints.tightFor(height: height),
      child: image,
    );
  }

  Widget _renderBookButton() {
    return TextButton(
      onPressed: _handleBookPress,
      style: TextButton.styleFrom(
        backgroundColor: Styles.accentColor,
        foregroundColor: Styles.textColorBright,
      ),
      child: Text('BOOK', style: Styles.textCTAButton),
    );
  }

  void _handleBookPress() async {
    final url = Uri.parse('mailto:hello@tourism.co?subject=inquiry');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
