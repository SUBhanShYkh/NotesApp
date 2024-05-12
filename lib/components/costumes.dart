// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_appv2/components/theme.dart';
import 'package:note_appv2/components/theme_collors.dart';
import 'package:note_appv2/model/note_model.dart';
import 'package:note_appv2/view/add_note.dart';
import 'package:note_appv2/view/home.dart';
import 'package:note_appv2/view/note_view.dart';
import 'package:provider/provider.dart';

// ... CostumeGridTile Strats
// ignore: must_be_immutable
class CostumeGridTile extends StatelessWidget {
  CostumeGridTile({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.onTap,
  });

  final String title;
  final String description;
  final DateTime date;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: GridTile(
        child: Card(
          elevation: 5,
          color: UiColors.sec(context),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${date.day}/${date.month}/${date.year}",
                  style: TextStyle(
                    color: UiColors.inpm(context),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: UiColors.inpm(context),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: UiColors.inpm(context),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ... CostumeGridTile Ends

// ... CostumeListTile Strats
// ignore: must_be_immutable
class CostumeListTile extends StatelessWidget {
  CostumeListTile({
    super.key,
    required this.title,
    required this.date,
    required this.onTap,
  });
  void Function() onTap;
  final String title;
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: UiColors.sec(context),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.5,
              blurRadius: 0.5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: UiColors.inpm(context),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  " ${date.day}/${date.month}/${date.year}",
                  style: TextStyle(
                    color: UiColors.inpm(context),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_circle_right_outlined,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}

// ... CostumeListTile Ends
// ... CostumeSearchBar Starts
// ignore: must_be_immutable
class CostumeSearchBar extends StatelessWidget {
  final void Function(String) onSubmitted;
  const CostumeSearchBar({
    super.key,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      onSubmitted: onSubmitted,
      trailing: const [
        Padding(
          padding: EdgeInsets.all(10),
          child: Icon(Icons.search),
        )
      ],
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
// ... CostumeSearchBar Ends

// ... CostumeBuilder with Conditions Starts
// ignore: non_constant_identifier_names
Widget CostumeBuilder(bool isGrid, List<Note> notes) {
  if (isGrid) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final _notes = notes[index];
        return CostumeGridTile(
          title: _notes.title,
          description: _notes.description,
          date: _notes.dateTime,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NoteView(
                  note: [_notes],
                ),
              ),
            );
          },
        );
      },
    );
  }
  return ListView.builder(
    reverse: true,
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    itemCount: notes.length,
    itemBuilder: (context, index) {
      final _notes = notes[index];
      return CostumeListTile(
        title: _notes.title,
        date: _notes.dateTime,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteView(
                note: [_notes],
              ),
            ),
          );
        },
      );
    },
  );
}

// ... CostumeBuilder with Conditions Ends
// ... TopTitle Starts
class TopTitle extends StatelessWidget {
  final String text;
  final double size;
  const TopTitle({
    super.key,
    required this.text,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: UiColors.inpm(context),
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// ... TopTitle Ends
// ... CostumeDrawerTile Starts
// ignore: must_be_immutable
class CostumeDrawerTile extends StatelessWidget {
  final IconData leadingIcon;
  final IconData trailingIcon;
  final Widget title;
  void Function() onTap;
  CostumeDrawerTile({
    super.key,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        //contentPadding: EdgeInsets.only(left: 25, right: 25),
        titleAlignment: ListTileTitleAlignment.center,
        title: title,
        leading: Icon(
          leadingIcon,
          color: UiColors.inpm(context),
        ),
        // trailing: Icon(
        //   trailingIcon,
        //   color: UiColors.inpm(context),
        // ),
        trailing: FaIcon(
          trailingIcon,
          color: UiColors.inpm(context),
        ),
      ),
    );
  }
}
// ... CostumeDrawerTile Ends

// ... Costume Drawer Starts
// ignore: non_constant_identifier_names
Drawer CostumeDrawer(
    BuildContext context, bool isGrid, void Function() changeView) {
  return Drawer(
    backgroundColor: UiColors.bg(context),
    elevation: 5,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DrawerHeader(
            child: Icon(
          Icons.tips_and_updates_rounded,
          size: 60,
          color: Colors.yellow.shade600,
        )),
        const SizedBox(
          height: 20,
        ),
        CostumeDrawerTile(
          leadingIcon: Icons.home,
          trailingIcon: Icons.keyboard_arrow_right_rounded,
          title: const TopTitle(text: "Home", size: 20),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
          },
        ),
        CostumeDrawerTile(
          leadingIcon: Icons.add_circle,
          trailingIcon: Icons.keyboard_arrow_right_rounded,
          title: const TopTitle(text: "Add Note", size: 20),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddNote(),
              ),
            );
          },
        ),
        // is Grid Starts
        CostumeDrawerTile(
          leadingIcon: isGrid ? Icons.list_sharp : Icons.grid_view_sharp,
          trailingIcon:
              isGrid ? FontAwesomeIcons.toggleOn : FontAwesomeIcons.toggleOff,
          title: TopTitle(text: isGrid ? "ListView" : "GridView", size: 20),
          onTap: changeView,
        ),
        // is Grid Ends
        // is dark Starts
        CostumeDrawerTile(
          leadingIcon:
              Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                  ? Icons.wb_sunny_sharp
                  : Icons.nightlight_rounded,
          trailingIcon:
              Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                  ? FontAwesomeIcons.toggleOn
                  : FontAwesomeIcons.toggleOff,
          title: TopTitle(
              text:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                      ? "Light Mode"
                      : "Dark Mode",
              size: 20),
          onTap: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
        ),
        // is dark Ends
      ],
    ),
  );
}

// ... Costume Drawer Ends
// ... CostumeTextField Starts
// ignore: must_be_immutable
class CostumeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  TextInputType keyboardType;
  int? maxLines;
  int? maxLength;
  CostumeTextField({
    super.key,
    required this.controller,
    required this.text,
    required this.keyboardType,
    required this.maxLines,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(
          color: UiColors.sec(context),
          fontSize: 20,
        ),
        floatingLabelStyle: TextStyle(
          color: UiColors.inpm(context),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: UiColors.sec(context),
            width: 2,
          ),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: UiColors.inpm(context),
            width: 4,
          ),
          //gapPadding: 10,
        ),
        //focusColor: UiColors.pm(context),
      ),
    );
  }
}

// ... CostumeTextField Ends
