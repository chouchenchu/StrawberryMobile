class GetBetInfoModel{
 String? CreateTime="";
 String? Amount="0";
 //Future<List<Map<String,dynamic>>> DataList;
 GetBetInfoModel({required this.CreateTime,required this.Amount});

 GetBetInfoModel.fromJson(Map<String, dynamic> json) {
   CreateTime = json['createTime'];
   Amount = json['amount'];
 }
//GetBetInfoModel.fromJsonToList(json){
  // DataList = List<Map<String,dynamic>>.from(json) as Future<List<Map<String, dynamic>>>;
//}
 Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = Map<String, dynamic>();
   data['createTime'] = CreateTime;
   data['amount'] = Amount;
   return data;
 }

}