import 'package:flutter/material.dart';
import 'package:mypaws/core/DI/auth_controller.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/theme/theme.dart';
import 'package:mypaws/core/widget/title_back.dart';
import 'package:mypaws/core/widget/title_text.dart';
import 'package:mypaws/src/pages/create%20account/create_account_controller.dart';
import 'package:get/get.dart';

class CreateAccountPage extends StatelessWidget {
  CreateAccountPage({super.key});

  final _createAccountController = Get.put(CreateAccountController());

  final formkey = GlobalKey<FormState>();

  String textBoxName = '';

  var emailCtr= TextEditingController();
  var passwordCtr = TextEditingController();
  var nameCtr = TextEditingController();
  var lastnameCtr = TextEditingController();
  var phoneCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(
              FocusScopeNode()), //ต้องการเอาคีบอร์ดลง หรือหมายถึง ออกจากโฟกัส
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  HeaderBack(headLine1: "Create", headLine2: "MyPaws Account")
                ],
              ),
              _detailWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailWidget(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Stack(children: [
        DraggableScrollableSheet(
          maxChildSize: 0.70,
          initialChildSize: .70,
          minChildSize: .70,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: AppTheme.padding.copyWith(bottom: 0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  // physics: const BouncingScrollPhysics(),
                  child: _bottomSheetContent(context),
                ),
              ),
            );
          },
        ),
        Positioned(
          top: 160,
          left: 100,
          right: 100,
            child: Container(
                width: 100,
                height: 80,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                  child: Image.asset(
                    'assets/pugboyboy.png',
                    fit: BoxFit.fitHeight,
                  ),
                ))),
      ]),
    );
  }

  Widget _bottomSheetContent(context) {
    return GetBuilder<CreateAccountController>(
      builder: (CreateAccountController controller) {
        return Form(
          key: formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              _textField(textBoxName = 'Email',
                  icon: Icons.person, controller: emailCtr),
              const SizedBox(
                height: 20,
              ),
              _textField(textBoxName = 'Password',
                  icon: Icons.lock_person, controller: passwordCtr),
              const SizedBox(
                height: 20,
              ),
              _textField(textBoxName = 'Name',
                  icon: Icons.face, controller: nameCtr),
              const SizedBox(
                height: 20,
              ),
              _textField(textBoxName = 'Lastname',
                  icon: Icons.color_lens, controller: lastnameCtr),
              const SizedBox(
                height: 20,
              ),
              _textField(textBoxName = 'Phone',
                  icon: Icons.contact_phone_outlined, controller: phoneCtr),
              const SizedBox(
                height: 20,
              ),
              _createAccountButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _textField(String textBoxName,
      {IconData? icon, TextEditingController? controller}) {
    return Container(
      height: 40,
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: LightColor.lightGrey.withAlpha(100),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: textBoxName,
          contentPadding:
              EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 15),
          prefixIcon: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกข้อมูล';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget  _createAccountButton() {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: (){
            AuthController.instance.register(emailCtr.text.trim(), passwordCtr.text.trim(), nameCtr.text.trim(), lastnameCtr.text.trim(), phoneCtr.text.trim());
            // print('${emailCtr.text.trim()}, ${passwordCtr.text.trim()}');
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Color.fromARGB(255, 64, 158, 235),
          backgroundColor: Color.fromARGB(255, 64, 158, 235),
          shape: const StadiumBorder(),
          side: const BorderSide(color: Color.fromARGB(255, 64, 158, 235)),
        ),
        child: const TitleText(
          text: 'Sign up',
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}
