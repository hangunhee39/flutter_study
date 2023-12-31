import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_market/firebase_options.dart';
import 'package:fast_market/home/HomeScreen.dart';
import 'package:fast_market/home/cart_screen.dart';
import 'package:fast_market/home/product_add_screen.dart';
import 'package:fast_market/home/product_detail_screen.dart';
import 'package:fast_market/login/login_screen.dart';
import 'package:fast_market/login/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


//카메라 설정
List<CameraDescription> cameras = [];

void main() async {
  //중요: 파이어베이스 설정
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //카메라 개수 확인
  cameras = await availableCameras();

  //파이베이스 예뮬 설정 , firebase emulators:start , google login 은 안됨
  if (kDebugMode) {
    try {
      await FirebaseAuth.instance.useAuthEmulator("localhost", 9099);
      FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
      FirebaseStorage.instance.useStorageEmulator("localhost", 9199);

    } catch (e) {
      print(e);
    }
  }
  runApp(FastMarket());
}

class FastMarket extends StatelessWidget {
  FastMarket({super.key});

  //router 설정
  final router = GoRouter(
    initialLocation: "/login",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(
              path: "cart/:uid",
              builder: (context, state) => CartScreen(
                    uid: state.pathParameters["uid"] ?? "",
                  )),
          GoRoute(
              path: "product",
              builder: (context, state) => ProductDetailScreen()),
          GoRoute(
              path: "product/add",
              builder: (context, state) => ProductAddScreen()),
        ],
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: "/sign_up",
        builder: (context, state) => SignUpScreen(),
      )
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '패스트 마켓',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
