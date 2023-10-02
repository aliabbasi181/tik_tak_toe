import 'package:flutter/material.dart';

class TicTacToeApp extends StatefulWidget {
  @override
  State<TicTacToeApp> createState() => _TicTacToeAppState();
}

class _TicTacToeAppState extends State<TicTacToeApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<List<String>> board =
      List.generate(3, (_) => List.generate(3, (_) => ""));
  bool xTurn = true;
  String winner = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-Tac-Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              winner.isEmpty
                  ? (xTurn ? "X's Turn" : "O's Turn")
                  : "Winner: $winner",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                final row = index ~/ 3;
                final col = index % 3;
                return InkWell(
                  onTap: () {
                    if (board[row][col].isEmpty && winner.isEmpty) {
                      setState(() {
                        board[row][col] = xTurn ? "X" : "O";
                        xTurn = !xTurn;
                        checkWinner(row, col);
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Center(
                      child: Text(
                        board[row][col],
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                resetBoard();
              },
              child: Text('Reset Game'),
            ),
          ],
        ),
      ),
    );
  }

  void checkWinner(int row, int col) {
    // Check rows, columns, and diagonals for a win
    if (board[row][0] == board[row][1] && board[row][1] == board[row][2]) {
      winner = board[row][0];
    } else if (board[0][col] == board[1][col] &&
        board[1][col] == board[2][col]) {
      winner = board[0][col];
    } else if (row == col &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      winner = board[0][0];
    } else if (row + col == 2 &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      winner = board[0][2];
    }
    // if (winner != "") {
    //   // ScaffoldMessenger.of(context).showSnackBar(
    //   //     SnackBar(content: SnackBar(content: Text("Winner $winner"))));
    //   resetBoard();
    // }
  }

  void resetBoard() {
    setState(() {
      board = List.generate(3, (_) => List.generate(3, (_) => ""));
      xTurn = true;
      winner = "";
    });
  }
}
