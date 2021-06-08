import '../models/user.dart';
import 'package:collection/collection.dart';

class Accounts {

  final accounts = [
    User("rick@gmail.com", "rickramirr", "passwordlol")
  ];

  Future<User?> getUserByEmail(String email) async {
    return Future.delayed(
      Duration(milliseconds: 100), () {
        return accounts.firstWhereOrNull((element) => element.email == email);
      }
    );
  }

  Future<User> authenticateByEmailAndPassword(String email, String password) async {
      final account = await getUserByEmail(email);
      if (account == null) {
        return Future.error("Not found");
      }
      if (account.password == password) {
        return account;
      } else {
        return Future.error("Incorrect email/password combination");
      }
  }
}