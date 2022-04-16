// import 'package:animate_do/animate_do.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_game/Data/Providers/Players/PlayersProvider.dart';
// import 'package:flutter_game/Domain/Models/PlayersModel.dart';
// import 'package:flutter_game/core/ColorManager/ColorManager.dart';
// import 'package:flutter_game/core/constants.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';

// class AddPlayerDialog extends StatefulWidget {
//   final int index;
//   final Function callBackFun;
//   AddPlayerDialog({this.callBackFun, this.index});
//   @override
//   _AddPlayerDialogState createState() => _AddPlayerDialogState();
// }

// TextEditingController _textEditingController = TextEditingController();
// final _formKey = GlobalKey<FormState>();

// class _AddPlayerDialogState extends State<AddPlayerDialog> {
//   @override
//   void initState() {
//     _textEditingController.clear();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ZoomIn(
//       child: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Directionality(
//           textDirection: TextDirection.rtl,
//           child: AlertDialog(
//             insetPadding: EdgeInsets.symmetric(
//               horizontal: 30.0,
//               vertical: 70.0,
//             ),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(15.0))),
//             content: Form(
//               key: _formKey,
//               child: Container(
//                 height: 160,
//                 width: 500,
//                 child: StatefulBuilder(
//                   builder: (context, setState) {
//                     return Column(
//                       children: [
//                         AutoSizeText(
//                           "اضف اسم اللاعب",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         Divider(
//                           thickness: 1,
//                         ),
//                         Expanded(
//                             child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Container(
//                               child: TextFormField(
//                                 onFieldSubmitted: (_) {},
//                                 textInputAction: TextInputAction.next,
//                                 validator: (text) {
//                                   if (Provider.of<PlayersProvider>(context,
//                                           listen: false)
//                                       .checkPlayerExist(text)) {
//                                     return "اسم اللاعب موجود قبل كدة";
//                                   }
//                                   return null;
//                                 },
//                                 controller: _textEditingController,
//                                 decoration: kTextFieldDecorationWhite.copyWith(
//                                     errorStyle:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                     hintText: 'اسم اللاعب',
//                                     suffixIcon: Icon(
//                                       Icons.person,
//                                       color: ColorManager.primary,
//                                     )),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     if (_textEditingController.text == "") {
//                                       Fluttertoast.showToast(
//                                           msg: "اسم اللاعب اييه ",
//                                           textColor:
//                                               ColorManager.backGroundColor,
//                                           backgroundColor:
//                                               ColorManager.failColor);
//                                     } else {
//                                       if (!_formKey.currentState.validate()) {
//                                         return;
//                                       }

//                                       Provider.of<PlayersProvider>(context,
//                                               listen: false)
//                                           .addPlayer(
//                                               Players(
//                                                 playerName:
//                                                     _textEditingController.text,
//                                                 playerScore: 0,
//                                               ),
//                                               widget.index);
//                                       widget.callBackFun();
//                                       Navigator.pop(context);
//                                     }
//                                   },
//                                   child: Icon(
//                                     Icons.check,
//                                     color: ColorManager.successColor,
//                                     size: 30,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Icon(
//                                     FontAwesomeIcons.times,
//                                     color: ColorManager.failColor,
//                                   ),
//                                 )
//                               ],
//                             )
//                           ],
//                         ))
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
