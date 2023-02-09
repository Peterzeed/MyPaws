import 'package:flutter/material.dart';
import 'package:mypaws/core/DI/auth_controller.dart';
import 'package:mypaws/core/theme/light_color.dart';
import 'package:mypaws/core/widget/title_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypaws/src/pages/login/login_page_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  // FontWeight? weight;
  double? fSize;
  String? title;
  String? textBoxName;

  // bool statusRedEye = true;

  // final _loginPageController = Get.put(LoginPageController());
  final _authController = Get.put(AuthController());
  final _loginController = Get.put(LoginPageController());

  var emailCtr= TextEditingController();
  var passwordCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(
              FocusScopeNode()), //ต้องการเอาคีบอร์ดลง หรือหมายถึง ออกจากโฟกัส
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(alignment: Alignment.center, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      width: 500,
                      height: 550,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(13)),
                        child: Image.asset(
                          'assets/dogdog.png',
                          fit: BoxFit.fitHeight,
                        ),
                      )),
                ],
              ),
              Center(
                child: GetBuilder<LoginPageController>(
                  builder: (controller) {
                    return Column(
                      // mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        _title(FontWeight.bold, fSize = 45, title = "MyPaws"),
                        const SizedBox(
                          height: 10,
                        ),
                        _title(FontWeight.w800, fSize = 15,
                            title = "The Lost and Found Pet Application"),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        _title(FontWeight.w200, fSize = 12,
                            title = "แอปพลิเคชันตามหาสัตว์เลี้ยง"),
                        const SizedBox(
                          height: 200,
                        ),
                        _userField(
                          textBoxName = "Email",
                          Icons.person,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _passwordField(
                          textBoxName = "Password",
                          Icons.lock,
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        _LoginButton(),
                        
                        // const Divider(
                        //   thickness: 2,
                        //   height: 100,
                        // ),
                         const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _title(FontWeight.w200, fSize = 12,
                                title = "Don't have an account? "),
                                _CreateAccountButton(context),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _title(FontWeight? weight, double? fSize, String s) {
    return Center(
      // padding: const EdgeInsets.all(16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s,
              style: GoogleFonts.mulish().copyWith(
                  fontSize: fSize,
                  fontWeight: weight,
                  color: LightColor.lightGrey),
            ),
            // Text(
            //   "Pet",
            //   style: GoogleFonts.mulish().copyWith(
            //       fontSize: 20,
            //       fontWeight: FontWeight.w700,
            //       color: LightColor.lightGrey),
            // ),
          ]),
    );
  }

  Widget _LoginButton() {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          AuthController.instance.login(emailCtr.text.trim(), passwordCtr.text.trim());
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Color.fromARGB(255, 64, 158, 235),
          backgroundColor: Color.fromARGB(255, 64, 158, 235),
          shape: const StadiumBorder(),
          side: const BorderSide(color: Color.fromARGB(255, 64, 158, 235)),
        ),
        child: const TitleText(
          text: 'Log in',
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _CreateAccountButton(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 20,
      child: ElevatedButton(
        // onPressed: _authController.bypassLogin,
        onPressed: () {
          Navigator.pushNamed(context, '/createaccount' );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.white,
          shape: const StadiumBorder(),
          side: const BorderSide(color: Colors.white),
        ),
        child: const TitleText(
          text: 'Create Account',
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _userField(
    String textBoxName,
    IconData icon,
  ) {
    return Container(
      height: 50,
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: LightColor.lightGrey.withAlpha(500),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        controller: emailCtr,
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

  Widget _passwordField(
    String textBoxName,
    IconData icon,
  ) {
    return Container(
      height: 50,
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: LightColor.lightGrey.withAlpha(500),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Obx(
        () => (TextFormField(
          controller: passwordCtr,
          textInputAction: TextInputAction.search,
          obscureText: _loginController.isPasswordHide.value,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              // child: Icon(
              //   Icons.remove_red_eye_outlined,
              //   color: Colors.black54,
              // ),
              onPressed: () {
                _loginController.isPasswordHide.value =
                    !_loginController.isPasswordHide.value;
              },
              icon: _loginController.isPasswordHide.value
                  ? const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.black54,
                    )
                  : const Icon(
                      Icons.remove_red_eye,
                      color: Colors.black54,
                    ),
            ),
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
        )),
      ),
    );
  }
}
