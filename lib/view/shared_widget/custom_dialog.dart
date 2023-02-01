import 'package:flutter/material.dart';
import 'package:localdbcrud/view/shared_widget/custom_raised_button.dart';

import '../../helper/constants/color_const.dart';


class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key, this.text = ''}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(text),
          ),
          CustomRaisedButton(
              text: 'Ok',
              textcolor: Colors.red,
              height: 40,
              width: 65,
              color: Colors.red,
              sidecolor:Colors.red ,
              onpressed: () {
                Navigator.pop(context, true);
              }),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
