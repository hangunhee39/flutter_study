import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController pwdTextController = TextEditingController();

  //로그인 (firebase)
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("user-not-found");
      } else if (e.code == "wrong-password") {
        print("wrong-password");
      }
    } catch (e) {
      print(e);
    }
  }

  //:구글 로그인 (googleSign -> firebase) , android 는 디지털 지문 등록 필수 ./gradlew signingReport
  Future<UserCredential?> signInWithGoogle() async{
    //googleSign
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    //firebase 로그인
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/fastcampus_logo.png"),
              const Text("패스트 마켓",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42)),
              const SizedBox(height: 64),
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
                      //Form 에서 값 확인 기능
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "이메일 주소를 입력하세요.";
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
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "비밀번호를 입력하세요.";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final result = await signIn(
                        emailTextController.text.trim(),
                        pwdTextController.text.trim(),
                      );
                      if (result==null) {
                        //:비동기(async)일때는 context 쓸 때 mounted 인걸 체크 필요
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("로그인 실패")));
                        }
                        return;
                      }
                      //로그인 성공
                      if (context.mounted) {
                        context.go("/");
                      }
                    }
                  },
                  height: 48,
                  minWidth: double.infinity,
                  color: Colors.red,
                  child: const Text(
                    "로그인",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => context.push("/sign_up"),
                  child: const Text("계정이 없나요? 회원가입")),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                //Img click 가능하게 Gesture 써도됨
                child: InkWell(
                  onTap: () async{
                    final userCredit = await signInWithGoogle();

                    if (userCredit == null) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("로그인 실패")));
                      }
                      return;
                    }
                    if (context.mounted) {
                      context.go("/");
                    }
                  },
                    child: Image.asset("assets/btn_google_signin.png")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
