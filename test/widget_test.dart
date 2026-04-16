import 'package:flutter_test/flutter_test.dart';

import 'package:project/main.dart';

void main() {
  testWidgets(
    'App shows splash screen and navigates to login',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MyApp(firebaseInitialization: Future.value()),
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Welcome Back!'), findsNothing);

      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(find.text('Welcome Back!'), findsOneWidget);
      expect(find.text('Login to continue your shopping'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    },
  );
}
