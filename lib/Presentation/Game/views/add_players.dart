import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/Domain/Models/PlayersModel.dart';
import 'package:flutter_game/Presentation/Game/views/who_is_out.dart';
import 'package:flutter_game/Presentation/Game/widgets/add_player_dialog.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/Shared/constantData.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';

class AddPlayerScreen extends StatefulWidget {
  @override
  _AddPlayerScreenState createState() => _AddPlayerScreenState();
}

List<Animation> _animationList = [];
List<AnimationController> _animationControllerList = [];

class _AddPlayerScreenState extends State<AddPlayerScreen>
    with TickerProviderStateMixin {
  // fillCOntrollers() async {
  //   for (int i = 0; i < 7; i++) {
  //     print(i);
  //     _animationControllerList.add(AnimationController(
  //       vsync: this,
  //       duration: Duration(seconds: 1),
  //     ));
  //   }
  // }

  // SwiperController _swiperController = SwiperController();
  // resetControllers() {
  //   for (int i = 0; i < 7; i++) {
  //     _animationControllerList[i].reset();
  //   }
  //   print("reset done");
  // }

  disposeControllers() {
    for (int i = 0; i < 7; i++) {
      _animationControllerList[i].dispose();
    }
  }

  AudioCache player = AudioCache();
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<PlayersProvider>(context, listen: false).resetPlayers();
    // print(_animationControllerList.length);
    // if (_animationControllerList.isEmpty) {
    //   fillCOntrollers();
    // } else {
    //   resetControllers();
    // }
    // if (_animationList.isEmpty) {
    //   _animationList.add(
    //       Tween<Offset>(begin: Offset(0.40, 15.0), end: Offset(0.0, 0)).animate(
    //           CurvedAnimation(
    //               parent: _animationControllerList[0],
    //               curve: Curves.easeOutExpo)));
    //   _animationList.add(
    //       Tween<Offset>(begin: Offset(0.40, 10.0), end: Offset(0.0, 0)).animate(
    //           CurvedAnimation(
    //               parent: _animationControllerList[1],
    //               curve: Curves.easeOutExpo)));
    //   _animationList.add(
    //       Tween<Offset>(begin: Offset(0.40, 10.0), end: Offset(0.0, 0)).animate(
    //           CurvedAnimation(
    //               parent: _animationControllerList[2],
    //               curve: Curves.easeOutExpo)));
    //   _animationList.add(
    //       Tween<Offset>(begin: Offset(0.40, 10.0), end: Offset(0.0, 0)).animate(
    //           CurvedAnimation(
    //               parent: _animationControllerList[3],
    //               curve: Curves.easeOutExpo)));
    //   _animationList.add(
    //       Tween<Offset>(begin: Offset(0.40, 10.0), end: Offset(0.0, 0)).animate(
    //           CurvedAnimation(
    //               parent: _animationControllerList[4],
    //               curve: Curves.easeOutExpo)));
    //   _animationList.add(
    //       Tween<Offset>(begin: Offset(0.40, 10.0), end: Offset(0.0, 0)).animate(
    //           CurvedAnimation(
    //               parent: _animationControllerList[5],
    //               curve: Curves.easeOutExpo)));
    //   _animationList.add(
    //       Tween<Offset>(begin: Offset(0.40, 10.0), end: Offset(0.0, 0)).animate(
    //           CurvedAnimation(
    //               parent: _animationControllerList[6],
    //               curve: Curves.easeOutExpo)));
    // }
  }

  int currentIndex = 0;
  setCurrentIndex() {
    setState(() {
      currentIndex++;
    });
  }

  double listHeight = 90;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/gameBackground.jpg",
                    ),
                    fit: BoxFit.fill)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Consumer<PlayersProvider>(
              builder: (context, value, child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      AutoSizeText(
                        "اللاعبين",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: listHeight * value.playersList.length,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                          itemCount: value.playersList.length == 0
                              ? 1
                              : value.playersList.length,
                          itemBuilder: (context, index) {
                            return BounceInRight(
                              child: Visibility(
                                visible: value.playersList.length != 0,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: PLayerContainer(
                                    playerIndex: index,
                                    playerImage: value.playersList.length == 0
                                        ? ""
                                        : value.playersList[index].playerImage,
                                    playerName: value.playersList.length == 0
                                        ? " "
                                        : value.playersList[index].playerName,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      value.playersList.length < 7
                          ? AddPLayerContainer(() {
                              return showDialog(
                                context: context,
                                builder: (context) {
                                  int characterIndex = 0;
                                  return StatefulBuilder(
                                      builder: (context, setstate) {
                                    return ZoomIn(
                                      child: Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0))),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                          },
                                          child: Container(
                                            width: 400,
                                            height: 450,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    "assets/images/gameBackground.jpg",
                                                  ),
                                                  fit: BoxFit.cover,
                                                )),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                AutoSizeText(
                                                  'اختر شحصيتك و سجل اسمك',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                    width: double.infinity,
                                                    height: 180,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: value
                                                          .charactersImages
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                setstate(() {
                                                                  characterIndex =
                                                                      index;
                                                                });
                                                              },
                                                              child:
                                                                  AnimatedContainer(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        300),
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                width:
                                                                    characterIndex ==
                                                                            index
                                                                        ? 100
                                                                        : 70,
                                                                height:
                                                                    characterIndex ==
                                                                            index
                                                                        ? 100
                                                                        : 70,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    width: 2,
                                                                    color: characterIndex ==
                                                                            index
                                                                        ? ColorManager
                                                                            .successColor
                                                                        : Colors
                                                                            .white,
                                                                  ),
                                                                  image:
                                                                      DecorationImage(
                                                                    image: AssetImage(
                                                                        value.charactersImages[
                                                                            index]),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            characterIndex ==
                                                                    index
                                                                ? Icon(
                                                                    FontAwesomeIcons
                                                                        .handPointUp,
                                                                    color: Colors
                                                                        .white,
                                                                  )
                                                                : Container(),
                                                          ],
                                                        );
                                                      },
                                                    )),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Container(
                                                    width: 300,
                                                    height: 60,
                                                    child: TextField(
                                                      controller:
                                                          _textEditingController,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      decoration:
                                                          InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 2),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              filled: true,
                                                              hintStyle: TextStyle(
                                                                  color:
                                                                      Colors.grey[
                                                                          600],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              hintText:
                                                                  "اسم اللاعب",
                                                              fillColor: Colors
                                                                  .white70),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                RoundedActionButton(
                                                  btnColor:
                                                      ColorManager.successColor,
                                                  title: "إضافة",
                                                  btnFunc: () {
                                                    Navigator.pop(context);

                                                    Provider.of<PlayersProvider>(
                                                            context,
                                                            listen: false)
                                                        .addPlayer(
                                                            Players(
                                                              playerImage:
                                                                  playersImages[
                                                                      characterIndex],
                                                              playerName:
                                                                  _textEditingController
                                                                      .text,
                                                              playerScore: 0,
                                                            ),
                                                            currentIndex,
                                                            characterIndex);
                                                    player.play(
                                                        "sounds/addPlayerSuccess.mp3");
                                                    setState(() {
                                                      currentIndex++;
                                                      _textEditingController
                                                          .clear();
                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                },
                              );
                            })
                          : Container()
                    ],
                  ),
                );

                // return Stack(
                //   children: [
                //     Lottie.asset('assets/lotties/bg_top.json',
                //         repeat: true, fit: BoxFit.fill),
                //     currentIndex == 0
                //         ? Align(
                //             child: Container(
                //               height: WidgetsBinding
                //                           .instance.window.viewInsets.bottom >
                //                       0.0
                //                   ? 90
                //                   : 350,
                //               padding: EdgeInsets.only(top: 10),
                //               child: AutoSizeText(
                //                 "اضف على الأقل 3 لاعبين ثم اضغط ابدأ",
                //                 style: TextStyle(
                //                     fontSize: 19,
                //                     fontWeight: FontWeight.bold,
                //                     color: ColorManager.primary),
                //               ),
                //             ),
                //           )
                //         : Container(),
                //     SizedBox(
                //       height: 30,
                //     ),
                //     SlideTransition(
                //       position: _animationList[0],
                //       child: Visibility(
                //           visible: showNames[0],
                //           child: Center(F
                //             child: CloudName(value.names[0]),
                //           )),
                //     ),
                //     SlideTransition(
                //       position: _animationList[1],
                //       child: Visibility(
                //         visible: showNames[1],
                //         child: Center(child: CloudName(value.names[1])),
                //       ),
                //     ),
                //     SlideTransition(
                //       position: _animationList[2],
                //       child: Visibility(
                //         visible: showNames[2],
                //         child: Center(child: CloudName(value.names[2])),
                //       ),
                //     ),
                //     SlideTransition(
                //       position: _animationList[3],
                //       child: Visibility(
                //         visible: showNames[3],
                //         child: Center(child: CloudName(value.names[3])),
                //       ),
                //     ),
                //     SlideTransition(
                //       position: _animationList[4],
                //       child: Visibility(
                //         visible: showNames[4],
                //         child: Center(child: CloudName(value.names[4])),
                //       ),
                //     ),
                //     SlideTransition(
                //       position: _animationList[5],
                //       child: Visibility(
                //         visible: showNames[5],
                //         child: Center(child: CloudName(value.names[0])),
                //       ),
                //     ),
                //     SlideTransition(
                //       position: _animationList[6],
                //       child: Visibility(
                //         visible: showNames[6],
                //         child: Center(child: CloudName(value.names[5])),
                //       ),
                //     ),
                //     Align(
                //         alignment: Alignment.bottomCenter,
                //         child: Row(
                //           children: [
                //             value.playersList.length < 3
                //                 ? Expanded(
                //                     flex: 1,
                //                     child: Container(
                //                       width: 90,
                //                       height: 40,
                //                     ),
                //                   )
                //                 : Expanded(
                //                     flex: 1,
                //                     child: Container(
                //                       width: 90,
                //                       height: 40,
                //                       child: RoundedButton(
                //                         title: "يلا بينا",
                //                         onTapped: () {
                //                           Navigator.push(
                //                               context,
                //                               MaterialPageRoute(
                //                                 builder: (context) =>
                //                                     WhoIsOut(),
                //                               ));
                //                         },
                //                       ),
                //                     )),
                //             Card(
                //                 elevation: 5,
                //                 child: Container(
                //                   decoration: BoxDecoration(
                //                       boxShadow: [
                //                         BoxShadow(
                //                           color: Colors.grey.withOpacity(0.5),
                //                           spreadRadius: 5,
                //                           blurRadius: 7,
                //                           offset: Offset(0,
                //                               3), // changes position of shadow
                //                         ),
                //                       ],
                //                       color: ColorManager.primary,
                //                       borderRadius: BorderRadius.circular(10)),
                //                   width: 250,
                //                   height: 50,
                //                   child: Form(
                //                     key: _formKey,
                //                     child: Row(
                //                       children: [
                //                         Expanded(
                //                             child: Padding(
                //                           padding: const EdgeInsets.only(
                //                               left: 10, bottom: 5),
                //                           child: Directionality(
                //                             textDirection: TextDirection.rtl,
                //                             child: TextFormField(
                //                               style: TextStyle(
                //                                   color: Colors.white),
                //                               validator: (text) {
                //                                 if (value.playersList.length <
                //                                     7) {
                //                                   if (value
                //                                       .checkPlayerExist(text)) {
                //                                     return "اسم اللاعب موجود قبل كدة";
                //                                   } else if (text == '') {
                //                                     return "اسم اللاعب اييه";
                //                                   }
                //                                 }

                //                                 return null;
                //                               },
                //                               controller:
                //                                   _textEditingController,
                //                               decoration: InputDecoration(
                //                                 hintText: "اسم اللاعب",
                //                                 errorStyle: TextStyle(
                //                                   color: Colors.white,
                //                                 ),
                //                                 hintStyle: TextStyle(
                //                                     color: Colors.white),
                //                                 enabledBorder:
                //                                     UnderlineInputBorder(
                //                                   borderSide: BorderSide(
                //                                       color: Colors.white),
                //                                 ),
                //                                 focusedBorder:
                //                                     UnderlineInputBorder(
                //                                   borderSide: BorderSide(
                //                                       color: Colors.white),
                //                                 ),
                //                               ),
                //                             ),
                //                           ),
                //                         )),
                //                         value.playersList.length < 8
                //                             ? Padding(
                //                                 padding:
                //                                     const EdgeInsets.all(4.0),
                //                                 child: FloatingActionButton(
                //                                     backgroundColor:
                //                                         Colors.white,
                //                                     child: Icon(Icons.add,
                //                                         color: Colors.black),
                //                                     onPressed: () {
                //                                       if (!_formKey.currentState
                //                                           .validate()) {
                //                                         return;
                //                                       }
                //                                       if (value.playersList
                //                                               .length <
                //                                           7) {
                //                                         Provider.of<PlayersProvider>(
                //                                                 context,
                //                                                 listen: false)
                //                                             .addPlayer(
                //                                                 Players(
                //                                                   playerName:
                //                                                       _textEditingController
                //                                                           .text,
                //                                                   playerScore:
                //                                                       0,
                //                                                 ),
                //                                                 currentIndex);
                //                                         setState(() {
                //                                           showNames[
                //                                                   currentIndex] =
                //                                               true;

                //                                           _animationControllerList[
                //                                                   currentIndex]
                //                                               .forward();
                //                                           currentIndex++;
                //                                           _textEditingController
                //                                               .clear();
                //                                         });
                //                                       } else {
                //                                         Fluttertoast.showToast(
                //                                             msg:
                //                                                 "وصلت لأقصي عدد من اللاعيبة",
                //                                             backgroundColor:
                //                                                 ColorManager
                //                                                     .failColor);
                //                                       }
                //                                     }
                //                                     // showDialog(
                //                                     //   context: context,
                //                                     //   builder: (context) {
                //                                     //     return AddPlayerDialog(
                //                                     //       index: currentIndex,
                //                                     //       callBackFun: () {
                //                                     //         setState(() {
                //                                     //           showNames[
                //                                     //                   currentIndex] =
                //                                     //               true;

                //                                     //           _animationControllerList[
                //                                     //                   currentIndex]
                //                                     //               .forward();
                //                                     //           currentIndex++;
                //                                     //         });
                //                                     //       },
                //                                     //     );
                //                                     //   },
                //                                     // );

                //                                     ),
                //                               )
                //                             : Container(),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10.0),
                //                 )),
                //           ],
                //         )),
                //   ],
                // );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AddPLayerContainer extends StatelessWidget {
  final Function ontaaped;
  AddPLayerContainer(this.ontaaped);
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 1,
      dashPattern: [3, 3],
      borderType: BorderType.RRect,
      radius: Radius.circular(10),
      color: Colors.white,
      child: Container(
        height: 75,
        width: 360,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              DottedBorder(
                borderType: BorderType.Circle,
                color: Colors.white,
                strokeWidth: 1,
                dashPattern: [3, 3],
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              AutoSizeText(
                "لاعب جديد",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: ontaaped,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorManager.successColor.withAlpha(200),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.successColor.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.transparent.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedActionButton extends StatelessWidget {
  final Color btnColor;
  final String title;
  final Function btnFunc;
  const RoundedActionButton({
    this.btnColor,
    this.title,
    this.btnFunc,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btnFunc,
      child: Container(
        height: 45,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: AutoSizeText(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: btnColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}

class PLayerContainer extends StatelessWidget {
  final int playerIndex;
  final String playerName;
  final String playerImage;
  const PLayerContainer({
    this.playerIndex,
    this.playerName,
    this.playerImage,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 360,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: Colors.white,
                  ),
                  image: DecorationImage(
                      image: AssetImage(playerImage), fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 15,
            ),
            AutoSizeText(
              playerName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                Provider.of<PlayersProvider>(context, listen: false)
                    .removePlayer(playerIndex);
              },
              child: Icon(
                FontAwesomeIcons.times,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: ColorManager.playersCardsColor[playerIndex],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorManager.playersCardsColor[playerIndex].withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
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
    return BounceInUp(
      child: Stack(
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
            child: AutoSizeText(
              name,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
