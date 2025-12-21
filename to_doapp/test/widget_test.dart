import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_doapp/app/app.dart';

void main() {
  testWidgets('renders Todo App Skeleton text', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    expect(find.text('Todo App Skeleton'), findsOneWidget);
  });
}
