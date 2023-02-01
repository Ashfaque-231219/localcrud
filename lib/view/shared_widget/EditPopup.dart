import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdbcrud/bloc/user_bloc/user_bloc.dart';
import 'package:localdbcrud/bloc/user_bloc/user_state.dart';
import 'package:localdbcrud/database/student_dao/student_database.dart';
import 'package:localdbcrud/helper/utils/utils.dart';
import 'package:localdbcrud/view/shared_widget/custom_raised_button.dart';

import '../../bloc/user_bloc/user_event.dart';
import 'custom_label.dart';
import 'custom_text_field.dart';

class EditPopup extends StatefulWidget {
  EditPopup(
    this.id, {
    Key? key,
  }) : super(key: key);
  final int? id;

  @override
  _EditPopupState createState() => _EditPopupState();
}

class _EditPopupState extends State<EditPopup> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  File? _image;

  triggerUserEvent(UserEvent event) {
    context.read<UserBloc>().add(event);
  }

  @override
  void initState() {
    triggerUserEvent(GetStudentById(context: context, id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var id = widget.id;
    return Dialog(
      backgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 16,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return contentEmailBox(context, state.studentDetails?.image.toString() ?? '', state.studentDetails?.name.toString() ?? '',
              state.studentDetails?.contactNo.toString() ?? '', state.studentDetails?.address, id);
        },
      ),
    );
  }

  contentEmailBox(BuildContext context, String? image, String? userName, String? contact, String? address, int? id) {
    _nameController.text = userName.toString();
    _addressController.text = address.toString();
    _contactController.text = contact.toString();

    return SingleChildScrollView(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomLabel(
                text: 'Update Your Details',
                size: 18,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 40,
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: image != null && _image == null
                                ? Image.file(
                                    File(image.toString() ?? ''),
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    _image!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
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
                height: 12,
              ),
              CustomTextField(
                onTextChanged: _nameController,
                validator: (String? value) {
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextField(
                onTextChanged: _contactController,
                validator: (String? value) {
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextField(
                onTextChanged: _addressController,
                validator: (String? value) {
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              CustomRaisedButton(
                text: 'Update',
                color: Colors.blue,
                onpressed: () {
                  triggerUserEvent(UpdateStudentEventById(
                      context: context, name: _nameController.text, contact: _contactController.text, address: _addressController.text, id: id,image: _image != null ? _image?.path.toString():image));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
