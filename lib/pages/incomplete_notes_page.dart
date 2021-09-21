import 'package:flutter/material.dart';
import 'package:to_do_list/db/database.dart';
import 'package:to_do_list/models/note.dart';
import 'package:to_do_list/pages/edit_note.dart';
import 'package:to_do_list/widgets/bottom_nav_bar.dart';
import 'package:intl/intl.dart';

class InCompleteNotesPage extends StatefulWidget {
  @override
  _InCompleteNotesPageState createState() => _InCompleteNotesPageState();
}

class _InCompleteNotesPageState extends State<InCompleteNotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: BottomNavBar(),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : notes.isEmpty
                  ? Text(
                      'No Notes',
                      style: TextStyle(color: Color(0xFF222B45), fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => AddEditNotePage(
                        check: 'Thêm ghi chú',
                      )),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("InComplete Task",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.black,
                    )),
              ),
              listViewTask(),
            ],
          ),
        ),
      );

  listViewTask() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          if (note.isComplete == false) {
            return GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddEditNotePage(
                    note: note,
                    check: 'Cập nhật ghi chú',
                  ),
                ));

                refreshNotes();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(10),
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 15),
                      blurRadius: 10,
                      spreadRadius: -13,
                      color: Colors.black54,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            DateFormat.yMMMd().format(note.createdTime),
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          SizedBox(height: 4),
                          Text(
                            note.title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Checkbox(
                        value: note.isComplete,
                        onChanged: (value) => {
                          updateNote(note, value!, index),
                          refreshNotes(),
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Future updateNote(Note note, bool value, int index) async {
    final note = notes[index].copy(
      isComplete: value,
      title: notes[index].title,
      description: notes[index].description,
    );

    await NotesDatabase.instance.update(note);
  }
}
