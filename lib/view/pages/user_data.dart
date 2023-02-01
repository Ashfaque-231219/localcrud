import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdbcrud/bloc/user_bloc/user_bloc.dart';
import 'package:localdbcrud/bloc/user_bloc/user_event.dart';
import 'package:localdbcrud/bloc/user_bloc/user_state.dart';
import 'package:localdbcrud/view/shared_widget/loading_widget.dart';

import '../../helper/utils/utils.dart';
import '../shared_widget/CustomDialog.dart';
import '../shared_widget/custom_label.dart';
import '../shared_widget/custom_raised_button.dart';
import '../shared_widget/custom_text_field.dart';

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  triggerUserEvent(insertUser event) {
    context.read<UserBloc>().add(event);
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  File? _image;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("User Details"),
          ),
          body: LoadingWidget(
            status: state.stateStatus,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CustomLabel(
                        text: 'Please Add All your Details',
                        size: 20,
                        fontWeight: FontWeight.w800,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(120.0),
                                    child: _image != null
                                        ? Image.file(
                                            _image!,
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(
                                            Icons.person,
                                            size: 100,
                                          ))),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              left: 65,
                              child: GestureDetector(
                                  onTap: () async {
                                    print("This is Clickable ");
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext bc) {
                                          return SafeArea(
                                            child: SizedBox(
                                              child: Wrap(
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: () async {
                                                      var filePicked = await pickImage();
                                                      print("The selected image is $filePicked");
                                                      if (filePicked != null) {
                                                        setState(() async {
                                                          if (filePicked is File) {
                                                            _image = filePicked;
                                                            setState(() {});
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: ListTile(leading: const Icon(Icons.photo_library), title: const Text('Photo Library')),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () async {
                                                        var filePicked = await pickCImage();
                                                        print("The selected image is $filePicked");
                                                        if (filePicked != null) {
                                                          setState(() async {
                                                            if (filePicked is File) {
                                                              _image = filePicked;
                                                              setState(() {});
                                                            }
                                                          });
                                                        }
                                                      },
                                                      child: ListTile(leading: const Icon(Icons.photo_camera), title: const Text('Camera'))),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.red,
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.white,
                                        size: 20,
                                      )))),
                        ],
                      ),
                      SizedBox(
                        height: 20,
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
                        hintText: 'Name',
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      CustomTextField(
                        onTextChanged: _addressController,
                        validator: (String? value) {
                          return null;
                        },
                        labelText: 'Address',
                        hintText: 'Address',
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      CustomTextField(
                        onTextChanged: _contactController,
                        validator: (String? value) {
                          return null;
                        },
                        labelText: 'Contact No',
                        hintText: 'Contact No',
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      CustomRaisedButton(
                        onpressed: () async {
                          // throw Exception ("This is a test exception crash");
                          // FirebaseCrashlytics.instance.crash();
                          // if (_formKey.currentState!.validate()) {
                          //   tr
                          // }
                          if (checkUploads()) {
                            triggerUserEvent(insertUser(
                                username: _nameController.text,
                                addresss: _addressController.text,
                                contactNo: _contactController.text,
                                context: context,
                                image: _image?.path.toString()));
                          }
                        },
                        color: Colors.red,
                        text: 'Save',
                        size: 14,
                        textcolor: Colors.white,
                        height: height * 0.07,
                        width: width * 0.97,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool checkUploads() {
    String validate = '';
    if (_image == null) {
      validate = '$validate \u2022 Image.\n';
    }

    if (_nameController.text.isEmpty) {
      validate = '$validate \u2022 Name.\n';
    }
    if (_addressController.text.isEmpty) {
      validate = '$validate \u2022 Address.\n';
    }
    if (_contactController.text.isEmpty) {
      validate = '$validate \u2022  ContactNo.\n';
    }

    if (validate.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            text: 'Following field(s) are required: \n$validate',
          );
        },
      );
      return false;
    } else {
      return true;
    }
  }
}
