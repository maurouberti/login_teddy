import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:login_teddy/teddy_controller.dart';
import 'package:login_teddy/tracking_text_input.dart';
import 'package:login_teddy/signin_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tela de Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TeddyController _teddyController;
  @override
  initState() {
    _teddyController = TeddyController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    
    return Scaffold(
      // Code do fundo
      backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),

      body: Container(
        child: Stack(
          children: <Widget>[
            // Gradiente
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.0, 1.0],
                    colors: [
                      Color.fromRGBO(170, 207, 211, 1.0),
                      Color.fromRGBO(93, 142, 155, 1.0),
                    ],
                  )
                )
              )
            ),
            // Tela de login
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: devicePadding.top),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Teddy
                    Container(
                      height: 200,
                      padding: const EdgeInsets.only(left: 30.0, right:30.0),
                      child: FlareActor(
                        "assets/Teddy.flr",
                        shouldClip: false,
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.contain,
                        controller: _teddyController,
                      )
                    ),
                    // Formulário
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25.0))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TrackingTextInput(
                                label: "E-mail",
                                hint: "Digite seu e-mail",
                                // Teddy move os olhos qdo digita
                                onCaretMoved: (Offset caret) {
                                  _teddyController.lookAt(caret);
                                }
                              ),
                              TrackingTextInput(
                                label: "Senha",
                                hint: "Digite sua senha",
                                isObscured: true,
                                // Teddy cobre os olhos
                                onCaretMoved: (Offset caret) {
                                  _teddyController.coverEyes(caret != null);
                                  _teddyController.lookAt(null);
                                },
                                onTextChanged: (String value) {
                                  _teddyController.setPassword(value);
                                },
                              ),
                              SigninButton(
                                child: Text("Entrar", style: TextStyle(fontSize: 16, color: Colors.white)),
                                onPressed: () {
                                  _teddyController.submitPassword();
                                }
                              )
                            ],
                          )
                        )
                      )
                    )
                  ],
                )
              )
            )
          ],
        ),
      )
    );
  }
}
