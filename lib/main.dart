import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

QuizBrain qb = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int imgno = 0;

  void checkanswer(bool useranswer) {
    bool correctanswer = qb.getanswer();
    setState(() {
      if (useranswer == correctanswer)
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
        final player = AudioCache();
        if (qb.wrongno < 4)
          player.play('noise3.wav');
        else
          player.play('noise1.wav');
        qb.wrongno++;
        imgno++;
      }
      if (qb.wrongno == 5 || (qb.isfinished() && qb.wrongno == 5)) {
        Alert(
          context: context,
          type: AlertType.error,
          title: "OOPS!!",
          desc: "You have lost!",
          buttons: [
            DialogButton(
              child: Text(
                "Reset",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        qb.reset();
        imgno = 0;
        scoreKeeper = [];
      } else if (qb.isfinished()) {
        Alert(
          context: context,
          type: AlertType.error,
          title: "YAAY!!",
          desc: "You have won!",
          buttons: [
            DialogButton(
              child: Text(
                "Reset",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        qb.reset();
        imgno = 0;
        scoreKeeper = [];
      } else
        qb.nextquestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.amber,
            child: Center(
              child: Text(
                qb.getquestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text(
                      'True',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () {
                      checkanswer(true);
                    },
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    color: Colors.red,
                    child: Text(
                      'False',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      checkanswer(false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(children: scoreKeeper),
        Expanded(
          flex: 5,
          child: Container(
            child: Image.asset('assets/hangman$imgno.jpg'),
          ),
        ),
      ],
    );
  }
}
