import 'package:bloc/bloc.dart';
import 'dart:math';
part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  int? _secretNumber;
  late int _maxAttempts;
  late int _remainingAttempts;

  GameBloc() : super(GameInitial()) {
    on<StartGame>((event, emit) {
      _maxAttempts = event.maxAttempts;
      _remainingAttempts = _maxAttempts;
      _secretNumber = Random().nextInt(event.maxRange) + 1;
      emit(GameInProgress(remainingAttempts: _remainingAttempts));
    });

    on<MakeGuess>((event, emit) {
      if (event.guess == _secretNumber) {
        emit(GameWon());
      } else {
        _remainingAttempts -= 1;
        if (_remainingAttempts > 0) {
          emit(GameInProgress(remainingAttempts: _remainingAttempts));
        } else {
          emit(GameLost(secretNumber: _secretNumber!));
        }
      }
    });

    on<ResetGame>((event, emit) {
      emit(GameInitial());
    });
  }
}
