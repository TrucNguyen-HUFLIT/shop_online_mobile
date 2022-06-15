
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/constants.dart';
import 'package:shop_online_mobile/common/size_config.dart';

class ShopDropDown extends StatefulWidget {

  List<SelectItem> items;
  Function onSelectItem;
  ShopDropDown({required this.items, required this.onSelectItem});

  @override
  State<ShopDropDown> createState() => _ShopDropDownState();
}

class _ShopDropDownState extends State<ShopDropDown> {
  var dropdownValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<SelectItem>(
      value: dropdownValue,
      menuMaxHeight: 150,
      elevation: 16,
      underline: Container(
        height: 1,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (dynamic newValue) {
        widget.onSelectItem(newValue!);
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: widget.items
          .map<DropdownMenuItem<SelectItem>>((SelectItem selectedItem) {
        return DropdownMenuItem<SelectItem>(
          value: selectedItem,
          child: Text(selectedItem.value.toString(), style: TextStyle(fontSize: getProportionateScreenWidth(16),
            fontWeight: FontWeight.w600,
            color: Colors.amber,),),
        );
      }).toList(),
    );
  }
}

class SelectItem {
  int key;
  dynamic value;

  SelectItem(this.key, this.value);
}