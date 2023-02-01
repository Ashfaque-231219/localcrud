import 'package:flutter/material.dart';

import 'custom_label.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    required this.items,
    required this.value,
    this.onChangeCall,
    Key? key,
  }) : super(key: key);

  final List<dynamic> items;
  final String? value;
  final Function? onChangeCall;


  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: const Text("Report Type"),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      icon: const Icon(
        Icons.keyboard_arrow_down_outlined,
      ),
      items: widget.items.map((val) {
        return DropdownMenuItem(
            value: val,
            child: CustomLabel(
              text: val,
            ));
      }).toList(),
      onChanged: (value){
        if(widget.onChangeCall!=null)
        widget.onChangeCall!(value);
      },
    );
  }
}
