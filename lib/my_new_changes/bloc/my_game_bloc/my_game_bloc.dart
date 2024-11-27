import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:match_is/my_new_changes/models/my_player.dart';

part 'my_game_event.dart';
part 'my_game_state.dart';

class MyGameBloc extends Bloc<MyGameEvent, MyGameState> {
  MyGameBloc() : super(MyGameInitial()) {
    on<StartGame>((event, emit) {
      // TODO: implement event handler
    });
    on<EndGame>((event, emit) {
      // TODO: implement event handler
    });
  }
}
