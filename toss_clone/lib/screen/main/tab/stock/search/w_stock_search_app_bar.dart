import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/util/app_keyboard_util.dart';
import 'package:fast_app_base/common/widget/w_arrow.dart';
import 'package:fast_app_base/common/widget/w_text_field_with_delete.dart';
import 'package:flutter/material.dart';

class StockSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController textEditingController;

  const StockSearchAppBar({required this.textEditingController, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: kToolbarHeight,
        child: Row(
          children: [
            Tap(
                onTap: () {
                  Nav.pop(context);
                },
                child: const SizedBox(
                    height: kToolbarHeight,
                    width: 56,
                    child: Arrow(
                      direction: AxisDirection.left,
                    ))),
            Expanded(
                child: TextFieldWithDelete(
              controller: textEditingController,
              textInputAction: TextInputAction.search,
              onEditingComplete: (){
                debugPrint("검색 버튼 ");
                AppKeyboardUtil.hide(context);
              },
              texthint: "'커피'를 검색해 보세요",
            ).pOnly(top: 6)),
            width20,
          ],
        ),
      ),
    );
  }

  //PreferredSizeWidget : 크기가 변할때 사용 (키보드 올라오면)
  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
