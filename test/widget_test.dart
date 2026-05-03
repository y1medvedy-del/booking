import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:booking/app/app.dart';

void main() {
  testWidgets('opens onboarding after splash', (WidgetTester tester) async {
    await tester.pumpWidget(const GlobalStayApp());

    expect(find.byType(Image), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Находите идеальное жилье'), findsOneWidget);
  });
}
