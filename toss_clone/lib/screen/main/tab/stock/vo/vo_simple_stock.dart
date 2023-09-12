class SimpleStock{
  final String stockName;

  SimpleStock(this.stockName);

  //factory: 생성자랑 비슷, 가공할 수 있는 파라미터를 가지고 돌려줌
  factory SimpleStock.fromJson(dynamic json){
    return SimpleStock(json['name']);
  }

  @override
  String toString() {
    return stockName;
  }
}