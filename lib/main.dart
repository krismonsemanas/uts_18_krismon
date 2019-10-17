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
  const Choice({this.type,this.dec,this.code,this.ref});
  final String type;
  final String dec;
  final String code;
  final String ref;
}
// crete url ref
const String urlButton = "https://api.flutter.dev/flutter/material/RaisedButton-class.html";
const String urlForm = "https://api.flutter.dev/flutter/widgets/Form-class.html";
const String urlText = "https://api.flutter.dev/flutter/widgets/Text-class.html";
const String urlTF = "https://api.flutter.dev/flutter/material/TextField-class.html";
const String urlCard = "https://api.flutter.dev/flutter/material/Card-class.html";
// create array list
const String codeButton = "RaisedButton(color: Color(0xFF33E1ED),textColor: Colors.white,child: Text('Load More'),onPressed: () {})";
const String codeForm = "final _formKey = GlobalKey<FormState>();@override Widget build(BuildContext context) {return Form(key: _formKey,child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[TextFormField(validator: (value) {if (value.isEmpty) {return 'Please enter some text';}return null;},),Padding(padding: const EdgeInsets.symmetric(vertical: 16.0),child: RaisedButton(onPressed: () {if (_formKey.currentState.validate()) {}},child: Text('Submit'),),),],),);}";
const String codeText = "Text('Hello, Krismon! How are you?',textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold),)";
const String codeTextField = "TextField(obscureText: true,decoration: InputDecoration(border: OutlineInputBorder(),labelText: 'Password',),)";
const String codeCard = "Widget build(BuildContext context) {return Center(child: Card(child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[const ListTile(leading: Icon(Icons.album),title: Text('The Enchanted Nightingale'),subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),),ButtonTheme.bar(child: ButtonBar(children: <Widget>[FlatButton(child: const Text('BUY TICKETS'),onPressed: () {},),FlatButton(child: const Text('LISTEN'),onPressed: () { },),],),),],),),);}";
List<Choice> choices = const <Choice> [
  const Choice(type: 'BUTTON',dec: "A material design raised button.A raised button is based on a Material widget whose Material.elevation increases when the button is pressed.\nUse raised buttons to add dimension to otherwise mostly flat layouts, e.g. in long busy lists of content, or in wide spaces. Avoid using raised buttons on already-raised content such as dialogs or cards.\nIf the onPressed callback is null, then the button will be disabled and by default will resemble a flat button in the disabledColor. If you are trying to change the button's color and it is not having any effect, check that you are passing a non-null onPressed handler.\nIf you want an ink-splash effect for taps, but don't want to use a button, consider using InkWell directly.\nRaised buttons have a minimum size of 88.0 by 36.0 which can be overridden with ButtonTheme.",code: codeButton, ref: urlButton),
  const Choice(type: 'FORM',dec: "An optional container for grouping together multiple form field widgets (e.g. TextField widgets).\nEach individual form field should be wrapped in a FormField widget, with the Form widget as a common ancestor of all of those. Call methods on FormState to save, reset, or validate each FormField that is a descendant of this Form. To obtain the FormState, you may use Form.of with a context whose ancestor is the Form, or pass a GlobalKey to the Form constructor and call GlobalKey.currentState.",code: codeForm,ref: urlForm),
  const Choice(type: 'TEXT',dec: "The Text widget displays a string of text with single style. The string might break across multiple lines or might all be displayed on the same line depending on the layout constraints.\nThe style argument is optional. When omitted, the text will use the style from the closest enclosing DefaultTextStyle. If the given style's TextStyle.inherit property is true (the default), the given style will be merged with the closest enclosing DefaultTextStyle. This merging behavior is useful, for example, to make the text bold while using the default font family and size.",code: codeText, ref: urlText),
  const Choice(type: 'TEXT FIELD',dec: 'A material design text field.\nA text field lets the user enter text, either with hardware keyboard or with an onscreen keyboard.\nThe text field calls the onChanged callback whenever the user changes the text in the field. If the user indicates that they are done typing in the field (e.g., by pressing a button on the soft keyboard), the text field calls the onSubmitted callback.\nTo control the text that is displayed in the text field, use the controller. For example, to set the initial value of the text field, use a controller that already contains some text. The controller can also control the selection and composing region (and to observe changes to the text, selection, and composing region).\nBy default, a text field has a decoration that draws a divider below the text field. You can use the decoration property to control the decoration, for example by adding a label or an icon. If you set the decoration property to null, the decoration will be removed entirely, including the extra padding introduced by the decoration to save space for the labels.\nIf decoration is non-null (which is the default), the text field requires one of its ancestors to be a Material widget. When the TextField is tapped an ink splash that paints on the material is triggered, see ThemeData.splashFactory.\nTo integrate the TextField into a Form with other FormField widgets, consider using TextFormField.\mRemember to dispose of the TextEditingController when it is no longer needed. This will ensure we discard any resources used by the object.\nRemember to dispose of the TextEditingController when it is no longer needed. This will ensure we discard any resources used by the object.',code: codeTextField, ref: urlTF),
  const Choice(type: 'CARD',dec: "A material design card. A card has slightly rounded corners and a shadow.\nA card is a sheet of Material used to represent some related information, for example an album, a geographical location, a meal, contact details, etc.\nThis is what it looks like when run:",code: codeCard,ref: urlCard),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text('Load More', textAlign: TextAlign.center,)]),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                elevation: 0.0,
                onPressed: (){
                  launchURL(choice.ref);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}