import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;
import '../../../components/button_reusable.dart';
import '../../../components/textfield_reusable.dart';
import '../../../utils/functions/function_helper.dart';
import '../../../utils/helper/vibrate_helper.dart';

class SignInForm extends StatefulWidget {
  final Function()? onSignIn;
  final Function()? onCreateAccount;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool? isLoading;
  const SignInForm(
      {super.key,
      this.onSignIn,
      this.onCreateAccount,
      required this.emailController,
      required this.passwordController,
      this.isLoading});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;

  late rive.SMITrigger check;
  late rive.SMITrigger error;
  late rive.SMITrigger reset;

  late rive.SMITrigger confetti;

  rive.StateMachineController getRiveController(rive.Artboard artboard) {
    rive.StateMachineController? controller =
        rive.StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  void signIn(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      showIOSDialog(context,
          title: "Message", content: "Please enter email and password");
      return;
    }
    widget.onSignIn == null ? () {} : widget.onSignIn!();
  }

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  bool _emailFocused = false;
  bool _passwordFocused = false;

  void _listenFocus() async {
    _emailFocusNode.addListener(() async {
      VibrateHelper.vibrateSoft();
      setState(() {
        _emailFocused = _emailFocusNode.hasFocus;
      });
    });

    _passwordFocusNode.addListener(() async {
      VibrateHelper.vibrateSoft();
      setState(() {
        _passwordFocused = _passwordFocusNode.hasFocus;
      });
    });
  }

  @override
  void initState() {
    _listenFocus();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                ),
                TextfieldReusable(
                  isFocused: _emailFocused,
                  leadingIcon: Icon(Icons.email),
                  hintText: "Email Address",
                  focusNode: _emailFocusNode,
                  controller: widget.emailController,
                ),
                const Text(
                  "Password",
                ),
                TextfieldReusable(
                  isFocused: _passwordFocused,
                  leadingIcon: Icon(Icons.lock),
                  controller: widget.passwordController,
                  hintText: "Password",
                  focusNode: _passwordFocusNode,
                  obscureText: true,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Checkbox(
                          activeColor: Get.theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: BorderSide(color: Colors.grey),
                          ),
                          value: true,
                          onChanged: (value) {},
                        ),
                        const Text(
                          "Remember me",
                        ),
                      ],
                    )),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        // style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ButtonReusable(
                        backgroundColor: Get.theme.primaryColor,
                        textColor: Colors.white,
                        label: "Sign In",
                        onPressed: () {
                          signIn(context);
                        },
                        isLoading: isShowLoading,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ButtonReusable(
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        label: "Create an Account",
                        onPressed: () {
                          // Get.toNamed(Routes.REGISTER);
                          widget.onCreateAccount == null
                              ? () {}
                              : widget.onCreateAccount!();
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      color: Colors.grey.withOpacity(0.2),
                      height: 1,
                    ),
                    const SizedBox(width: 8),
                    Text("Or sign in with"),
                    const SizedBox(width: 8),
                    Container(
                      width: 100,
                      color: Colors.grey.withOpacity(0.2),
                      height: 1,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.facebook),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.phone),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        isShowLoading
            ? CustomPositioned(
                child: rive.RiveAnimation.asset(
                "assets/RiveAssets/check.riv",
                onInit: (artboard) {
                  rive.StateMachineController controller =
                      getRiveController(artboard);
                  check = controller.findSMI("Check") as rive.SMITrigger;
                  error = controller.findSMI("Error") as rive.SMITrigger;
                  reset = controller.findSMI("Reset") as rive.SMITrigger;
                },
              ))
            : const SizedBox(),
        isShowConfetti
            ? CustomPositioned(
                child: Transform.scale(
                scale: 6,
                child: rive.RiveAnimation.asset(
                  "assets/RiveAssets/confetti.riv",
                  onInit: (artboard) {
                    rive.StateMachineController controller =
                        getRiveController(artboard);
                    confetti = controller.findSMI("Trigger explosion")
                        as rive.SMITrigger;
                  },
                ),
              ))
            : const SizedBox()
      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, required this.child, this.size = 100});
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          Spacer(),
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
