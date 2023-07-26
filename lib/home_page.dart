import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'game_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/background.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Image.asset(
            'assets/snakes.png',
            // color: Colors.white,
            repeat: ImageRepeat.repeat,
            opacity: const AlwaysStoppedAnimation(0.3),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // color: CupertinoColors.systemGroupedBackground,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/snake.png',
                    width: 200,
                  ),
                  const SizedBox(height: 50.0),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     elevation: 0,
                  //     backgroundColor: Colors.white,
                  //   ),
                  //   // padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  //   // color: Colors.redAccent,
                  //   onPressed: () {
                  //     Navigator.of(context).push(
                  //         MaterialPageRoute(builder: (context) => GamePage()));
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(15.0),
                  //     child: const Text("Start",
                  //         style: TextStyle(
                  //             color: Color.fromRGBO(0, 72, 22, 1),
                  //             fontSize: 20.0)),
                  //   ),
                  // ),
                  Animate(
                    effects: const [
                      ScaleEffect(duration: Duration(seconds: 1)),
                      FadeEffect(duration: Duration(seconds: 1))
                    ],
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.37,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => GamePage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 1,
                          // backgroundColor: const Color.fromRGBO(220, 26, 34, 1),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          side: const BorderSide(
                            width: 4,
                            color: Color.fromRGBO(0, 72, 22, 1),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.gamepad,
                              color: Color.fromRGBO(0, 72, 22, 1),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Start",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 72, 22, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
