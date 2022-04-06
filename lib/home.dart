import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/database.dart';
import 'package:todo/taskPage.dart';
import 'package:todo/toDoCard.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:todo/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'models/taskCard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();
  final keyFour = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => ShowCaseWidget.of(context)!.startShowCase([
              keyOne,
            ]));
  }

  DatabaseToDo _dbHelper = DatabaseToDo();

  late final List<TaskCard> reorderableItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          color: Color(0xFFF6F6F6),
          width: double.infinity,
          padding: EdgeInsets.all(25.0),
          // we use Stack to place things above each other
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 32.0,
                        ),
                        child: Image(
                          width: 80.0,
                          height: 80.0,
                          image: AssetImage('assets/logo-1.png'),
                        ),
                      ),
                      Spacer(),
                      // DELETE BUTTON
                      // we use gestureDectector so that we can call onTap function
                      // GestureDetector(
                      //   onTap: () => Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (_) => Language(),
                      //     ),
                      //   ),
                      //   child: Icon(
                      //     Icons.language,
                      //     color: Color(0xff2c0c8a),
                      //     size: 40.0,
                      //   ),
                      // ),
                    ],
                  ),
                  Expanded(
                      child: FutureBuilder<List>(
                    initialData: [],
                    future: _dbHelper.getTasks(),
                    builder: (context, snapshot) {
                      return ReorderableListView.builder(
                        itemCount:
                            snapshot.data == null ? 0 : snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            key: ValueKey(index),
                            onTap: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TaskPage(
                                              task: snapshot.data![index])))
                                  .then((value) {
                                setState(() {});
                                reorderableItems.add(snapshot.data![index]);
                              });
                            },
                            child: ToDoCard(
                              snapshot.data![index].title,
                              snapshot.data![index].description,
                            ),
                          );
                        },
                        onReorder: (int oldIndex, int newIndex) {
                          setState(() {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            final item = reorderableItems.removeAt(oldIndex);
                            reorderableItems.insert(newIndex, item);
                          });
                        },
                      );
                    },
                  )),
                ],
              ),

              // we use positioned to control position of widgets
              Positioned(
                  bottom: 0.0,
                  right: 0.0,

                  // we use gesture Dectector so that we can call onTap function
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowCaseWidget(
                              builder:
                                  Builder(builder: (_) => TaskPage(task: null)),
                            ),
                          )).then((value) {
                        setState(() {});
                      });
                    },
                    child: Showcase(
                      key: keyOne,
                      description: LocaleKeys.addButtonShowCase.trim(),
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Color(0xff2c0c8a),
                          borderRadius: BorderRadius.circular(20.5),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ),
                  )),
            ],
          )),
    ));
  }
}
