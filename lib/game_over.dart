import 'game_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GameOver extends StatelessWidget {
  final int score;

  const GameOver({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(222, 245, 191, 1),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Game Over',
                style: TextStyle(
                  color: Color.fromRGBO(0, 72, 22, 1),
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50.0),
              Text(
                'Score: $score',
                style: const TextStyle(
                    color: Color.fromRGBO(0, 72, 22, 1),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50.0),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => GamePage(),
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
                        FontAwesomeIcons.refresh,
                        color: Color.fromRGBO(0, 72, 22, 1),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Try Again",
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
            ],
          ),
        ),
      ),
    );
  }
}
