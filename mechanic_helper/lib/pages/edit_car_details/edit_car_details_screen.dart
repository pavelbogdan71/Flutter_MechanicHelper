import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mechanic_helper/pages/services/database_service.dart';

class EditCarDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back)),
            ],
          ),
          SizedBox(height: 10),
          DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              items: ['asd', 'gdf'],
              label: "Menu mode",
              hint: "country in menu mode",
              popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: print,
              selectedItem: "Brazil"),
        ],
      ),
    );
  }
}
