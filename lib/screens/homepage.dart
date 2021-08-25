import 'package:flutter/material.dart';
import 'package:todoapp/screens/taskpage.dart';
import 'package:todoapp/widgets.dart';
import 'package:todoapp/database_helper.dart';
import 'package:no_scroll_glow/no_scroll_glow.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        color: Colors.black87,
        //color: Colors.white,

        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      top: 32,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                          spreadRadius: .5,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      width: 60,
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    initialData: [],
                    future: _dbHelper.getTasks(),
                    builder: (context, snapshot) {
                      return ScrollConfiguration(
                        behavior: NoScrollGlowBehavior(),
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Taskpage(
                                      task: snapshot.data[index],
                                    ),
                                  ),
                                ).then(
                                  (value) {
                                    setState(() {});
                                  },
                                );
                              },
                              child: TaskCardWidget(
                                title: snapshot.data[index].title,
                                desc: snapshot.data[index].description,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 24.0,
              right: 0.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Taskpage(
                              task: null,
                            )),
                  ).then((value) {
                    setState(() {});
                  });
                },
                child: Container(
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green.shade700),
                  child: Image(image: AssetImage("assets/images/add_icon.png")),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
