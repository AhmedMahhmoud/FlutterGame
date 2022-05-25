import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../Data/Providers/Players/players_provider.dart';
import 'add_players.dart';
import '../widgets/player_container.dart';
import '../../Home/views/home.dart';
import '../../../core/ColorManager/ColorManager.dart';
import '../../../core/Shared/rounded_action_button.dart';
import '../../../core/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

double listHeight = 90.h;

class FinalResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child
          : WillPopScope(
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => Home()),
              ModalRoute.withName('/Home'));
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/gameBackground.jpg',
                    ),
                    fit: BoxFit.fill)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Consumer<PlayersProvider>(
              builder:
                  (BuildContext context, PlayersProvider value, Widget child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      AutoSizeText(
                        'النتيجة',
                        style: TextStyle(
                            fontSize: setResponsiveFontSize(25),
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: listHeight * value.playersList.length,
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        child: ListView.builder(
                          itemCount: value.playersList.isEmpty
                              ? 1
                              : value.playersList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return BounceInRight(
                              child: Visibility(
                                visible: value.playersList.isNotEmpty,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6.h),
                                  child: PlayerRanking(
                                    playerScore:
                                        value.playersList[index].playerScore,
                                    playerIndex: index,
                                    playerImage: value.playersList.isEmpty
                                        ? ''
                                        : value.playersList[index].playerImage,
                                    playerName: value.playersList.isEmpty
                                        ? ' '
                                        : value.playersList[index].playerName,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          RoundedActionButton(
                            btnColor: ColorManager.successColor,
                            title: 'دور جديد',
                            btnFunc: () {
                              navigatePushAnfRemoveUntilToPage(
                                  context, const AddPlayerScreen(false));
                            },
                          ),
                          RoundedActionButton(
                            btnColor: ColorManager.failColor,
                            title: 'فورة جديدة',
                            btnFunc: () {
                              value.playersList.forEach((player) {player.playerScore=0; });
                              navigateReplacmentToPage(context, Home());
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
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
