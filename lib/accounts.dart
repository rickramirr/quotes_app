import 'user.dart';

class Accounts {

  final accounts = [
    User("rick@gmail.com", "rickramirr", "passwordlol")
  ];

  Future<User> getUserByEmail(String email) async {
    return Future.delayed(
      Duration(seconds: 4), () {
        return accounts.firstWhere((element) => element.email == email);
      }
    );
  }

  Future<User> authenticateByEmailAndPassword(String email, String password) async {
    try {
      final account = await getUserByEmail(email);
      if (account.password == password) {
        return account;
      } else {
        return Future.error("Incorrect email/password combination");
      }
    } catch (e) {
      return Future.error("Not found");
    }
  }
}