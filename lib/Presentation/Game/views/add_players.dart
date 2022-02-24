import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/Domain/Models/PlayersModel.dart';
import 'package:flutter_game/Presentation/Game/views/who_is_out.dart';
import 'package:flutter_game/Presentation/Game/widgets/add_player_dialog.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AddPlayerScreen extends StatefulWidget {
  @override
  _AddPlayerScreenState createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen>
    with TickerProviderStateMixin {
  List<Animation> _animationList = [];
  List<AnimationController> _animationControllerList = [];
  fillCOntrollers() async {
    Future.delayed(Duration(seconds: 2));
    for (int i = 0; i < 7; i++) {
      print(i);
      _animationControllerList.add(AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 750),
      ));
    }
  }

  TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<PlayersProvider>(context, listen: false).resetPlayers();
    fillCOntrollers();
    _animationList.add(
        Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0.0, 0.1)).animate(
            CurvedAnimation(
                parent: _animationControllerList[0],
                curve: Curves.easeOutExpo)));
    _animationList.add(
        Tween<Offset>(begin: Offset(0.0, 0.10), end: Offset(0.3, -0.1)).animate(
            CurvedAnimation(
                parent: _animationControllerList[1],
                curve: Curves.easeOutExpo)));
    _animationList.add(
        Tween<Offset>(begin: Offset(0.0, 0.10), end: Offset(-0.3, -0.1))
            .animate(CurvedAnimation(
                parent: _animationControllerList[2],
                curve: Curves.easeOutExpo)));
    _animationList.add(
        Tween<Offset>(begin: Offset(0.0, 0.10), end: Offset(0.3, 0.2)).animate(
            CurvedAnimation(
                parent: _animationControllerList[3],
                curve: Curves.easeOutExpo)));
    _animationList.add(
        Tween<Offset>(begin: Offset(0.0, 0.10), end: Offset(-0.3, 0.2)).animate(
            CurvedAnimation(
                parent: _animationControllerList[4],
                curve: Curves.easeOutExpo)));
    _animationList.add(
        Tween<Offset>(begin: Offset(0.0, 0.10), end: Offset(0.4, 0)).animate(
            CurvedAnimation(
                parent: _animationControllerList[5],
                curve: Curves.easeOutExpo)));
    _animationList.add(
        Tween<Offset>(begin: Offset(0.0, 0.10), end: Offset(-0.4, 0)).animate(
            CurvedAnimation(
                parent: _animationControllerList[6],
                curve: Curves.easeOutExpo)));
  }

  int currentIndex = 0;
  setCurrentIndex() {
    setState(() {
      currentIndex++;
    });
  }

  List<bool> showNames = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Consumer<PlayersProvider>(
              builder: (context, value, child) {
                return Stack(
                  children: [
                    Lottie.asset('assets/lotties/bg_top.json',
                        repeat: true, fit: BoxFit.fill),
                    currentIndex == 0
                        ? Align(
                            child: Container(
                              height: WidgetsBinding
                                          .instance.window.viewInsets.bottom >
                                      0.0
                                  ? 90
                                  : 350,
                              padding: EdgeInsets.only(top: 10),
                              child: AutoSizeText(
                                "اضف على الأقل 3 لاعبين ثم اضغط ابدأ",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.primary),
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 30,
                    ),
                    SlideTransition(
                      position: _animationList[0],
                      child: Visibility(
                          visible: showNames[0],
                          child: Center(
                            child: CloudName(value.names[0]),
                          )),
                    ),
                    SlideTransition(
                      position: _animationList[1],
                      child: Visibility(
                        visible: showNames[1],
                        child: Center(child: CloudName(value.names[1])),
                      ),
                    ),
                    SlideTransition(
                      position: _animationList[2],
                      child: Visibility(
                        visible: showNames[2],
                        child: Center(child: CloudName(value.names[2])),
                      ),
                    ),
                    SlideTransition(
                      position: _animationList[3],
                      child: Visibility(
                        visible: showNames[3],
                        child: Center(child: CloudName(value.names[3])),
                      ),
                    ),
                    SlideTransition(
                      position: _animationList[4],
                      child: Visibility(
                        visible: showNames[4],
                        child: Center(child: CloudName(value.names[4])),
                      ),
                    ),
                    SlideTransition(
                      position: _animationList[5],
                      child: Visibility(
                        visible: showNames[5],
                        child: Center(child: CloudName(value.names[0])),
                      ),
                    ),
                    SlideTransition(
                      position: _animationList[6],
                      child: Visibility(
                        visible: showNames[6],
                        child: Center(child: CloudName(value.names[5])),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            value.playersList.length < 3
                                ? Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: 90,
                                      height: 40,
                                    ),
                                  )
                                : Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: 90,
                                      height: 40,
                                      child: RoundedButton(
                                        title: "يلا بينا",
                                        onTapped: () {},
                                      ),
                                    )),
                            Card(
                                elevation: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: ColorManager.primary,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 250,
                                  height: 50,
                                  child: Form(
                                    key: _formKey,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 5),
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: TextFormField(
                                              style: TextStyle(
                                                  color: Colors.white),
                                              validator: (text) {
                                                if (Provider.of<
                                                            PlayersProvider>(
                                                        context,
                                                        listen: false)
                                                    .checkPlayerExist(text)) {
                                                  return "اسم اللاعب موجود قبل كدة";
                                                }
                                                return null;
                                              },
                                              controller:
                                                  _textEditingController,
                                              decoration: InputDecoration(
                                                hintText: "اسم اللاعب",
                                                errorStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                        Provider.of<PlayersProvider>(context)
                                                    .playersList
                                                    .length <
                                                8
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: FloatingActionButton(
                                                  backgroundColor: Colors.white,
                                                  child: Icon(Icons.add,
                                                      color: Colors.black),
                                                  onPressed: () {
                                                    if (_textEditingController
                                                            .text ==
                                                        "") {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "اسم اللاعب اييه ",
                                                          textColor: ColorManager
                                                              .backGroundColor,
                                                          backgroundColor:
                                                              ColorManager
                                                                  .failColor);
                                                    } else {
                                                      if (!_formKey.currentState
                                                          .validate()) {
                                                        return;
                                                      }

                                                      Provider.of<PlayersProvider>(
                                                              context,
                                                              listen: false)
                                                          .addPlayer(
                                                              Players(
                                                                playerName:
                                                                    _textEditingController
                                                                        .text,
                                                                playerScore: 0,
                                                              ),
                                                              currentIndex);
                                                      setState(() {
                                                        showNames[
                                                                currentIndex] =
                                                            true;

                                                        _animationControllerList[
                                                                currentIndex]
                                                            .forward();
                                                        currentIndex++;
                                                        _textEditingController
                                                            .clear();
                                                      });
                                                    }
                                                    // showDialog(
                                                    //   context: context,
                                                    //   builder: (context) {
                                                    //     return AddPlayerDialog(
                                                    //       index: currentIndex,
                                                    //       callBackFun: () {
                                                    //         setState(() {
                                                    //           showNames[
                                                    //                   currentIndex] =
                                                    //               true;

                                                    //           _animationControllerList[
                                                    //                   currentIndex]
                                                    //               .forward();
                                                    //           currentIndex++;
                                                    //         });
                                                    //       },
                                                    //     );
                                                    //   },
                                                    // );
                                                  },
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                          ],
                        )),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CloudName extends StatelessWidget {
  final String name;
  CloudName(this.name);

  @override
  Widget build(BuildContext context) {
    // return Container(width: 100,h
    //   child: RoundedButton(
    //     title: name,
    //     btnColor: ColorManager.primary,
    //     onTapped: () {},
    //   ),
    // );
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 120,
          height: 200,
          child: Lottie.network(
              "https://assets10.lottiefiles.com/packages/lf20_KUFdS6.json"),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AutoSizeText(name),
        ),
      ],
    );
  }
}
