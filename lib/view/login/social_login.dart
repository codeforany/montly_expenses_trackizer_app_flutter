import 'package:flutter/material.dart';
import 'package:trackizer/view/login/sign_up_view.dart';

import '../../common/color_extension.dart';
import '../../common_widget/secondary_boutton.dart';

class SocialLoginView extends StatefulWidget {
  const SocialLoginView({super.key});

  @override
  State<SocialLoginView> createState() => _SocialLoginViewState();
}

class _SocialLoginViewState extends State<SocialLoginView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
     backgroundColor: TColor.gray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/img/app_logo.png",
                  width: media.width * 0.5, fit: BoxFit.contain),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/img/apple_btn.png"),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/apple.png",
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Sign up with Apple",
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/img/google_btn.png"),
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4))
                      ]),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/google.png",
                        width: 15,
                        height: 15,
                        color: TColor.gray,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Sign up with Google",
                        style: TextStyle(
                            color: TColor.gray,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/img/fb_btn.png"),
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue.withOpacity(0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 4))
                      ]),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/fb.png",
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Sign up with Facebook",
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "or",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.white, fontSize: 14),
              ),
              const SizedBox(
                height: 25,
              ),
              SecondaryButton(
                title: "Sign up with E-mail",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpView()));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "By registering, you agree to our Terms of Use. Learn how we collect, use and share your data.",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
