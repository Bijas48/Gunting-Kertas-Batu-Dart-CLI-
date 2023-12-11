import 'dart:math';
import 'dart:io';

void main() {
  var accessSubClass = new SubClass();

  while (true) {
    print('\nGame Gunting Kertas Batu');
    print(
        '1. lawan Bot/Computer\n2. Lawan dengan teman (2 Player)\n3. Meninggalkan Permainan');
    int yourChoice = accessSubClass.validateChoice();
    if (yourChoice == 3) {
      break;
    }

    var playWith = new PlayingTheGame(yourChoice);
  }
}

// Make rock kertas gunting with applying OOP in Dart

abstract class ParentClass {
  late int _yourPoint;
  late int _enemyPoint;
  int _numberOfRound = 1;

  final random = new Random();

  void setYourPoint();
  void setEnemyPoint();
  void setNumberOfRound();
  void resetGameStat();

  int getYourPoint();
  int getEnemyPoint();
  int getNumberOfRound();
  int countRoundofPlay();

  int theWinner(String yourChoice, enemyChoice);
  String yourAnswer(int hideOrShowInput);
  String enemyAnswer();

  int validateChoice();
  int playAgain();
}

class SubClass extends ParentClass {
  int _yourPoint = 0;
  int _enemyPoint = 0;
  int _numberOfRound = 1;

  @override
  int theWinner(String yourChoice, enemyChoice) {
    // if user/player one win then it would return 0, if bot/player two win then it would return 1, if draw then it would return 2
    int Winner;

    if (yourChoice.toLowerCase() == "gunting" && enemyChoice == "kertas") {
      Winner = 0;
    } else if (enemyChoice == "gunting" &&
        yourChoice.toLowerCase() == "kertas") {
      Winner = 1;
    } else if (yourChoice.toLowerCase() == "gunting" && enemyChoice == "batu") {
      Winner = 1;
    } else if (enemyChoice == "gunting" && yourChoice.toLowerCase() == "batu") {
      Winner = 0;
    } else if (yourChoice.toLowerCase() == "kertas" && enemyChoice == "batu") {
      Winner = 0;
    } else if (enemyChoice == "kertas" && yourChoice.toLowerCase() == "batu") {
      Winner = 1;
    } else {
      Winner = 2;
    }
    return Winner;
  }

  @override
  String yourAnswer(int hideOrShowInput) {
    // if one then hide the input from user in command line
    if (hideOrShowInput == 1) {
      stdin.echoMode = false;
    }

    print('Pilih  (gunting/kertas/batu) : ');
    while (true) {
      String yourChoice = stdin.readLineSync()!;
      if (yourChoice.toLowerCase() == "gunting" ||
          yourChoice.toLowerCase() == "kertas" ||
          yourChoice.toLowerCase() == "batu") {
        stdin.echoMode = true;
        return yourChoice;
      } else {
        print(
            'pilihan anda kurang depat atau ada yang typo, coba input ulang!');
      }
    }
  }

  @override
  String enemyAnswer() {
    var enemyAnswer = <String>["gunting", "kertas", "batu"];
    int enemyRandom = random.nextInt(enemyAnswer.length);
    String enemyChoice = enemyAnswer[enemyRandom];
    return enemyChoice;
  }

  @override
  void setYourPoint() {
    _yourPoint++;
  }

  @override
  void setEnemyPoint() {
    _enemyPoint++;
  }

  @override
  void setNumberOfRound() {
    _numberOfRound++;
  }

  @override
  void resetGameStat() {
    _yourPoint = 0;
    _enemyPoint = 0;
    _numberOfRound = 1;
  }

  @override
  int getYourPoint() {
    return _yourPoint;
  }

  @override
  int getEnemyPoint() {
    return _enemyPoint;
  }

  @override
  int getNumberOfRound() {
    return _numberOfRound;
  }

  @override
  int countRoundofPlay() {
    print("\nTentukan berapa ronde? (Hanya Ganjil seperti 1/3/5/strs) : ");
    while (true) {
      String totalRound = stdin.readLineSync()!;

      try {
        if (int.parse(totalRound) >= 0 && int.parse(totalRound) % 2 != 0) {
          return int.parse(totalRound);
        } else {
          print(
              'pilihan anda kurang depat atau ada yang typo, coba input ulang!');
        }
      } catch (e) {
        print(
            'pilihan anda kurang depat atau ada yang typo, coba input ulang!');
      }
    }
  }

  @override
  int validateChoice() {
    print("Tentukan pilihannmu : ");
    while (true) {
      String selectTheMenu = stdin.readLineSync()!;

      if (int.tryParse(selectTheMenu) == 1) {
        return int.parse(selectTheMenu);
      } else if (int.tryParse(selectTheMenu) == 2) {
        return int.parse(selectTheMenu);
      } else if (int.tryParse(selectTheMenu) == 3) {
        return int.parse(selectTheMenu);
      } else {
        print(
            'pilihan anda kurang depat atau ada yang typo, coba input ulang!');
      }
    }
  }

  @override
  int playAgain() {
    print("Bermain lagi...? Yes/No : ");
    while (true) {
      String playAnymore = stdin.readLineSync()!;

      // return 1 if the player want to play again, return 0 if the player won't play again
      if (playAnymore.toLowerCase() == "yes") {
        return 1;
      } else if (playAnymore.toLowerCase() == "no") {
        return 0;
      } else {
        print(
            'pilihan anda kurang depat atau ada yang typo, coba input ulang!');
      }
    }
  }
}

class PlayingTheGame extends SubClass {
  var accessSubClass = new SubClass();

  PlayingTheGame(int playingWith) {
    if (playingWith == 1) {
      int roundOfPlay = accessSubClass.countRoundofPlay();
      print(
          "\nPemenang akan ditentukan dari para pemenang dalam ronde ${roundOfPlay} (bisa kurang dari itu dan tidak dihitung jika seri)\nGame Started.......");

      while (true) {
        print("\nRound ${accessSubClass.getNumberOfRound()}");
        String yourChoice = accessSubClass.yourAnswer(0);
        String enemyChoice = accessSubClass.enemyAnswer();
        int theResult = accessSubClass.theWinner(yourChoice, enemyChoice);

        if (theResult == 0) {
          accessSubClass.setYourPoint();
          print(
              'Selamat, Anda memenangkan ronde  ${accessSubClass.getNumberOfRound()} karena musuh memilih ${enemyChoice}!');
        } else if (theResult == 1) {
          accessSubClass.setEnemyPoint();
          print(
              'Yah, Anda harus kalah di ronde ${accessSubClass.getNumberOfRound()} karena musuh memilih ${enemyChoice}!');
        } else if (theResult == 2) {
          print(
              "Anda seri pada round ${accessSubClass._numberOfRound} karna anda memilih ${yourChoice} dan musuh memilih ${enemyChoice}!");
        }

        print(
            "Perolehan Poin\nPoink kamu : ${accessSubClass.getYourPoint()}\nPoin Musuh : ${accessSubClass.getEnemyPoint()}");
        accessSubClass.setNumberOfRound();

        if (accessSubClass.getYourPoint() >= (roundOfPlay / 2)) {
          print(
              '\nSelamat, Anda memenangkan pertandingan dengan skor ${accessSubClass.getYourPoint()} - ${accessSubClass.getEnemyPoint()}!\n');
          int playAgain = accessSubClass.playAgain();
          if (playAgain == 0) {
            break;
          } else {
            roundOfPlay = accessSubClass.countRoundofPlay();
            accessSubClass.resetGameStat();
          }
        } else if (accessSubClass.getEnemyPoint() >= (roundOfPlay / 2)) {
          print(
              '\nSayang sekali, Anda harus kalah dengan skor ${accessSubClass.getYourPoint()} - ${accessSubClass.getEnemyPoint()}!\n');
          int playAgain = accessSubClass.playAgain();
          if (playAgain == 0) {
            break;
          } else {
            roundOfPlay = accessSubClass.countRoundofPlay();
            accessSubClass.resetGameStat();
          }
        }
      }
    } else if (playingWith == 2) {
      int roundOfPlay = accessSubClass.countRoundofPlay();
      print(
          "\nPemenang akan ditentukan dari para pemenang dalam ${roundOfPlay} round (bisa kurang dari itu dan tidak dihitung jika seri)\nGame Started.......");
      while (true) {
        print("\nRound ${accessSubClass.getNumberOfRound()}");
        print('\nPlayer One Mulai');
        String playerOneChoice = accessSubClass.yourAnswer(1);
        print('\nPlayer Two Mulai');
        String playerTwoChoice = accessSubClass.yourAnswer(1);
        int theResult =
            accessSubClass.theWinner(playerOneChoice, playerTwoChoice);

        // Your Point = Player One | Enemy Point = Player Two
        if (theResult == 0) {
          accessSubClass.setYourPoint();
          print(
              '\nSelamat player satu menang pada round ${accessSubClass.getNumberOfRound()} karena player satu memilih ${playerOneChoice} dan player dua memilih ${playerTwoChoice}!');
        } else if (theResult == 1) {
          accessSubClass.setEnemyPoint();
          print(
              '\nSelamat player dua menang pada round ${accessSubClass.getNumberOfRound()} karena player satu memilih ${playerOneChoice} dan player dua memilih ${playerTwoChoice}!');
        } else if (theResult == 2) {
          print(
              "\nKalian seri pada round ${accessSubClass._numberOfRound} karena player satu memilih ${playerOneChoice} dan player dua memilih ${playerTwoChoice}!");
        }

        print(
            "Perolehan Poin\nPoin Player Satu : ${accessSubClass.getYourPoint()}\nPoin Player dua : ${accessSubClass.getEnemyPoint()}");
        accessSubClass.setNumberOfRound();

        if (accessSubClass.getYourPoint() >= (roundOfPlay / 2)) {
          print(
              '\nSelamat pemain dua memenangkan pertandingan dengan skor ${accessSubClass.getYourPoint()} - ${accessSubClass.getEnemyPoint()}!\n');
          int playAgain = accessSubClass.playAgain();
          if (playAgain == 0) {
            break;
          } else {
            roundOfPlay = accessSubClass.countRoundofPlay();
            accessSubClass.resetGameStat();
          }
        } else if (accessSubClass.getEnemyPoint() >= (roundOfPlay / 2)) {
          print(
              '\nSelamat pemain dua memenangkan pertandingan dengan skor ${accessSubClass.getYourPoint()} - ${accessSubClass.getEnemyPoint()}!\n');
          int playAgain = accessSubClass.playAgain();
          if (playAgain == 0) {
            break;
          } else {
            roundOfPlay = accessSubClass.countRoundofPlay();
            accessSubClass.resetGameStat();
          }
        }
      }
    }
  }
}
