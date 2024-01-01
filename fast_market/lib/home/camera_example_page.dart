import 'package:camera/camera.dart';
import 'package:fast_market/main.dart';
import 'package:flutter/material.dart';

//Camera (package)사용
class CameraExamplePage extends StatefulWidget {
  const CameraExamplePage({super.key});

  @override
  State<CameraExamplePage> createState() => _CameraExamplePageState();
}

class _CameraExamplePageState extends State<CameraExamplePage> {
  CameraController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //카메라 초기 세팅
    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller?.initialize().then((value){
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller?.value.isInitialized ?? false
          ? CameraPreview(controller!)
          : Container(child: const Text("초기화 중"),),
    );


  }
}
