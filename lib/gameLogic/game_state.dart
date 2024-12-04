part of 'game_bloc.dart';

abstract class GameState {}

class GameInitial extends GameState {}

class GameInProgress extends GameState {
  final int remainingAttempts;

  GameInProgress({required this.remainingAttempts});
}

class GameWon extends GameState {}

class GameLost extends GameState {
  final int secretNumber;

  GameLost({required this.secretNumber});
}
