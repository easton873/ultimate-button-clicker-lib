// import 'package:button_clicker/game/clicker.dart';
// import 'package:button_clicker/game/clicker_presenter.dart';
// import 'package:button_clicker/game/const.dart';
// import 'package:button_clicker/game/game_data.dart';
// import 'package:button_clicker/game/loadout_manager.dart';
// import 'package:button_clicker/game/mco.dart';
// import 'package:button_clicker/ui/pages/game_side_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class BuildYourOwnPage extends GameSidePage {
//   const BuildYourOwnPage({super.key});

//   @override
//   State<BuildYourOwnPage> createState() => _BuildYourOwnPageState();
// }

// class _BuildYourOwnPageState extends GameSidePageState<BuildYourOwnPage> {
//   final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
//   final LevelBuilder builder = LevelBuilder();

//   void _addItem() {
//     if (_formKey.currentState!.validate()) {
//       final String nameText = builder.nameController.text.trim();
//       final String summaryText = builder.summaryTextController.text.trim();
//       final String thingProducedText = builder.thingProducedController.text.trim();
//       final String thingProducedPluralText = builder.thingProducedPluralController.text.trim();
//       final String bonusNameText = builder.bonusNameController.text.trim();
//       final String bonusPluralText = builder.bonusPluralController.text.trim();
//       final double bonusRate = double.tryParse(builder.bonusRateController.text) ?? 0;
//       final int bonusCost = int.tryParse(builder.bonusCostController.text) ?? 1;
//       final int winningPoint = int.tryParse(builder.winningPointController.text) ?? 1;
//       List<Clicker> clickers = [
//         for (ClickerBuilder cb in builder.clickers) 
//           ClickerPresenter(
//             cb.nameController.text, 0, double.tryParse(cb.costController.text) ?? 1.0, 
//             double.tryParse(cb.cpsController.text) ?? 0.0, 
//             double.tryParse(cb.costRateController.text) ?? 1.1,
//           )
//       ];
//       GameData newData = GameData.fromUserInput(nameText, summaryText, thingProducedText, thingProducedPluralText, bonusNameText, bonusPluralText, bonusRate, bonusCost, 1.0, winningPoint, clickers);
//       LoadoutManager.loadouts[newData.saveKey] = newData;
//       MCO().settings.unlock(nameText);
//       setState(() {
//         builder.clear();
//         MCO().forceUpdate();
//       });
//     }
//   }

//   @override
//   Widget getFloatingActionButton() {
//     return FloatingActionButton(
//       onPressed: (){
//         setState(() {
//           builder.clickers.add(ClickerBuilder());
//         });
//       },
//       tooltip: 'Add',
//       shape: const CircleBorder(),
//       backgroundColor: Colors.yellow,
//       child: const Icon(Icons.add),
//     );
//   }

//   @override
//   Widget buildWidget(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           Expanded(
//             child: Container(
//               decoration:const BoxDecoration(
//                 color: Colors.white,//.withOpacity(.7)
//               ),
//               child: SingleChildScrollView(
//                 physics: const ClampingScrollPhysics(),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       GameTextEntry(
//                         controller: builder.nameController,
//                         labelText: "Name",
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return 'Please enter some text';
//                           } else if (LoadoutManager.loadouts.containsKey(value)) {
//                             return 'Name already exists';
//                           }
//                           return null;
//                         },
//                       ),
//                       GameTextEntry(
//                         controller: builder.summaryTextController, 
//                         labelText: "Summary Text"
//                       ),
//                       GameTextEntry(
//                         controller: builder.thingProducedController, 
//                         labelText: "Thing Produced"
//                       ),
//                       GameTextEntry(
//                         controller: builder.thingProducedPluralController, 
//                         labelText: "Thing Produced Plural"
//                       ),
//                       GameTextEntry(
//                         controller: builder.bonusNameController, 
//                         labelText: "Name of Bonus"
//                       ),
//                       GameTextEntry(
//                         controller: builder.bonusPluralController, 
//                         labelText: "Plural Version of Bonus"
//                       ),
//                       NumberTextEntry(
//                         controller: builder.bonusRateController,
//                         labelText: "Bonus Rate",
//                       ),
//                       NumberTextEntry(
//                         controller: builder.bonusCostController, 
//                         labelText: "Bonus Cost",
//                         validator: greaterThanOneValidator,
//                       ),
//                       NumberTextEntry(
//                         controller: builder.winningPointController, 
//                         labelText: "How many bonuses til you win?",
//                         validator: greaterThanOneValidator,
//                       ),
//                       SizedBox(
//                         height: 200,
//                         child: ListView.builder(
//                           itemCount: builder.clickers.length,
//                           itemBuilder: (context, index) {
//                             return Column(
//                               children: [
//                                 GameTextEntry(
//                                   controller: builder.clickers[index].nameController,
//                                   labelText: "Clicker #$index Name",
//                                 ),
//                                 NumberTextEntry(
//                                   controller: builder.clickers[index].cpsController,
//                                   labelText: "Clicker #$index Clicks Per Second"
//                                 ),
//                                 NumberTextEntry(
//                                   controller: builder.clickers[index].costController,
//                                   labelText: "Clicker #$index Cost",
//                                 ),
//                                 NumberTextEntry(
//                                   controller: builder.clickers[index].costRateController,
//                                   labelText: "Clicker #$index Cost Increase Rate",
//                                   validator: greaterThanOneValidator,
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       ElevatedButton(
//                         onPressed: _addItem,
//                         child: const Text("Submit"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
//   @override
//   String getBackgroundImageName() {
//     return "${Constants.imagesPath}/custom.png";
//   }
// }

// class NumberTextEntry extends StatelessWidget {
//   final TextEditingController controller;
//   final String labelText;
//   final String? Function(String?) validator;
//   const NumberTextEntry({super.key, required this.controller, required this.labelText, this.validator = numberValidator});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: labelText,
//         border: const OutlineInputBorder(),
//       ),
//       validator: validator,
//       keyboardType: const TextInputType.numberWithOptions(decimal: true),
//       inputFormatters: <TextInputFormatter>[
//         FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))
//       ],
//     );
//   }
// }

// class GameTextEntry extends StatelessWidget {
//   const GameTextEntry({super.key, required this.controller, required this.labelText, this.validator = stringValidator});
//   final TextEditingController controller;
//   final String labelText;
//   final String? Function(String?) validator;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: labelText,
//         border: const OutlineInputBorder(),
//       ),
//       validator: stringValidator,
//     );
//   }
// }

// String? numberValidator(String? value) {
//   if (value == null || value.trim().isEmpty) {
//     return "Please enter a number";
//   } else {
//     double? numVal = double.tryParse(value);
//     if (numVal == null) {
//       return "Please enter a number";
//     }
//   }
//   return null;
// }

// String? greaterThanOneValidator(String? value) {
//   String? firstValidation = numberValidator(value);
//   if (firstValidation != null) {
//     return firstValidation;
//   } else {
//     double number = double.parse(value ?? "1.0");
//     if (number < 1.0) {
//       return "Must be at least 1.0";
//     }
//   }
//   return null;
// }

// String? stringValidator(String? value) {
//   if (value == null || value.trim().isEmpty) {
//     return "Please enter something";
//   }
//   return null;
// }

// class LevelBuilder {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController summaryTextController = TextEditingController();
//   TextEditingController thingProducedController = TextEditingController();
//   TextEditingController thingProducedPluralController = TextEditingController();
//   TextEditingController bonusNameController = TextEditingController();
//   TextEditingController bonusPluralController = TextEditingController();
//   TextEditingController bonusRateController = TextEditingController();
//   TextEditingController bonusCostController = TextEditingController();
//   TextEditingController winningPointController = TextEditingController();
//   List<ClickerBuilder> clickers = [];

//   clear() {
//     nameController.clear();
//     summaryTextController.clear();
//     thingProducedController.clear();
//     thingProducedPluralController.clear();
//     bonusNameController.clear();
//     bonusPluralController.clear();
//     bonusCostController.clear();
//     bonusRateController.clear();
//     winningPointController.clear();
//     clickers.clear();
//   }
// }

// class ClickerBuilder {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController cpsController = TextEditingController();
//   TextEditingController costController = TextEditingController();
//   TextEditingController costRateController = TextEditingController();
// }