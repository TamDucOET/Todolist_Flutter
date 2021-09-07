import 'package:flutter/material.dart';
import 'package:to_do_list/pages/complete_notes_page.dart';
import 'package:to_do_list/pages/home.dart';
import 'package:to_do_list/pages/incomplete_notes_page.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.checklist,
                  size: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015),
                )
              ],
            ),
          ),
          FlatButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CompleteNotesPage()),
              );
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.check_box_outlined,
                  size: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  'Complete',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015),
                )
              ],
            ),
          ),
          FlatButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => InCompleteNotesPage()),
              );
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.check_box_outline_blank_rounded,
                  size: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  'InComplete',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
