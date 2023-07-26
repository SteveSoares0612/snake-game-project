import 'dart:async';
import 'dart:math';

import 'game_over.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  int _playerScore = 0;
  bool _hasStarted = false;
  late Animation _snakeAnimation;
  late AnimationController _snakeController;
  List _snake = [404, 405];
  final int _noOfSquares = 500;
  final Duration _duration = Duration(milliseconds: 250);
  final int _squareSize = 20;
  String _currentSnakeDirection = '';
  int _snakeFoodPosition = 0;
  Random _random = new Random();

  @override
  void initState() {
    super.initState();
    _setUpGame();
  }

  void _setUpGame() {
    _playerScore = 0;
    _currentSnakeDirection = 'RIGHT';
    _hasStarted = true;
    do {
      _snakeFoodPosition = _random.nextInt(_noOfSquares);
    } while (_snake.contains(_snakeFoodPosition));
    _snakeController = AnimationController(vsync: this, duration: _duration);
    _snakeAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _snakeController);
  }

  void _gameStart() {
    Timer.periodic(Duration(milliseconds: 250), (Timer timer) {
      _updateSnake();
      if (_hasStarted) timer.cancel();
    });
  }

  bool _gameOver() {
    for (int i = 0; i < _snake.length - 1; i++)
      if (_snake.last == _snake[i]) return true;
    return false;
  }

  void _updateSnake() {
    if (!_hasStarted) {
      setState(() {
        _playerScore = (_snake.length - 2) * 100;
        switch (_currentSnakeDirection) {
          case 'DOWN':
            if (_snake.last > _noOfSquares)
              _snake.add(
                  _snake.last + _squareSize - (_noOfSquares + _squareSize));
            else
              _snake.add(_snake.last + _squareSize);
            break;
          case 'UP':
            if (_snake.last < _squareSize)
              _snake.add(
                  _snake.last - _squareSize + (_noOfSquares + _squareSize));
            else
              _snake.add(_snake.last - _squareSize);
            break;
          case 'RIGHT':
            if ((_snake.last + 1) % _squareSize == 0)
              _snake.add(_snake.last + 1 - _squareSize);
            else
              _snake.add(_snake.last + 1);
            break;
          case 'LEFT':
            if ((_snake.last) % _squareSize == 0)
              _snake.add(_snake.last - 1 + _squareSize);
            else
              _snake.add(_snake.last - 1);
        }

        if (_snake.last != _snakeFoodPosition)
          _snake.removeAt(0);
        else {
          do {
            _snakeFoodPosition = _random.nextInt(_noOfSquares);
          } while (_snake.contains(_snakeFoodPosition));
        }

        if (_gameOver()) {
          setState(() {
            _hasStarted = !_hasStarted;
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => GameOver(score: _playerScore)));
        }
      });
    }
  }

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
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Color.fromRGBO(0, 72, 22, 1),
            ),
            centerTitle: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Score: $_playerScore',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Color.fromRGBO(0, 72, 22, 1),
                      fontWeight: FontWeight.bold),
                ),
              ))
            ],
          ),
          body: Center(
            child: GestureDetector(
              onVerticalDragUpdate: (drag) {
                if (drag.delta.dy > 0 && _currentSnakeDirection != 'UP')
                  _currentSnakeDirection = 'DOWN';
                else if (drag.delta.dy < 0 && _currentSnakeDirection != 'DOWN')
                  _currentSnakeDirection = 'UP';
              },
              onHorizontalDragUpdate: (drag) {
                if (drag.delta.dx > 0 && _currentSnakeDirection != 'LEFT')
                  _currentSnakeDirection = 'RIGHT';
                else if (drag.delta.dx < 0 && _currentSnakeDirection != 'RIGHT')
                  _currentSnakeDirection = 'LEFT';
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  itemCount: _squareSize + _noOfSquares,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _squareSize),
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Container(
                        color: Colors.transparent,
                        padding: _snake.contains(index)
                            ? EdgeInsets.all(1)
                            : EdgeInsets.all(0),
                        child: ClipRRect(
                          borderRadius: index == _snakeFoodPosition ||
                                  index == _snake.last
                              ? BorderRadius.circular(7)
                              : _snake.contains(index)
                                  ? BorderRadius.circular(2.5)
                                  : BorderRadius.circular(1),
                          child: Container(
                            color: _snake.contains(index)
                                ? Colors.black
                                : index == _snakeFoodPosition
                                    ? Colors.red
                                    : Colors.transparent,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.85,
          left: MediaQuery.of(context).size.width * 0.3,
          right: MediaQuery.of(context).size.width * 0.3,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.35,
            child: ElevatedButton(
              onPressed: () {
                print("play game");
                setState(() {
                  if (_hasStarted)
                    _snakeController.forward();
                  else
                    _snakeController.reverse();
                  _hasStarted = !_hasStarted;
                  _gameStart();
                });
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _hasStarted
                        ? FontAwesomeIcons.play
                        : FontAwesomeIcons.pause,
                    color: Color.fromRGBO(0, 72, 22, 1),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    _hasStarted ? 'Play' : 'Pause',
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
    );
  }
}
