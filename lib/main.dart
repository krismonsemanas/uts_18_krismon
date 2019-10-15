import 'package:flutter/material.dart';
import 'package:syntax_highlighter/syntax_highlighter.dart';
import 'package:url_launcher/url_launcher.dart';
void main(){
  runApp(UTS());
}
class UTS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('UTS'),
            leading: Icon(Icons.home),
            backgroundColor: Color(0xFF33E1ED),
            bottom: TabBar(
              indicatorColor: Color(0xFFFFFF8D),
              labelStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w900),
              tabs: choices.map((Choice choice) {
                return Tab(
                  text: choice.type,
                );
              }).toList()
            ),
          ),
          body: TabBarView(
            children: choices.map((Choice choice) {
                return Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Halaman(choice: choice),
                );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.type,this.dec,this.code});
  final String type;
  final String dec;
  final String code;
}
// create array list
const String codeButton = "RaisedButton(color: Color(0xFF33E1ED),textColor: Colors.white,child: Text('Load More'),onPressed: () {})";
const String codeToast = "showToast('Hello FilledStacks',duration: Duration(seconds: 2),position: ToastPosition.bottom,backgroundColor: Colors.white,radius: 5.0,textStyle: TextStyl(fontSize: 16.0, color: Colors.black),);";
const String codeText = "Text('Hello, Krismon! How are you?',textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold),)";
const String codeTextField = "";
const String codeNav = "";
List<Choice> choices = const <Choice> [
  const Choice(type: 'BUTTON',dec: "A material design raised button.A raised button is based on a Material widget whose Material.elevation increases when the button is pressed.\nUse raised buttons to add dimension to otherwise mostly flat layouts, e.g. in long busy lists of content, or in wide spaces. Avoid using raised buttons on already-raised content such as dialogs or cards.\nIf the onPressed callback is null, then the button will be disabled and by default will resemble a flat button in the disabledColor. If you are trying to change the button's color and it is not having any effect, check that you are passing a non-null onPressed handler.\nIf you want an ink-splash effect for taps, but don't want to use a button, consider using InkWell directly.\nRaised buttons have a minimum size of 88.0 by 36.0 which can be overridden with ButtonTheme.",code: codeButton),
  const Choice(type: 'TOAST',dec: "Andorid Toast can be used to display information for the short period of time. A toast contains message to be displayed quickly and disappears after sometime.",code: codeToast),
  const Choice(type: 'TEXT',dec: "The Text widget displays a string of text with single style. The string might break across multiple lines or might all be displayed on the same line depending on the layout constraints.\nThe style argument is optional. When omitted, the text will use the style from the closest enclosing DefaultTextStyle. If the given style's TextStyle.inherit property is true (the default), the given style will be merged with the closest enclosing DefaultTextStyle. This merging behavior is useful, for example, to make the text bold while using the default font family and size.",code: codeText),
  const Choice(type: 'TEXT FIELD',dec: '',code: codeTextField),
  const Choice(type: 'NAVBAR',dec: '',code: codeNav),
];
// create elemen tabbar
class Halaman extends StatelessWidget {
  // url
  Future launchURL(String url) async {
    if(await canLaunch(url)) {
      await launch(url);
    }else{
      print('Tidak bisa mengubungkan ke ${url}');
    }
  }
  const Halaman({Key key, this.choice}) : super(key: key);
  final Choice choice;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    // syntax highlighter
     final SyntaxHighlighterStyle style =
        Theme.of(context).brightness == Brightness.dark
            ? SyntaxHighlighterStyle.darkThemeStyle()
            : SyntaxHighlighterStyle.lightThemeStyle();
    return Card(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(choice.type, style: textStyle),
              Text(choice.dec, textAlign: TextAlign.justify,),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Text('Contoh Code', style: textStyle),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan> [
                        DartSyntaxHighlighter(style).format(choice.code),
                      ]
                    ),
                  ),
              ),
              RaisedButton(
                color: Color(0xFF33E1ED),
                textColor: Colors.white,
                child: Text('Load More'),
                onPressed: (){
                  launchURL('https://google.com');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}