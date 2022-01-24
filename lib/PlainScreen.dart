
import 'package:flutter/material.dart';

class PlainScreen extends StatefulWidget {
  const PlainScreen({Key? key}) : super(key: key);

  @override
  _PlainScreenState createState() => _PlainScreenState();
}

class _PlainScreenState extends State<PlainScreen> {
  int pageNumber = 1;

  @override
  Widget build(BuildContext context) {
    Widget page = pageNumber == 1
        ? Page(
      key: Key('page1'),
      onOptionSelected: () => setState(() => pageNumber = 2),
      question:
      'Do you typically fly for business, personal reasons, or some other reason?',
      answers: <String>['Business', 'Personal', 'Others'],
      number: 1,
    )
        : Page(
      key: Key('page2'),
      onOptionSelected: () => setState(() => pageNumber = 1),
      question: 'How many hours is your average flight?',
      answers: const <String>[
        'Less than two hours',
        'More than two but less than five hours',
        'Others'
      ],
      number: 2,
    );


    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: backgroundDecoration,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              ArrowIcons(),
              Plane(),
              Line(),
              Positioned.fill(
                left: 32.0 + 8,
                child: AnimatedSwitcher(
                  child: page,
                  duration: Duration(milliseconds: 250),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Page extends StatefulWidget {
  final int number;
  final String question;
  final List<String> answers;
  final VoidCallback onOptionSelected;

  const Page(
      {Key? key,
        required this.onOptionSelected,
        required this.number,
        required this.question,
        required this.answers})
      : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 32),
        StepNumber(number: widget.number),
        StepQuestion(question: widget.question),
        Spacer(),
        ...widget.answers.map((String answer) {
          return OptionItem(
              name: answer,
          );
        }),
        SizedBox(height: 64),
      ],
    );
  }

  // void onTap(int keyIndex, Offset offset) async {
  //   for (GlobalKey<_ItemFaderState> key in keys) {
  //     await Future.delayed(Duration(milliseconds: 40));
  //     key.currentState?.hide();
  //     if (keys.indexOf(key) == keyIndex) {
  //       setState(() => selectedOptionKeyIndex = keyIndex);
  //       animateDot(offset).then((_) => widget.onOptionSelected());
  //     }
  //   }
  // }
  //
  // void onInit() async {
  //   for (GlobalKey<_ItemFaderState> key in keys) {
  //     await Future.delayed(Duration(milliseconds: 40));
  //     key.currentState?.show();
  //   }
  // }
}

class StepNumber extends StatelessWidget {
  final int number;

  const StepNumber({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 16),
      child: Text(
        '0$number',
        style: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.bold,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}

class StepQuestion extends StatelessWidget {
  final String question;

  const StepQuestion({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 16),
      child: Text(
        question,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class OptionItem extends StatefulWidget {
  final String name;

  OptionItem(
      {Key? key, required this.name})
      : super(key: key);

  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  final key1 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: <Widget>[
            SizedBox(width: 26),
            Dot(key: key1,visible: true),
            SizedBox(width: 26),
            Expanded(
              child: Text(
                widget.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final bool visible;

  const Dot({Key? key, this.visible = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: visible ? Colors.white : Colors.transparent,
      ),
    );
  }
}





class ArrowIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 8,
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_upward),
            onPressed: () {},
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              color: Color.fromRGBO(120, 58, 183, 1),
              icon: Icon(Icons.arrow_downward),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class Plane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 32.0 + 8,
      top: 32,
      child: RotatedBox(
        quarterTurns: 2,
        child: Icon(
          Icons.airplanemode_active,
          size: 64,
        ),
      ),
    );
  }
}

class Line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 32.0 + 32 + 8,
      top: 40,
      bottom: 0,
      width: 1,
      child: Container(color: Colors.white.withOpacity(0.5)),
    );
  }
}

const backgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color.fromRGBO(76, 61, 243, 1),
      Color.fromRGBO(120, 58, 183, 1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
);
