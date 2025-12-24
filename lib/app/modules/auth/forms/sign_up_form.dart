import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;
import '../../../components/button_reusable.dart';
import '../../../components/textfield_reusable.dart';
import '../../../utils/functions/function_helper.dart';
import '../../../utils/helper/vibrate_helper.dart';

class SignUpForm extends StatefulWidget {
  final Function()? onSignIn;
  final ValueChanged onClosed;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  SignUpForm({
    super.key,
    this.onSignIn,
    required this.onClosed,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<SignUpForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignUpForm> {
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

  void signup(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      showIOSDialog(context,
          title: "Message", content: "Please enter email and password");
      return;
    }
    // setState(() {
    //   isShowLoading = true;
    //   isShowConfetti = true;
    // });
    // // request to the server attempt login
    // Future.delayed(Duration(seconds: 1), () {
    //   if (_formKey.currentState!.validate()) {
    //     // show success
    //     check.fire();
    //     Future.delayed(const Duration(seconds: 2), () {
    //       setState(() {
    //         isShowLoading = false;
    //       });
    //       confetti.fire();
    //     });
    //   } else {
    //     error.fire();
    //     Future.delayed(Duration(seconds: 2), () {
    //       setState(() {
    //         isShowLoading = false;
    //       });
    //     });
    //   }
    // });
  }

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  bool _emailFocused = false;
  bool _passwordFocused = false;
  bool _confirmPasswordFocused = false;

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

    _passwordFocusNode.addListener(() async {
      VibrateHelper.vibrateSoft();
      setState(() {
        _confirmPasswordFocused = _confirmPasswordFocusNode.hasFocus;
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

  void onSignUp() async {
    if (widget.emailController.text.isEmpty ||
        widget.passwordController.text.isEmpty ||
        widget.passwordController.text.isEmpty) {
      showIOSDialog(context,
          title: "Error", content: "Please enter email and password");
      return;
    }
    widget.onSignIn!();
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
                  controller: widget.emailController,
                  focusNode: _emailFocusNode,
                ),

                const Text(
                  "Password",
                ),
                TextfieldReusable(
                  hintText: "Password",
                  controller: widget.passwordController,
                  focusNode: _passwordFocusNode,
                  leadingIcon: Icon(Icons.lock),
                  isFocused: _passwordFocused,
                ),
                const Text(
                  "Confirm Password",
                ),

                SizedBox(
                  height: 20,
                ),
                ButtonReusable(
                  label: "Sign Up",
                  onPressed: () {
                    onSignUp();
                    // showSignupDialog(context, onClosed: widget.onClosed);
                  },
                ),
                //already have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Sign In"),
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
