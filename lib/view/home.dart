import 'package:flutter/material.dart';
import 'package:note_appv2/components/costumes.dart';
import 'package:note_appv2/components/theme_collors.dart';
import 'package:note_appv2/controller/note_controller.dart';
import 'package:note_appv2/model/note_model.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool isGrid = false;
  void changeView() {
    setState(() {
      isGrid = !isGrid;
    });
    //Navigator.of(context).pop();
  }

  void openDrawer() {
    key.currentState?.openDrawer();
  }

  void readNotes() {
    context.read<NoteController>().readNotes();
  }

  @override
  void initState() {
    readNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Note> currentNotes = context.watch<NoteController>().currentNotes;
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
              text: 'Notes.',
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
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CostumeSearchBar(
                      onSubmitted: (String searchString) {
                        context.read<NoteController>().searchIsar(searchString);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CostumeBuilder(isGrid, currentNotes)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
