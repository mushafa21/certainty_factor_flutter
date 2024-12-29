import 'dart:math';

import 'package:certainty_factor/model/answer_model.dart';
import 'package:certainty_factor/model/rules_group_model.dart';
import 'package:certainty_factor/model/rules_model.dart';

final List<RulesGroupModel> rulesGroupList = [
  RulesGroupModel(
    rules: [
      RulesModel(anteseden: "bodi mulus", cfRules: 0.6),
      RulesModel(anteseden: "layar bagus", cfRules: 0.6),
    ],
    consequence: "kondisi fisik bagus",
  ),

  RulesGroupModel(
    rules: [
      RulesModel(anteseden: "sinyal normal", cfRules: 0.7),
      RulesModel(anteseden: "suara baik", cfRules: 0.6),
    ],
    consequence: "fungsi bagus",
  ),
];

final List<AnswerModel> answerList = [
  AnswerModel(answer: "Ya", cfFact: 1),
  AnswerModel(answer: "Tidak", cfFact: -1),
  AnswerModel(answer: "Ragu-Ragu", cfFact: -0.1),
  AnswerModel(answer: "Mungkin", cfFact: 0.7),
  AnswerModel(answer: "Mungkin Tidak", cfFact: -0.8),
];


double calculateCf({required RulesGroupModel rulesGroup}){
  double cfConclusion = rulesGroup.rules.first.cfRules * rulesGroup.rules.first.answer!.cfFact;
  for(int i = 1;  i < rulesGroup.rules.length ;  i++){
    cfConclusion = calculateTwoCf(cf1: cfConclusion,cf2:  rulesGroup.rules[i].cfRules * rulesGroup.rules[i].answer!.cfFact);
  }
  return cfConclusion;
}


double calculateTwoCf({required double cf1, required double cf2}){
  if(cf1 >= 0 && cf2 >= 0){
    return cf1 + cf2 * (1-cf1);
  } else if(cf1 < 0 && cf2 < 0){
    return cf1 + cf2 * (1+cf1);
  } else {
    return (cf1 + cf2) / (1-min(cf1.abs(), cf2.abs()));
  }

}

double mapRange(double value, double oldMin, double oldMax, double newMin, double newMax) {
  return (value - oldMin) * (newMax - newMin) / (oldMax - oldMin) + newMin;
}
