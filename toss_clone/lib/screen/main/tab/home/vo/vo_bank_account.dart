import 'vo_bank.dart';

class BankAccount {
  final Bank bank;
  int balance;
  final String? accountTypeName;

  BankAccount(
    this.bank,
    this.balance,
      //optional 하게 만들기
  {
    this.accountTypeName
  }
  );
}
