import 'package:flutter/material.dart';
import 'package:flutter_muslim_soul_instagram/constants/constants.dart';
import 'package:flutter_muslim_soul_instagram/screens/authentication_screens/controllers/login_controller.dart';
import 'package:flutter_muslim_soul_instagram/screens/authentication_screens/widgets/text_field_decoration_widget.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

   final _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: height * 0.3,
                    decoration: const BoxDecoration(
                      color: lightPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 90,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    right: 30,
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.white),
                      // you can see it, I make changes here
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 38, left: 8, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Form(
                      key: _loginController.formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TextFormField(
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              // The validator receives the text that the user has entered.
                              controller: _loginController.emailController,
                              onSaved: (value) {
                                _loginController.email = value!;
                              },
                              validator: (value) {
                                return _loginController.validEmail(value!);
                              },
                              decoration: decorationWidget(
                                  context, "Enter Email", Icons.email),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TextFormField(
                              obscureText: true,
                              controller: _loginController.passwordController,
                              onSaved: (value) {
                                _loginController.password = value!;
                              },
                              validator: (value) {
                                return _loginController.validPassword(value!);
                              },
                              decoration: decorationWidget(
                                  context, "Enter Password", Icons.vpn_key),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            height: 40,
                            child: TextButton(
                              onPressed: () {
                                //Get.toNamed('/forgetPassword');
                              },
                              child: Text('Forgot Password?',
                                  style: Theme.of(context).textTheme.subtitle1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 10),
                                  textStyle: Theme.of(context).textTheme.headline2
                                ),
                                child: FittedBox(
                                  child: Obx(
                                    () => _loginController.isLoading.value
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text(
                                            'Login',
                                          ),
                                  ),
                                ),
                                onPressed: () {
                                  _loginController.login();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account ? ',style: Theme.of(context).textTheme.
                  subtitle1?.copyWith(fontSize: 16),),
                  TextButton(
                    onPressed: () {
                      Get.offNamed('/register_screen');
                    },
                    child: Text(
                      'Register',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
