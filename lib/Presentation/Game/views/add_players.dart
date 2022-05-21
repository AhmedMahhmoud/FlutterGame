import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'who_is_out.dart';
import '../../../Data/Providers/Players/players_provider.dart';
import '../../../Database/players_db.dart';
import '../../../Domain/Models/player_model.dart';
import '../widgets/add_player_container.dart';
import '../widgets/player_container.dart';
import '../../../core/ColorManager/ColorManager.dart';
import '../../../core/Shared/rounded_action_button.dart';
import '../../../core/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPlayerScreen extends StatefulWidget {
  final bool resetPlayers;
  const AddPlayerScreen(this.resetPlayers);
  @override
  _AddPlayerScreenState createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen>
    with TickerProviderStateMixin {
  AudioCache player = AudioCache();
  final TextEditingController _textEditingController = TextEditingController();
  final PlayersDB _playersDB = PlayersDB();
  @override
  void initState() {
    super.initState();
    // if (widget.resetPlayers) {
    //   Provider.of<PlayersProvider>(context, listen: false).resetPlayers();
    // }
  }

  int currentIndex = 0;
  void setCurrentIndex() {
    setState(() {
      currentIndex++;
    });
  }

  double listHeight = 95.h;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/gameBackground.jpg',
                      ),
                      fit: BoxFit.fill)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Consumer<PlayersProvider>(
                builder: (BuildContext context, PlayersProvider value, _) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 840.h,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              AutoSizeText(
                                'اللاعبين',
                                style: TextStyle(
                                    fontSize: setResponsiveFontSize(25),
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height: listHeight * value.playersList.length,
                                margin: EdgeInsets.symmetric(horizontal: 15.w),
                                child: ListView.builder(
                                  itemCount: value.playersList.isEmpty
                                      ? 1
                                      : value.playersList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return BounceInRight(
                                      child: Visibility(
                                        visible: value.playersList.isNotEmpty,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.h),
                                          child: PLayerContainer(
                                            playerIndex: index,
                                            playerImage:
                                                value.playersList.isEmpty
                                                    ? ''
                                                    : value.playersList[index]
                                                        .playerImage,
                                            playerName:
                                                value.playersList.isEmpty
                                                    ? ' '
                                                    : value.playersList[index]
                                                        .playerName,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              value.playersList.length < 8
                                  ? AddPLayerContainer(() {
                                      return showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          int characterIndex = 0;
                                          return StatefulBuilder(builder:
                                              (BuildContext context, setstate) {
                                            return FadeInDown(
                                              child: Dialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15.0))),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                  child: Container(
                                                    width: 400.w,
                                                    height: 450.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        image:
                                                            const DecorationImage(
                                                          image: AssetImage(
                                                            'assets/images/gameBackground.jpg',
                                                          ),
                                                          fit: BoxFit.cover,
                                                        )),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        AutoSizeText(
                                                          'اختر شخصيتك و سجل اسمك',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  setResponsiveFontSize(
                                                                      18),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                double.infinity,
                                                            height: 180.h,
                                                            child: ListView
                                                                .builder(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemCount: value
                                                                  .charactersImages
                                                                  .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return Column(
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setstate(
                                                                            () {
                                                                          characterIndex =
                                                                              index;
                                                                        });
                                                                      },
                                                                      child:
                                                                          AnimatedContainer(
                                                                        duration:
                                                                            const Duration(milliseconds: 300),
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10.w),
                                                                        width: characterIndex ==
                                                                                index
                                                                            ? 100.w
                                                                            : 70.w,
                                                                        height: characterIndex ==
                                                                                index
                                                                            ? 100.h
                                                                            : 70.h,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          border:
                                                                              Border.all(
                                                                            width:
                                                                                2.w,
                                                                            color: characterIndex == index
                                                                                ? ColorManager.successColor
                                                                                : Colors.white,
                                                                          ),
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                AssetImage(value.charactersImages[index]),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          5.h,
                                                                    ),
                                                                    characterIndex ==
                                                                            index
                                                                        ? const Icon(
                                                                            FontAwesomeIcons.handPointUp,
                                                                            color:
                                                                                Colors.white,
                                                                          )
                                                                        : Container(),
                                                                  ],
                                                                );
                                                              },
                                                            )),
                                                        Directionality(
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          child: SizedBox(
                                                            width: 300.w,
                                                            height: 100.h,
                                                            child: TextField(
                                                              controller:
                                                                  _textEditingController,
                                                              maxLength: 12,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      setResponsiveFontSize(
                                                                          16)),
                                                              decoration:
                                                                  InputDecoration(
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                Colors.black,
                                                                            width: 2.w),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      filled:
                                                                          true,
                                                                      hintStyle: TextStyle(
                                                                          color: Colors.grey[
                                                                              600],
                                                                          fontSize: setResponsiveFontSize(
                                                                              16),
                                                                          fontWeight: FontWeight
                                                                              .bold),
                                                                      hintText:
                                                                          'اسم اللاعب',
                                                                      fillColor:
                                                                          Colors
                                                                              .white70),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        RoundedActionButton(
                                                          btnColor: ColorManager
                                                              .successColor,
                                                          title: 'إضافة',
                                                          btnFunc: () {
                                                            if (value.checkPlayerExist(
                                                                _textEditingController
                                                                    .text
                                                                    .trim())) {
                                                              showAnimatedToast(
                                                                  context,
                                                                  'اسم اللاعب موجود قبل كدة');
                                                            } else if (_textEditingController
                                                                    .text
                                                                    .trim() ==
                                                                '') {
                                                              showAnimatedToast(
                                                                  context,
                                                                  'اسم اللاعب فاضي');
                                                            } else {
                                                              Navigator.pop(
                                                                  context);
                                                              Players
                                                                  currentPlayer =
                                                                  Players(
                                                                playerImage: value
                                                                        .charactersImages[
                                                                    characterIndex],
                                                                playerName:
                                                                    _textEditingController
                                                                        .text
                                                                        .trim(),
                                                                playerScore: 0,
                                                              );
                                                              value.addPlayer(
                                                                  currentPlayer,
                                                                  currentIndex,
                                                                  characterIndex);
                                                              player.play(
                                                                  'sounds/addPlayerSuccess.mp3');
                                                              _playersDB
                                                                  .insertPlayer(
                                                                      currentPlayer);
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
                            ],
                          ),
                        ),
                        value.playersList.length < 3
                            ? Container()
                            : RoundedActionButton(
                                btnColor: ColorManager.successColor,
                                title: 'يلا بينا',
                                btnFunc: () {
                                  navigateToPage(context, WhoIsOut());
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
      ),
    );
  }
}
