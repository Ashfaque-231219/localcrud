import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdbcrud/helper/constants/asset_const.dart';
import 'package:localdbcrud/view/shared_widget/custom_label.dart';
import 'package:localdbcrud/view/shared_widget/custom_password_filed.dart';

import '../shared_widget/custom_raised_button.dart';
import '../shared_widget/custom_text_field.dart';

class SocialLoginPage extends StatefulWidget {
  const SocialLoginPage({Key? key}) : super(key: key);

  @override
  State<SocialLoginPage> createState() => _SocialLoginPageState();
}

class _SocialLoginPageState extends State<SocialLoginPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  List<bool> _isChecked = [false, false, false];
  List language = [
    'Abkhazian',
    'Afar',
    'Afrikaans',
  ];
  String selectedBhasaa = 'India';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                          child: Container(
                            height: 300,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Icon(
                                    Icons.horizontal_rule_outlined,
                                    size: 40,
                                    color: Colors.black26,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.cancel),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomLabel(
                                      text: 'Select your language',
                                      size: 20,
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Card(
                                  elevation: 5,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: language.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 13, right: 13),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomLabel(text: '${language[index]}'),
                                            Checkbox(
                                                shape: CircleBorder(),
                                                checkColor: Colors.white,
                                                splashRadius: 18,
                                                value: _isChecked[index],
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (_isChecked.contains(true)) {
                                                      _isChecked[_isChecked.indexOf(true)] = false;
                                                    }
                                                    _isChecked[index] = value!;
                                                    selectedBhasaa = language[index];
                                                    Navigator.pop(context);
                                                  });
                                                }),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  ).then((value) => setState(() {}));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Align(alignment: Alignment.center, child: CustomLabel(text: '${selectedBhasaa}')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      ImageConst.splashImage,
                      height: 65,
                      width: 65,
                    )),
              ),
              SizedBox(
                height: 50,
              ),
              CustomTextField(
                onTextChanged: _nameController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please Enter The name';
                  }
                  return null;
                },
                labelText: 'Name',
                hintText: 'Username, email address or mobile num...',
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomPasswordField(
                onTextChanged: _passController,
                validator: (String? value) {
                  return null;
                },
                // labelText: 'Password',
                hintText: 'Password',
                valueChanged: (String? value) {},
              ),
              SizedBox(
                height: 15,
              ),
              CustomRaisedButton(
                onpressed: () {},
                text: 'Log in',
                height: 50,
                width: double.infinity,
                textcolor: Colors.white,
                sidecolor: Colors.blue,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
