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
class BetInfo {
  final String createTime;
  final String amount;
  final String profitLoss;

  BetInfo({required this.createTime, required this.amount, required this.profitLoss});

  factory BetInfo.fromJson(Map<String, dynamic> json) {
    return BetInfo(
      createTime: json['createTime'],
      amount: json['amount'],
      profitLoss: json['profitLoss'],
    );
  }
}

class GetBetInfoModel {
  final String? profitLossTotal ;
  final List<BetInfo> betInfoList;

  GetBetInfoModel({required this.profitLossTotal, required this.betInfoList});

  factory GetBetInfoModel.fromJson(Map<String, dynamic> json) {
    var betInfoListJson = json['betInfoList'] as List;
    List<BetInfo> betInfoList =
    betInfoListJson.map((betInfoJson) => BetInfo.fromJson(betInfoJson)).toList();

    return GetBetInfoModel(
      profitLossTotal: json['profitLossTotal'],
      betInfoList: betInfoList,
    );
  }
}