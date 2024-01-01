import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTextController = TextEditingController();
  TextEditingController pwdTextController = TextEditingController();

  //회원가입 기능 (firebase)
  Future<bool> singUp(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);
      await FirebaseFirestore.instance.collection("users").add({
        "uid": credential.user?.uid ?? "",
        "email": credential.user?.email ?? ""
      });
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print("패스워드가 약합니다.");
      } else if (e.code == "email-already-in-use") {
        print("이미 정보가 존재합니다");
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("회원가입")),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "패스트 마켓\n가입을 환영합니다.",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 42,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "이메일",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "이메일 주소를 입력하시오.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: pwdTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "비밀번호",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "비밀번호를 입력하시오.";
                        }
                        return null;
                      },
                      obscureText: true, //비밀번호 감추기
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final result = await singUp(
                      emailTextController.text.trim(),
                      pwdTextController.text.trim(),
                    );
                    if (result) {
                      //context 체킹
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("회원가입 성공"))
                        );
                        context.go("/login");
                      }  
                    }else{
                      //context 체킹
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("회원가입 실패"))
                        );
                      }
                    }
                  }
                },
                height: 48,
                minWidth: double.infinity,
                color: Colors.red,
                child: const Text(
                  "회원가입",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
