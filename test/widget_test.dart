import 'package:flutter_test/flutter_test.dart';
import 'package:vetresources_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const VetResourcesApp());
    expect(find.text('Blogs'), findsOneWidget);
  });
}
