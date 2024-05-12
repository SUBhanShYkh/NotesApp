// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:note_appv2/components/costumes.dart';
import 'package:note_appv2/components/theme_collors.dart';
import 'package:note_appv2/controller/note_controller.dart';
import 'package:note_appv2/view/home.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class UpdateNote extends StatefulWidget {
  final int id;
  final String title;
  final String desc;
  const UpdateNote({
    super.key,
    required this.id,
    required this.title,
    required this.desc,
  });

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titlecontroller = TextEditingController();
    TextEditingController descriptioncontroller = TextEditingController();
    titlecontroller.text = widget.title;
    descriptioncontroller.text = widget.desc;
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
              text: 'Update Note.',
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
                        controller: titlecontroller,
                        text: "Title",
                        keyboardType: TextInputType.name,
                        maxLength: 15,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CostumeTextField(
                        controller: descriptioncontroller,
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
                                titlecontroller.clear();
                                descriptioncontroller.clear();
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
                                if (titlecontroller.text.isNotEmpty &&
                                    descriptioncontroller.text.isNotEmpty) {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.warning,
                                    title: "Are You Sure",
                                    onConfirmBtnTap: () {
                                      context
                                          .read<NoteController>()
                                          .updateNotes(
                                            widget.id,
                                            titlecontroller.text,
                                            descriptioncontroller.text,
                                            DateTime.now(),
                                          );
                                      titlecontroller.clear();
                                      descriptioncontroller.clear();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const Home(),
                                        ),
                                      );
                                    },
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
                              child: const TopTitle(text: "Update", size: 20),
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
