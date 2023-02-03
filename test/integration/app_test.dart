import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:basic/app.dart';
import 'package:basic/mocks/mock_location.dart';

void main() {

  testWidgets('test app startup', (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(const App());

      final mockLocation = MockLocation.fetchAny();

      expect(find.text(mockLocation.name), findsOneWidget);
      expect(find.text('${mockLocation.name}blah'), findsNothing);
    });
  });
  
}