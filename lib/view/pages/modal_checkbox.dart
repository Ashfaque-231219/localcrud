import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalCheckbox extends StatefulWidget {
  const ModalCheckbox({Key? key}) : super(key: key);

  @override
  State<ModalCheckbox> createState() => _ModalCheckboxState();
}

class _ModalCheckboxState extends State<ModalCheckbox> {
  final Modal allChecked = Modal(
    title: 'All Checked',
  );
  final checkboxList = [
    Modal(title: 'Check Box1'),
    Modal(title: 'Check Box2'),
    Modal(title: 'Check Box3'),
    Modal(title: 'Check Box4'),
    Modal(title: 'Check Box5'),
    Modal(title: 'Check Box6'),
    Modal(title: 'Check Box7'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Single checkbox and Multiple Checkbox'),
        ),
        body: ListView(
          children: [
            ListTile(
              onTap: () => onAllCheckClicked(allChecked),
              leading: Checkbox(
                value: allChecked.value,
                onChanged: (value) {
                  onAllCheckClicked(allChecked);
                },
              ),
              title: Text(allChecked.title.toString()),
            ),
            Divider(thickness: 3, color: Colors.grey),
            ...checkboxList
                .map(
                  (item) => ListTile (
                    onTap: () => onCheckItemClick(item),
                    leading: Checkbox(
                      value: item.value,
                      onChanged: (value) {
                      var data =   onCheckItemClick(item);
                      print("The data is $data");
                      },
                    ),
                    title: Text(item.title.toString()),
                  ),
                )
                .toList()
          ],
        ));
  }

  onAllCheckClicked(Modal modal) {
    setState(() {
      allChecked.value = !allChecked.value;
    });
  }

  onCheckItemClick(Modal modal) {
    setState(() {
      allChecked.value = !allChecked.value;
    });
  }
}

class Modal {
  final String? title;
  bool value;

  Modal({
    this.value = false,
    this.title,
  });
}
