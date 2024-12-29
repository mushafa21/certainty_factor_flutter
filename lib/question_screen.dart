import 'package:certainty_factor/model/answer_model.dart';
import 'package:certainty_factor/model/rules_group_model.dart';
import 'package:certainty_factor/model/rules_model.dart';
import 'package:certainty_factor/result_screen.dart';
import 'package:certainty_factor/utility/utility.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentIndex = 0;
  final List<RulesGroupModel> _rulesList = [];

  @override
  void initState() {
    super.initState();
    _rulesList.addAll(rulesGroupList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: RulesGroupItem(rulesGroupModel: _rulesList[_currentIndex], onUpdated: (updatedList){
                _rulesList[_currentIndex] = updatedList;
                setState(() {

                });
              }),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(20),
            child: ElevatedButton(onPressed: _rulesList[_currentIndex].rules.firstWhereOrNull((e)=> e.answer == null) == null ? (){
              if(_currentIndex == (_rulesList.length - 1)){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ResultScreen(rulesGroup: _rulesList)));
              } else{
                _currentIndex += 1;
                setState(() {

                });
              }
            } : null, child: Text("Lanjur")),
          )
        ],
      ),
    );
  }
}

class RulesGroupItem extends StatefulWidget {
  final RulesGroupModel rulesGroupModel;
  final Function(RulesGroupModel) onUpdated;

  const RulesGroupItem({super.key, required this.rulesGroupModel, required this.onUpdated});

  @override
  State<RulesGroupItem> createState() => _RulesGroupItemState();
}

class _RulesGroupItemState extends State<RulesGroupItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(itemBuilder: (context,index){
          return RulesItem(rulesModel: widget.rulesGroupModel.rules[index], onUpdated: (rules){
            widget.rulesGroupModel.rules[index] = rules;
            widget.onUpdated(widget.rulesGroupModel);
            setState(() {

            });
          });
        },itemCount: widget.rulesGroupModel.rules.length,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),)
      ],
    );
  }
}

class RulesItem extends StatefulWidget {
  final RulesModel rulesModel;
  final Function(RulesModel) onUpdated;
  RulesItem({super.key, required this.rulesModel, required this.onUpdated});

  @override
  State<RulesItem> createState() => _RulesItemState();
}

class _RulesItemState extends State<RulesItem> {
  final List<AnswerModel> _answerList = answerList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Apakah ${widget.rulesModel.anteseden}?"),
        SizedBox(height: 10,),
        ListView.builder(itemBuilder: (context,index){
          return AnswerItem(answerModel: _answerList[index], selectedAnswer: widget.rulesModel.answer, onSelected: (){
            widget.rulesModel.answer = _answerList[index];
            widget.onUpdated(widget.rulesModel);
            setState(() {

            });
          });
        },itemCount: _answerList.length,physics: NeverScrollableScrollPhysics(),shrinkWrap: true,)
      ],
    );
  }
}

class AnswerItem extends StatelessWidget {
  final AnswerModel answerModel;
  final AnswerModel? selectedAnswer;
  final Function() onSelected;

  const AnswerItem(
      {super.key,
      required this.answerModel,
      required this.selectedAnswer,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
        title: Text(answerModel.answer),
        value: answerModel,
        groupValue: selectedAnswer,
        onChanged: (value) {
          onSelected();
        });
  }
}
