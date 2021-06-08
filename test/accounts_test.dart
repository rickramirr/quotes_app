import 'package:flutter_test/flutter_test.dart';
import 'package:quotes_app/logic/accounts.dart';

void main() {
  group('Accounts', () {
    test("Account finded by email", () async {
      final accounts = Accounts();

      final account = await accounts.getUserByEmail("rick@gmail.com");

      expect(account == null, false);
    });

    test("Account not finded by email", () async {
      final accounts = Accounts();

      final account = await accounts.getUserByEmail("rick@gmail.co");

      expect(account == null, true);
    });

    test("Authenticated with correct email and password", () async{
      final accounts = Accounts();

      try {
        final auth = await accounts.authenticateByEmailAndPassword("rick@gmail.com", "passwordlol");
        expect(auth.username, "rickramirr");
      } catch (e) {
        fail("throwing error");
      }
    });

    test("Authenticated with incorrect email", () async{
      final accounts = Accounts();

      try {
        final auth = await accounts.authenticateByEmailAndPassword("rick@gmail.om", "passwordlol");
        fail("gettting account");
      } catch (e) {
        expect(e.toString(), "Not found");
      }
    });

    test("Authenticated with incorrect password", () async{
      final accounts = Accounts();

      try {
        final auth = await accounts.authenticateByEmailAndPassword("rick@gmail.com", "passwordol");
        fail("not getting here");
      } catch (e) {
        expect(e.toString(), "Incorrect email/password combination");
      }
    });
  });
  
}