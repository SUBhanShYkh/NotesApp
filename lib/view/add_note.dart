// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:note_appv2/components/costumes.dart';
import 'package:note_appv2/components/theme_collors.dart';
import 'package:note_appv2/controller/note_controller.dart';
import 'package:note_appv2/view/home.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _titlecontroller = TextEditingController();
    final TextEditingController _descriptioncontroller =
        TextEditingController();
    final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    bool isGrid = false;
    void changeView() {
      setState(() {
        isGrid = !isGrid;
      });
      Navigator.of(context).pop();
    }

    void openDrawer() {
      key.currentState?.openDrawer();
    }

    // Define the button style with a background color that changes based on state
    final ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        return UiColors.bg(context);
      }),
      shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
          (Set<MaterialState> states) {
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(5));
      }),
    );

    return Scaffold(
      key: key,
      backgroundColor: UiColors.bg(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),

      // ... Drawer Starts
      drawer: CostumeDrawer(context, isGrid, changeView),
      // ... Drawer Ends
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 5, right: 10),
            child: TopTitle(
              text: 'Add Notes.',
              size: 28,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx > 0) {
                  openDrawer();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: UiColors.pm(context),
                  border: Border.all(color: UiColors.pm(context), width: 1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CostumeTextField(
                        controller: _titlecontroller,
                        text: "Title",
                        keyboardType: TextInputType.name,
                        maxLength: 15,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CostumeTextField(
                        controller: _descriptioncontroller,
                        text: "Description",
                        keyboardType: TextInputType.multiline,
                        maxLength: null,
                        maxLines: null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              style: buttonStyle,
                              onPressed: () {
                                _titlecontroller.clear();
                                _descriptioncontroller.clear();
                              },
                              child: const TopTitle(text: "Clear", size: 20),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextButton(
                              style: buttonStyle,
                              onPressed: () {
                                if (_titlecontroller.text.isNotEmpty &&
                                    _descriptioncontroller.text.isNotEmpty) {
                                  context.read<NoteController>().addNotes(
                                        _titlecontroller.text,
                                        _descriptioncontroller.text,
                                        DateTime.now(),
                                      );
                                  _titlecontroller.clear();
                                  _descriptioncontroller.clear();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const Home(),
                                    ),
                                  );
                                } else {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    showConfirmBtn: false,
                                    title: "Title/Description Are Null",
                                    textColor: UiColors.inpm(context),
                                    backgroundColor: UiColors.pm(context),
                                  );
                                }
                              },
                              child: const TopTitle(text: "Save", size: 20),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
