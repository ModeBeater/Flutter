part of 'game_bloc.dart';

abstract class GameEvent {}

class StartGame extends GameEvent {
  final int maxRange;
  final int maxAttempts;

  StartGame({required this.maxRange, required this.maxAttempts});
}

class MakeGuess extends GameEvent {
  final int guess;

  MakeGuess({required this.guess});
}

class ResetGame extends GameEvent {}
