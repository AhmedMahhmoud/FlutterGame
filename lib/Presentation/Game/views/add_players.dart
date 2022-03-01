import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/Domain/Models/PlayersModel.dart';
import 'package:flutter_game/Presentation/Game/views/who_is_out.dart';
import 'package:flutter_game/Presentation/Game/widgets/add_player_container.dart';
import 'package:flutter_game/Presentation/Game/widgets/player_container.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/Shared/constantData.dart';
import 'package:flutter_game/core/Shared/rounded_action_button.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AddPlayerScreen extends StatefulWidget {
  @override
  _AddPlayerScreenState createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen>
    with TickerProviderStateMixin {
  AudioCache player = AudioCache();
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<PlayersProvider>(context, listen: false).resetPlayers();
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
                                                    if (value.checkPlayerExist(
                                                        _textEditingController
                                                            .text)) {
                                                      showToast(
                                                        'اسم اللاعب موجود قبل كدة',
                                                        context: context,
                                                        animation:
                                                            StyledToastAnimation
                                                                .scale,
                                                        reverseAnimation:
                                                            StyledToastAnimation
                                                                .fade,
                                                        position:
                                                            StyledToastPosition
                                                                .center,
                                                        animDuration: Duration(
                                                            seconds: 1),
                                                        duration: Duration(
                                                            seconds: 4),
                                                        curve:
                                                            Curves.elasticOut,
                                                        reverseCurve:
                                                            Curves.linear,
                                                      );
                                                    } else {
                                                      Navigator.pop(context);
                                                      value.addPlayer(
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
                                                    }
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
                          : Container(),
                      SizedBox(
                        height: 20,
                      ),
                      value.playersList.length < 3
                          ? Container()
                          : RoundedActionButton(
                              btnColor: ColorManager.successColor,
                              title: "يلا بينا",
                              btnFunc: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: WhoIsOut(),
                                      curve: Curves.bounceInOut,
                                      inheritTheme: true,
                                      ctx: context),
                                );
                              },
                            )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
