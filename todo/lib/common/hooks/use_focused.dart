import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

bool userIsFocused(FocusNode node){
  final isFocused = useState(node.hasFocus);

  //node의 의존성있음 node 가 바뀔때만 수행 1번만 수행하고 싶으면 [] 넣기
  useEffect((){
    void listener(){
      isFocused.value = node.hasFocus;
    }
    node.addListener(listener);

    //dispose 할때 호출?!
    return () => node.removeListener(listener);
  },[node]);

  return isFocused.value;
}