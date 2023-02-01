import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../helper/constants/asset_const.dart';
import '../shared_widget/custom_raised_button.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool isLoggedIn = false;
  Map userObj = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facebook Login in flutter"),
      ),
      body: isLoggedIn
          ? Column(children: [
              Text(userObj['name']),
              Text(userObj['email']),
              CustomRaisedButton(
                  text: 'Facebook',
                  sidecolor: Colors.red,
                  color: Colors.red,
                  onpressed: () async {
                    FacebookAuth.instance.logOut().then((value) {
                      setState(() {
                        isLoggedIn = false;
                        userObj = {};
                      });
                    });
                  })
            ])
          : Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    FacebookAuth.instance.login(permissions: ["public_profile", "email"]).then((value) {
                      FacebookAuth.instance.getUserData().then((userData) {
                        setState(() {
                          isLoggedIn = true;
                          userObj = userData;
                        });
                      });
                    });
                    print("This is Clickable button");
                  },
                  child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        ImageConst.facebook,
                        height: 50,
                        width: 50,
                      )),
                )
              ],
            ),
    );
  }
}
