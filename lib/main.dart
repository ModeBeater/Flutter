import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/gameLogic/game_bloc.dart';
import 'package:test_project/screens/ResultScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => GameBloc(),
        child: GameScreen(),
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  int _maxRange = 100;
  int _maxAttempts = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Угадай число')),
      body: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          if (state is GameWon) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ResultScreen(gameBloc: BlocProvider.of<GameBloc>(context), result: 'Вы выиграли', title: 'Победа',)),
            );
          } else if (state is GameLost) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ResultScreen(gameBloc: BlocProvider.of<GameBloc>(context), result: 'Вы проиграли', title: 'Поражение',)),
            );
          }
        },
        builder: (context, state) {
          if (state is GameInitial) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Введите диапазон (n)',
                      hintText: '100',
                    ),
                    onChanged: (value) {
                      _maxRange = int.tryParse(value) ?? 100;
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Введите количество попыток (m)',
                      hintText: '10',
                    ),
                    onChanged: (value) {
                      _maxAttempts = int.tryParse(value) ?? 10;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<GameBloc>(context).add(StartGame(maxRange: _maxRange, maxAttempts: _maxAttempts));
                    },
                    child: Text('Начать игру'),
                  ),
                ],
              ),
            );
          } else if (state is GameInProgress) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Попытки: ${state.remainingAttempts}'),
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Введите ваше число',hintText: '1'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      int guess = int.tryParse(_controller.text) ?? 0;
                      BlocProvider.of<GameBloc>(context).add(MakeGuess(guess: guess));
                    },
                    child: Text('Попробовать'),
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

}
