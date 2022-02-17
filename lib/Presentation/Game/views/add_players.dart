import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
import 'package:flutter_game/Domain/Models/PlayersModel.dart';
import 'package:flutter_game/Presentation/Game/views/who_is_out.dart';
import 'package:flutter_game/Presentation/Game/widgets/add_player_dialog.dart';
import 'package:flutter_game/core/ColorManager/ColorManager.dart';
import 'package:flutter_game/core/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AddPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          Provider.of<PlayersProvider>(context).playersList.length < 8
              ? FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AddPlayerDialog();
                      },
                    );
                  },
                )
              : Container(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Consumer<PlayersProvider>(
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    "اضف على الأقل 3 لاعبين ثم اضغط التالي",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                AutoSizeText(
                                    value.playersList[index].playerName),
                                SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    value.removePlayer(index);
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    color: ColorManager.failColor,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: value.playersList.length,
                      ),
                    ),
                  ),
                  Spacer(),
                  value.playersList.length < 3
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(bottom: 50),
                          child: InkWell(
                            onTap: () {},
                            child: RoundedButton(
                              title: "التالى",
                              onTapped: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WhoIsOut(),
                                    ));
                              },
                            ),
                          ),
                        )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
