import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isComplete;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedComplete;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key? key,
    this.isComplete = false,
    this.title = '',
    this.description = '',
    required this.onChangedComplete,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              buildTitle(),
              SizedBox(height: 25),
              buildDescription(),
              SizedBox(height: 30),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: 'Nhập tên ghi chú',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'Tên ghi chú không thể để trống'
            : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: 'Nhập nội dung ghi chú',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        onChanged: onChangedDescription,
      );
}
