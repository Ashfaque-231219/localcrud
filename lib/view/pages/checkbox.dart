import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdbcrud/view/shared_widget/custom_label.dart';

class CheckboxesTypes extends StatefulWidget {
  const CheckboxesTypes({Key? key}) : super(key: key);

  @override
  State<CheckboxesTypes> createState() => _CheckboxesTypesState();
}

class _CheckboxesTypesState extends State<CheckboxesTypes> {
  List<String> items = ['item1', 'item2', 'item3', 'item4'];
  List<bool> _checkItems = [false, false, false, false];
  List<bool> _allselected = [true, true, true, true];
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All types of checkboxes"),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  _checkItems = _allselected;

                });
              },
              child: CustomLabel(text: 'Select All checkboxes')),
          ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomLabel(text: '${items[index]}'),
                    SizedBox(
                      width: 20,
                    ),
                    Checkbox(
                        value: _checkItems[index],
                        onChanged: (value) {
                          setState(() {
                            if (_checkItems.contains(true)) {
                              _checkItems[_checkItems.indexOf(true)] = false;
                            }

                            _checkItems[index] = value!;
                          });
                        })
                  ],
                );
              }),
          SizedBox(
            height: 10,
          ),
          CustomLabel(text: 'Radio button in flutter'),
          RadioListTile(
            title: Text("Male"),
            value: "male",
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value.toString();
              });
            },
          ),
          RadioListTile(
            title: Text("Female"),
            value: "female",
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value.toString();
                print("The selected gender is =======>>>> $gender");
              });
            },
          ),
          RadioListTile(
            title: Text("Other"),
            value: "other",
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value.toString();
              });
            },
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile(
                    value: items[index],
                    groupValue: gender,
                    title: Text("${items[index]}"),
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                        print("THe value in select list tile is $gender");
                      });
                    });
              })
        ]),
      ),
    );
  }
}
