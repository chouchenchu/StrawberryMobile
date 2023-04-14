/*class GetBetInfoModel{
 String? CreateTime="";
 String? Amount="0";
 GetBetInfoModel({required this.CreateTime,required this.Amount});

 GetBetInfoModel.fromJson(Map<String, dynamic> json) {
   CreateTime = json['createTime'];
   Amount = json['amount'];
 }
 Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = Map<String, dynamic>();
   data['createTime'] = CreateTime;
   data['amount'] = Amount;
   return data;
 }

}*/
class GetBetInfoModel {
  String? profitLossTotal;
  List<BetInfo>? betInfoList;
  GetBetInfoModel({required this.profitLossTotal, required this.betInfoList});

  GetBetInfoModel.fromJson(Map<String, dynamic> json) {
    profitLossTotal = json['ProfitLossTotal'];
    if (json['BetInfoList'] != null) {
      betInfoList = <BetInfo>[];
      json['BetInfoList'].forEach((v) {
        betInfoList?.add(BetInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProfitLossTotal'] = profitLossTotal;
    data['BetInfoList'] = betInfoList?.map((v) => v.toJson()).toList();
    return data;
  }
}

class BetInfo {
  String createTime="";
  String amount="";
  String profitLoss="";

  BetInfo({required this.createTime, required this.amount, required this.profitLoss});

  BetInfo.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    amount = json['amount'];
    profitLoss = json['profitLoss'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createTime'] = createTime;
    data['amount'] = amount;
    data['profitLoss'] = profitLoss;
    return data;
  }
}