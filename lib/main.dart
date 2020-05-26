import "package:flutter/material.dart";

void main() => runApp(HomePage());

const rojo = Colors.red;
const verde = Colors.green;
const azul = Colors.blue;
const big = const TextStyle(fontSize: 30);

// app principal que ejecuta todo
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => 
  FlutterLayoutArticle([
    Example1(),
    Example2(),
    Example3(),
    Example4(),
    Example5(),
    Example6(),
    Example7(),
    Example8()
  ]);
}

// clase que hará de base para las clases examples especificas
abstract class Example extends StatelessWidget {
  String get code;
  String get explanation;
}

// Clase para crear los layoutArticle
class FlutterLayoutArticle extends StatefulWidget {
  final List<Example> examples;

  FlutterLayoutArticle(this.examples);

  @override
  _FlutterLayoutArticleState createState() =>
      _FlutterLayoutArticleState();
}


class _FlutterLayoutArticleState extends State<FlutterLayoutArticle> {
  int count;
  Widget example;
  String code;
  String explanation;

  @override
  void initState() {
    count = 1;
    code = Example1().code;
    explanation = Example1().explanation;

    super.initState();
  }

  @override
  void didUpdateWidget(FlutterLayoutArticle oldWidget) {
    super.didUpdateWidget(oldWidget);

    var example = widget.examples[count - 1];
    code = example.code;
    explanation = example.explanation;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter layout article",
      home: SafeArea(
        child: Material(
          color: Colors.black,
          child: FittedBox(
            child: Container(
              width: 400,
              height: 670,
              color: Color(0xFFCCCCCC),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                        width: double.infinity,
                        height: double.infinity
                      ),

                      child: widget.examples[count - 1]
                    )),
                    
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.black,
                      
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,

                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            for(int i = 0; i < widget.examples.length; i++)
                              Container(
                                width: 58,
                                padding: EdgeInsets.only(left: 4.0, right: 4.0),

                                child: button(i + 1))
                          ],
                        )
                      ),
                    ),

                    Container(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          key: ValueKey(count),

                          child: Padding(
                            padding: const EdgeInsets.all(10.0),

                            child: Column(
                              children: [
                                Center(
                                  child: Text(code)),
                                SizedBox(height: 15),

                                Text(explanation, style: TextStyle(
                                  color: Colors.blue[900],
                                  fontStyle: FontStyle.italic))
                              ]
                            )
                          ))
                      ),
                      height: 273,
                      color: Colors.grey)
                ],
              )
            )
          )),
      )
    );
  }

  Widget button(int exampleNumber) => new Button(
    key: ValueKey('button$exampleNumber'),
    isSelected: this.count == exampleNumber,
    exampleNumber: exampleNumber,
    onPressed: (){
      showExample(
        exampleNumber,
        widget.examples[exampleNumber - 1].code,
        widget.examples[exampleNumber - 1].explanation
      );
    });

    void showExample(int exampleNumber, String code, String explanation) => setState((){
      this.count = exampleNumber;
      this.code = code;
      this.explanation = explanation;
    });
}


// Clase que crea los botones con un evento de click
class Button extends StatelessWidget {

  final Key key;
  final bool isSelected;
  final int exampleNumber;
  final VoidCallback onPressed;

  Button({
    this.key,
    this.isSelected,
    this.exampleNumber,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: isSelected ? Colors.grey : Colors.grey[800],
      child: Text(exampleNumber.toString(),
      style: TextStyle(color: Colors.white)),

      onPressed: (){
        Scrollable.ensureVisible(context, duration: Duration(
          milliseconds: 350),
          
          curve: Curves.easeOut,
          alignment: 0.5);
          onPressed();
      });
  }
}

//clase example1
class Example1 extends Example {
  final code = 'Container(color: red)';
  final explanation = "The screen is the parent of the Container, "
    'and it forces the Container to be exactly the same size as the screen.'
      '\n\n'
      'So the Container fills the screen and paints it red.';

  @override
  Widget build(BuildContext context) {
    return new Container(color: rojo);
  }
}

class Example2 extends Example {
  final String code = 'Container(width: 100, height: 100, color: red)';
  final String explanation = 'The red Container wants to be 100x100, but it can\'t, '
      'because the screen forces it to be exactly the same size as the screen.'
      '\n\n'
      'So the Container fills the screen.';

  @override
  Widget build(BuildContext context) {
    return Container(width: 100, height: 100, color: rojo);
  }
}


class Example3 extends Example {
  final String code = 'Center(\n'
      '   child: Container(width: 100, height: 100, color: red))';
  final String explanation =
      'The screen forces the Center to be exactly the same size as the screen,'
      'so the Center fills the screen.'
      '\n\n'
      'The Center tells the Container that it can be any size it wants, but not bigger than the screen.'
      'Now the Container can indeed be 100x100.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(width: 100, height: 100, color: rojo),
    );
  }
}

class Example4 extends Example {
  final String code = 'Align(\n'
      '   alignment: Alignment.bottomRight,\n'
      '   child: Container(width: 100, height: 100, color: red))';
  final String explanation =
      'This is different from the previous example in that it uses Align instead of Center.'
      '\n\n'
      'Align also tells the Container that it can be any size it wants, but if there is empty space it won\'t center the Container. '
      'Instead, it aligns the Container to the bottom-right of the available space.';

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(width: 100, height: 100, color: rojo),
    );
  }
}

class Example5 extends Example {
  final String code = 'Center(\n'
      '   child: Container(\n'
      '              color: red,\n'
      '              width: double.infinity,\n'
      '              height: double.infinity))';
  final String explanation =
      'The screen forces the Center to be exactly the same size as the screen,'
      'so the Center fills the screen.'
      '\n\n'
      'The Center tells the Container that it can be any size it wants, but not bigger than the screen.'
      'The Container wants to be of infinite size, but since it can\'t be bigger than the screen, it just fills the screen.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(width: double.infinity, height: double.infinity, color: rojo),
    );
  }
}

class Example6 extends Example {
  final String code = 'Center(child: Container(color: red))';
  final String explanation =
      'The screen forces the Center to be exactly the same size as the screen,'
      'so the Center fills the screen.'
      '\n\n'
      'The Center tells the Container that it can be any size it wants, but not bigger than the screen.'
      '\n\n'
      'Since the Container has no child and no fixed size, it decides it wants to be as big as possible, so it fills the whole screen.'
      '\n\n'
      'But why does the Container decide that? '
      'Simply because that\'s a design decision by those who created the Container widget. '
      'It could have been created differently, and you have to read the Container documentation to understand how it behaves, depending on the circumstances. ';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(color: rojo),
    );
  }
}


class Example7 extends Example {
  final String code = 'Center(\n'
      '   child: Container(color: red\n'
      '      child: Container(color: green, width: 30, height: 30)))';
  final String explanation =
      'The screen forces the Center to be exactly the same size as the screen,'
      'so the Center fills the screen.'
      '\n\n'
      'The Center tells the red Container that it can be any size it wants, but not bigger than the screen.'
      'Since the red Container has no size but has a child, it decides it wants to be the same size as its child.'
      '\n\n'
      'The red Container tells its child that if can be any size it wants, but not bigger than the screen.'
      '\n\n'
      'The child is a green Container that wants to be 30x30.'
      '\n\n'
      'Since the red `Container` has no size but has a child, it decides it wants to be the same size as its child. '
      'The red color isn\'t visible, since the green Container entirely covers all of the red Container.';


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: rojo,
        child: Container(color: verde, width: 30, height: 30),
      ),
    );
  }
}


class Example8 extends Example {
  final String code = 'Center(\n'
      '   child: Container(color: red\n'
      '      padding: const EdgeInsets.all(20.0),\n'
      '      child: Container(color: green, width: 30, height: 30)))';
  final String explanation =
      'The red Container sizes itself to its children size, but it takes its own padding into consideration. '
      'So it is also 30x30 plus padding. '
      'The red color is visible because of the padding, and the green Container has the same size as in the previous example.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: rojo,
        child: Container(color: verde, width: 30, height: 30),
      ),
    );
  }
}