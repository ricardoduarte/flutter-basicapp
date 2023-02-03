import 'package:flutter/material.dart';
import 'location_list.dart';
import 'mocks/mock_location.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context)
  {
    final mockLocations = MockLocation.fetchAll();

    return MaterialApp(home: LocationList(mockLocations));
  }
}
