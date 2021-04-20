import 'question.dart';

class QuizBrain {
  int qno = 0;
  int wrongno = 0;

  List<question> bank = [
    question('Three data select lines are required for selecting eight inputs.',
        true),
    question(
        'The device which changes from serial data to parallel data is multiplexer',
        true),
    question('A device which converts BCD to seven segment is called encoder',
        false),
    question(
        'In order to implement a "n" variabe switching function, a MUX must have 2n inputs',
        true),
    question(
        'Data can be changed from special code to temporal by using counters',
        false),
    question('The gray code equivalent of (1011)2 is 1101', false),
    question(
        'If a logic gate has 4 inputs, then total number of possible input combinations are 16',
        true),
    question('Excess 3 code is known as weighted code', true),
    question('The number of control lines for 32 to 1 multiplexer is 5', true),
    question('8 inputs are required for a 1-of-10 BCD decoder', false),
    question(
        'The time required for a gate or inverter to change its state is called decay time',
        false),
    question(
        'The output of NOR gate is high if all of its inputs are high', true),
    question('The range of valid low input is 0.4V to 0.8V', true),
    question('CMOS circuits consume power equal to TTL', false),
    question('The logic 0 level of a CMOS logic device is appoximately 0 volts',
        true),
    // question('Fan-out is specified in terms of unit load', true),
    // question('Operating temperature of the IC vary from 0 to 35 degree celsius',
    //     false),
    // question('Logic gates are basic elements that make a analog system', false),
    // question('The fan-out of a 7400 NAND gate is 10TTL', true),
    // question(
    //     'The greater the propagation delay, lower the maximum frequency', true),
    // question('An open collector output requires a pulldown resistor', false),
    // question('PMOS and NMOS circuits are used largely in LSI functions', true),
    // question('TTL operates from a 5 volt supply', true),
    // question('The translation distance pair is known as swift vector.', true),
    // question(
    //     'Aspect ratio is the ratio of horizontal points to vertical points to produce equal length lines in both direction on the screen.',
    //     false),
    // question('Base is MOSFET terminal.', false),
//    question('Logic Gates are the basic components that make a digital system.',
//        true),
//    question(
//        'In line drawing algorithms, brightness of the line is dependant upon the orientation of the line',
//        true),
//    question('We use GL_LINE_LOOP primitive to close a line strip.', true),
//    question('Titem pole TTL logic gate is used for wired anding.', false)
  ];
  void nextquestion() {
    if (qno < bank.length - 1) qno++;
  }

  String getquestion() {
    return bank[qno].questionText;
  }

  bool getanswer() {
    return bank[qno].questionAnswer;
  }

  bool isfinished() {
    if (qno >= bank.length - 1)
      return true;
    else
      return false;
  }

  void reset() {
    qno = 0;
    wrongno = 0;
  }
}
