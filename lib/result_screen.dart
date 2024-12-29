

import 'package:certainty_factor/model/rules_group_model.dart';
import 'package:certainty_factor/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ResultScreen extends StatelessWidget {
  final List<RulesGroupModel> rulesGroup;
  const ResultScreen({super.key, required this.rulesGroup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hasil"),
      ),
      body: SafeArea(child: ListView.builder(itemBuilder: (context,index){
        return ResultItem(rulesGroupModel: rulesGroup[index]);
      },shrinkWrap: true,itemCount: rulesGroup.length,)),

    );
  }
}


class ResultItem extends StatelessWidget {
  final RulesGroupModel rulesGroupModel;
  const ResultItem({super.key, required this.rulesGroupModel});

  @override
  Widget build(BuildContext context) {
    double cf = calculateCf(rulesGroup: rulesGroupModel);
    double star = mapRange(cf, -1, 1, 1, 5);
    return ListTile(
      title: Text("${rulesGroupModel.consequence} ${star.toStringAsFixed(1)}/5"),
      trailing: RatingBar.builder(
        initialRating: star,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
      )
    );
  }
}

