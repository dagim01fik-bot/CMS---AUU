import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:security_app/main.dart';

void main() {
  testWidgets('renders security login shell', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('UniGate Security'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Officer ID or Email'), findsOneWidget);
  });
}
