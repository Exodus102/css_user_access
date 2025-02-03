import 'package:css_website_access/pages/login/login-contents/decodebase64image.dart';
import 'package:css_website_access/pages/login/login-contents/terms_of_services_and_privacy_policy.dart';
import 'package:css_website_access/services/login-services/login_password_services.dart';
import 'package:css_website_access/widgets/custom_button_login.dart';
import 'package:css_website_access/widgets/custom_checkbox.dart';
import 'package:css_website_access/widgets/custom_textbutton_login.dart';
import 'package:css_website_access/widgets/custom_textfield_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPassword extends StatefulWidget {
  final double width;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final String? email;
  const LoginPassword({
    super.key,
    required this.width,
    required this.onNext,
    required this.onBack,
    this.email,
  });

  @override
  State<LoginPassword> createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
  bool isPasswordVisible = false;
  String? name;
  bool isLoading = true;
  String? imageBase64;

  @override
  void initState() {
    super.initState();
    fetchName();
  }

  Future<void> fetchName() async {
    final email = widget.email;
    if (email != null && email.isNotEmpty) {
      final authService = LoginPasswordServices();
      try {
        final userData = await authService.fetchUserData(email);
        setState(() {
          if (userData != null) {
            name = userData['name'];
            imageBase64 = userData['image'];
          } else {
            name = "User not found";
            imageBase64 = null;
          }
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          name = "Failed to fetch data";
          imageBase64 = null;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        name = "Invalid email";
        isLoading = false;
      });
    }
  }

  void onBack() {
    widget.onBack();
  }

  void onNext() {
    widget.onNext();
  }

  void showPassword(bool isChecked) {
    setState(() {
      isPasswordVisible = isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7F9),
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F7F9),
        title: IconButton(
          onPressed: onBack,
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF064089),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            left: widget.width * 0.1,
            right: widget.width * 0.1,
            bottom: 60,
          ),
          child: Column(
            children: [
              SizedBox(
                height: widget.width * 0.09,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("svg/Logo.svg"),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "URSatisfaction",
                        style: TextStyle(
                          height: 1,
                          color: Color(0xFF064089),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "We comply so URSatisfy",
                        style: TextStyle(
                          height: 1,
                          color: Color(0xFF1E1E1E),
                          fontSize: 15,
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: widget.width * 0.05,
              ),
              //picture here
              isLoading
                  ? CircularProgressIndicator()
                  : decodeBase64Image(imageBase64),
              SizedBox(
                height: widget.width * 0.05,
              ),
              Text(
                isLoading ? "Loading..." : "Welcome, ${name ?? widget.email}",
                style: TextStyle(
                  color: Color(0xFF064089),
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              CustomeTextButtonLoginPassword(
                onPressed: onBack,
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextfieldLogin(
                label: "Password",
                isObscure: !isPasswordVisible,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCheckbox(
                    isChecked: isPasswordVisible,
                    onChanged: showPassword,
                  ),
                  CustomTextbuttonLogin(
                    label: "Forgot Password",
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CustomButtonLogin(
                  label: "Next",
                  width: widget.width * 0.2,
                  onPressed: onNext,
                ),
              ),
              Spacer(),
              TermsOfServicesAndPrivacyPolicy(),
            ],
          ),
        ),
      ),
    );
  }
}
