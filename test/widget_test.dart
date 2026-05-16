import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/login_screen.dart';

void main() {
  testWidgets('Login flow validation', (WidgetTester tester) async {
    // 1. Підготовка
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // 2. Знаходимо поля та кнопку
    final emailField = find.byType(TextField).first;
    final passwordField = find.byType(TextField).last;
    final loginButton = find.widgetWithText(ElevatedButton, 'Login');

    // 3. Введення некоректних даних
    await tester.enterText(emailField, 'wrongemail');
    await tester.enterText(passwordField, '123');
    await tester.tap(loginButton);
    await tester.pump(); // оновлюємо стан

    // 4. Перевірка повідомлення про помилку email
    expect(find.text('Invalid email format'), findsOneWidget);

    // 5. Введення коректного email, але короткий пароль
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, '123');
    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text('Password must be at least 6 characters'), findsOneWidget);

    // 6. Успішний логін
    await tester.enterText(passwordField, '123456');
    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text('Login successful!'), findsOneWidget);
  });
}