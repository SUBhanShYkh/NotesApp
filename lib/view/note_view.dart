// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:note_appv2/components/costumes.dart';
import 'package:note_appv2/components/theme_collors.dart';
import 'package:note_appv2/controller/note_controller.dart';
import 'package:note_appv2/model/note_model.dart';
import 'package:note_appv2/view/home.dart';
import 'package:note_appv2/view/update_note.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class NoteView extends StatelessWidget {
  final List<Note> note;
  const NoteView({
    super.key,
    required this.note,
  });
  @override
  Widget build(BuildContext context) {
    String? _title;
    String? _des;
    DateTime? _datetime;
    int? id;
    note.forEach((element) {
      _title = element.title;
      id = element.id;
      _des = element.description;
      _datetime = element.dateTime;
    });
    return Scaffold(
      backgroundColor: UiColors.bg(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        //automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
            child: Row(
              children: [
                TopTitle(
                  text: _title!,
                  size: 28,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.warning,
                      confirmBtnColor: UiColors.inpm(context),
                      onConfirmBtnTap: () {
                        context.read<NoteController>().deleteNote(id!);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UpdateNote(
                          id: id!,
                          title: _title!,
                          desc: _des!,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: UiColors.pm(context),
                border: Border.all(color: UiColors.pm(context), width: 1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopTitle(
                    text:
                        "${_datetime!.day}/${_datetime!.month}/${_datetime!.year}",
                    size: 16,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TopTitle(
                    text: _des!,
                    size: 18,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
