import 'package:flutter_bloc/flutter_bloc.dart';

enum PlayerTurn { redPlayer, yellowPlayer }

enum CircleOwner { free, redPlayer, yellowPlayer }

class BoardState {
  static const int boardHeight = 6;
  static const int boardWidth = 7;
  static const int numberConnectedToWin = 4;

  final PlayerTurn playerTurn;
  final PlayerTurn? winner;
  final List<List<CircleOwner>> board;
  final int gamesWinRedPlayer;
  final int gamesWinYellowPlayer;

  BoardState(
      {this.playerTurn = PlayerTurn.redPlayer,
      this.winner,
      List<List<CircleOwner>>? board,
      this.gamesWinRedPlayer = 0,
      this.gamesWinYellowPlayer = 0})
      : board = board ?? [];

  BoardState copyWith({
    PlayerTurn? playerTurn,
    PlayerTurn? winner,
    List<List<CircleOwner>>? board,
    int? gamesWinRedPlayer,
    int? gamesWinYellowPlayer,
  }) =>
      BoardState(
        playerTurn: playerTurn ?? this.playerTurn,
        winner: winner,
        board: board ?? this.board,
        gamesWinRedPlayer: gamesWinRedPlayer ?? this.gamesWinRedPlayer,
        gamesWinYellowPlayer: gamesWinYellowPlayer ?? this.gamesWinYellowPlayer,
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

  void reloadCounterGames() {
    emit(state.copyWith(gamesWinRedPlayer: 0, gamesWinYellowPlayer: 0));
  }

  void updateChip({
    required int columnPositionX,
  }) {
    final columnToUpdate = state.board[columnPositionX];

    for (int rowPosition = columnToUpdate.length - 1;
        rowPosition >= 0;
        rowPosition--) {
      final chip = columnToUpdate[rowPosition];

      if (chip == CircleOwner.free) {
        final PlayerTurn playerTurn = state.playerTurn;
        late final PlayerTurn newPlayerTurn;
        late final CircleOwner newChipOwner;
        if (playerTurn == PlayerTurn.redPlayer) {
          newChipOwner = CircleOwner.redPlayer;
          columnToUpdate[rowPosition] = newChipOwner;
          newPlayerTurn = PlayerTurn.yellowPlayer;
        }
        if (playerTurn == PlayerTurn.yellowPlayer) {
          newChipOwner = CircleOwner.yellowPlayer;
          columnToUpdate[rowPosition] = newChipOwner;
          newPlayerTurn = PlayerTurn.redPlayer;
        }

        emit(state.copyWith(board: state.board, playerTurn: newPlayerTurn));

        final bool endGame = _existsConnect4Winner(
          columnInitialPosition: columnPositionX,
          rowInitialPosition: rowPosition,
          owner: newChipOwner,
        );

        if (endGame) {
          int gamesWinRedPlayer = state.gamesWinRedPlayer;
          int gamesWinYellowPlayer = state.gamesWinYellowPlayer;

          playerTurn == PlayerTurn.redPlayer
              ? gamesWinRedPlayer++
              : gamesWinYellowPlayer++;

          emit(state.copyWith(
            winner: playerTurn,
            gamesWinRedPlayer: gamesWinRedPlayer,
            gamesWinYellowPlayer: gamesWinYellowPlayer,
          ));
        }
        break;
      }
    }
  }

  bool _existsConnect4Winner({
    required int columnInitialPosition,
    required int rowInitialPosition,
    required CircleOwner owner,
  }) {
    final bool connected4Horizontal =
        _horizontalSearch(columnInitialPosition, rowInitialPosition, owner);
    final bool connected4Vertical =
        _verticalSearch(columnInitialPosition, rowInitialPosition, owner);
    final bool connected4DiagonalRightUpLeftDown =
        _diagonalRightUpLeftDownSearch(
            columnInitialPosition, rowInitialPosition, owner);
    final bool connected4DiagonalLeftUpRightDown =
        _diagonalLeftUpRightDownSearch(
            columnInitialPosition, rowInitialPosition, owner);

    if (connected4Horizontal ||
        connected4Vertical ||
        connected4DiagonalRightUpLeftDown ||
        connected4DiagonalLeftUpRightDown) {
      return true;
    }

    return false;
  }

  bool _horizontalSearch(int columnInitialPosition, int rowInitialPosition,
      CircleOwner circleOwner) {
    int numberHorizontalConnectedChips = 1;
    // Search initial to right
    for (int columnPosition = columnInitialPosition + 1;
        columnPosition < state.board.length;
        columnPosition++) {
      if (state.board[columnPosition][rowInitialPosition] != circleOwner) {
        break;
      }
      numberHorizontalConnectedChips += 1;
    }

    // Search initial to left
    for (int columnPosition = columnInitialPosition - 1;
        columnPosition >= 0;
        columnPosition--) {
      if (state.board[columnPosition][rowInitialPosition] != circleOwner) {
        break;
      }
      numberHorizontalConnectedChips += 1;
    }

    return numberHorizontalConnectedChips >= BoardState.numberConnectedToWin;
  }

  bool _verticalSearch(int columnInitialPosition, int rowInitialPosition,
      CircleOwner circleOwner) {
    int numberVerticalConnectedChips = 1;
    // Search initial to up not needed
    // Search initial to down
    for (int rowPosition = rowInitialPosition + 1;
        rowPosition < state.board[columnInitialPosition].length;
        rowPosition++) {
      if (state.board[columnInitialPosition][rowPosition] != circleOwner) {
        break;
      }
      numberVerticalConnectedChips += 1;
    }

    return numberVerticalConnectedChips >= BoardState.numberConnectedToWin;
  }

  bool _diagonalRightUpLeftDownSearch(int columnInitialPosition,
      int rowInitialPosition, CircleOwner circleOwner) {
    int numberHorizontalConnectedChips = 1;

    int newRowIndexSelected = rowInitialPosition - 1;

    //search initial to right up
    for (int columnPosition = columnInitialPosition + 1;
        columnPosition < state.board.length;
        columnPosition++) {
      if (newRowIndexSelected < 0) {
        break;
      }
      if (state.board[columnPosition][newRowIndexSelected] != circleOwner) {
        break;
      }
      newRowIndexSelected--;
      numberHorizontalConnectedChips += 1;
    }

    newRowIndexSelected = rowInitialPosition + 1;

    //search initial to left down
    for (int columnPosition = columnInitialPosition - 1;
        columnPosition >= 0;
        columnPosition--) {
      if (newRowIndexSelected > state.board[columnPosition].length - 1) {
        break;
      }
      if (state.board[columnPosition][newRowIndexSelected] != circleOwner) {
        break;
      }
      newRowIndexSelected++;
      numberHorizontalConnectedChips += 1;
    }

    newRowIndexSelected = rowInitialPosition + 1;

    return numberHorizontalConnectedChips >= BoardState.numberConnectedToWin;
  }

  bool _diagonalLeftUpRightDownSearch(int columnInitialPosition,
      int rowInitialPosition, CircleOwner circleOwner) {
    int numberHorizontalConnectedChips = 1;

    int newRowIndexSelected = rowInitialPosition - 1;

    //search initial to left up
    for (int columnPosition = columnInitialPosition - 1;
        columnPosition >= 0;
        columnPosition--) {
      if (newRowIndexSelected < 0) {
        break;
      }
      if (state.board[columnPosition][newRowIndexSelected] != circleOwner) {
        break;
      }
      newRowIndexSelected--;
      numberHorizontalConnectedChips += 1;
    }

    newRowIndexSelected = rowInitialPosition + 1;

    //search initial to right down
    for (int columnPosition = columnInitialPosition + 1;
        columnPosition < state.board.length;
        columnPosition++) {
      if (newRowIndexSelected > state.board[columnPosition].length - 1) {
        break;
      }
      if (state.board[columnPosition][newRowIndexSelected] != circleOwner) {
        break;
      }
      newRowIndexSelected++;
      numberHorizontalConnectedChips += 1;
    }

    newRowIndexSelected = rowInitialPosition + 1;

    return numberHorizontalConnectedChips >= BoardState.numberConnectedToWin;
  }
}
