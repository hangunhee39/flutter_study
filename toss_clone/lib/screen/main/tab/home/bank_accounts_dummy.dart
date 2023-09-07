import 'package:fast_app_base/screen/main/tab/home/banks_dummy.dart';
import 'package:fast_app_base/screen/main/tab/home/vo/vo_bank_account.dart';

final bankAccountShinhan1 = BankAccount(bankShinhan, 2000000, accountTypeName: "신한 주거래 우대통장(저축예금)");
final bankAccountShinhan2 = BankAccount(bankShinhan, 22000000, accountTypeName: "저축예금");
final bankAccountShinhan3 = BankAccount(bankShinhan, 670000, accountTypeName: "정기적금");
final bankAccountToss = BankAccount(bankShinhan, 80000 );
final bankAccountKakao = BankAccount(bankShinhan, 30000000, accountTypeName: "저축예금");

//List
final List<BankAccount> bankAccounts = [
  bankAccountShinhan1,
  bankAccountShinhan2,
  bankAccountShinhan3,
  bankAccountKakao,
  bankAccountToss
];

//Map : key 값이 필요할 때 , 중복 x

//Set : 포함되어 있는지 확인 , 중복 x