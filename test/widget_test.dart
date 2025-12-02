import 'package:flutter_test/flutter_test.dart';
import 'package:fintrack/app/app.dart';

void main() {
  testWidgets('FinTrack app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(FinTrackApp());

    // Verify that the app loads.
    expect(find.text('FinTrack'), findsOneWidget);
  });
}
