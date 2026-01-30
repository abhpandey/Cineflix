import 'package:ceniflix/features/auth/presentation/pages/login_screen.dart';
import 'package:ceniflix/features/auth/presentation/pages/signup_screen.dart';
import 'package:ceniflix/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../helpers/fake_auth_view_model.dart';

void main() {
  Widget wrapWithApp(Widget child) {
    return ProviderScope(
      overrides: [
        authViewModelProvider.overrideWith(() => FakeAuthViewModel()),
      ],
      child: MaterialApp(home: child),
    );
  }

  testWidgets('Login: shows snackbar when email/password are empty',
      (tester) async {
    await tester.pumpWidget(wrapWithApp(const LoginScreen()));

    await tester.tap(find.text('LOGIN'));
    await tester.pump(); 

    expect(find.text('Please enter credentials'), findsOneWidget);
  });

  testWidgets('Login: tapping "Sign Up" navigates to SignupScreen',
    (tester) async {
  await tester.pumpWidget(wrapWithApp(const LoginScreen()));


  final signUpLink = find.byWidgetPredicate(
    (w) => w is GestureDetector && w.child is RichText,
  );

  expect(signUpLink, findsOneWidget);

  await tester.tap(signUpLink);
  await tester.pumpAndSettle();

  expect(find.byType(SignupScreen), findsOneWidget);
  expect(find.text('Create Account'), findsOneWidget);
});
}
