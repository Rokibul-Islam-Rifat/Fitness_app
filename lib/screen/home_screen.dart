import 'dart:convert';

import 'package:fitness_api/modal/exercise_modal.dart';
import 'package:fitness_api/screen/single_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ExerciseModal? exerciseModal;
  List<ExerciseModal> exerciseList = [];
  var fitnessUrl =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR2gsu4SRvRRFkHK8JPTWHZXmaNP0dtpOG6h7ep4zQp7WaamX5S1UaSrc3A;";
  fetchFitnessData() async {
    var response = await http.get(Uri.parse(fitnessUrl));
    var data = jsonDecode(response.body.toString());
    for (var i in data["exercises"]) {
      exerciseModal = ExerciseModal(
          id: i["id"], title: i["title"], image: i["thumbnail"], gif: i["git"]);
      exerciseList.add(exerciseModal!);
    }
    setState(() {});
  }

  @override
  void initState() {
    fetchFitnessData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Exercise App",
          style: _myStyle(
            Colors.greenAccent,
            FontWeight.bold,
            30,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: exerciseList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SinglePage(
                          exerciseModal: exerciseList[index],
                        )));
              },
              child: SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: NetworkImage(
                              "${exerciseList[index].image}",
                            ),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Text(
                                    "${exerciseList[index].title}",
                                    style: _myStyle(
                                      Colors.greenAccent,
                                      FontWeight.bold,
                                      25,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Take part ",
                                      style: _myStyle(
                                        Colors.greenAccent,
                                        FontWeight.bold,
                                        25,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "I got 99 problems, but a bench ain’t one.",
                                    style: _myStyle(
                                      Colors.white,
                                      FontWeight.normal,
                                      18,
                                    ),
                                  ),
                                  Text(
                                    "I do it for great days",
                                    style: _myStyle(
                                      Colors.white,
                                      FontWeight.normal,
                                      18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(top: 18.0),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.greenAccent),
                                    onPressed: () {},
                                    child: Text(
                                      "TRY",
                                      style: _myStyle(
                                        Colors.white,
                                        FontWeight.bold,
                                        18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      backgroundColor: Colors.black,
    );
  }
}

_myStyle(
  Color clr,
  FontWeight fw,
  double size,
) {
  return TextStyle(
    color: clr,
    fontWeight: fw,
    fontSize: size,
  );
}
