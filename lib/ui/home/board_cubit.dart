import 'package:flutter_bloc/flutter_bloc.dart';

enum PlayerTurn { redPlayer, yellowPlayer }

enum CircleOwner { free, redPlayer, yellowPlayer }

class BoardState {
  final PlayerTurn playerTurn;
  final List<List<CircleOwner>> board;
  static const int boardHeight = 6;
  static const int boardWidth = 7;

  BoardState(
      {this.playerTurn = PlayerTurn.redPlayer, List<List<CircleOwner>>? board})
      : board = board ?? [];

  BoardState copyWith({
    PlayerTurn? playerTurn,
    List<List<CircleOwner>>? board,
  }) =>
      BoardState(
        playerTurn: playerTurn ?? this.playerTurn,
        board: board ?? this.board,
      );
}

class BoardCubit extends Cubit<BoardState> {
  BoardCubit() : super(BoardState());

  void initialBoard() {
    final List<List<CircleOwner>> board = [];

    for (int boardColumnPosition = 0;
        boardColumnPosition < BoardState.boardWidth;
        boardColumnPosition++) {
      board.add(List.filled(BoardState.boardHeight, CircleOwner.free));
    }

    emit(state.copyWith(board: board, playerTurn: PlayerTurn.redPlayer));
  }

  void updateChip({
    required int columnPositionX,
  }) {
    final columnToUpdate = state.board[columnPositionX];

    for (int i = columnToUpdate.length - 1; i >= 0; i--) {
      final chip = columnToUpdate[i];

      if (chip == CircleOwner.free) {
        PlayerTurn playerTurn = state.playerTurn;
        late final PlayerTurn newPlayerTurn;
        if (playerTurn == PlayerTurn.redPlayer) {
          columnToUpdate[i] = CircleOwner.redPlayer;
          newPlayerTurn = PlayerTurn.yellowPlayer;
        }
        if (playerTurn == PlayerTurn.yellowPlayer) {
          columnToUpdate[i] = CircleOwner.yellowPlayer;
          newPlayerTurn = PlayerTurn.redPlayer;
        }

        emit(state.copyWith(board: state.board, playerTurn: newPlayerTurn));
        break;
      }
    }
  }
}
