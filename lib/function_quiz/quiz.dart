class Trader {
  String name;
  String city;

  Trader(this.name, this.city);
}

class Transaction {
  Trader trader;
  int year;
  int value;

  Transaction(this.trader, this.year, this.value);
}

final transactions = [
  Transaction(Trader("Brian", "Cambridge"), 2011, 300),
  Transaction(Trader("Raoul", "Cambridge"), 2012, 1000),
  Transaction(Trader("Raoul", "Cambridge"), 2011, 400),
  Transaction(Trader("Mario", "Milan"), 2012, 710),
  Transaction(Trader("Mario", "Milan"), 2012, 700),
  Transaction(Trader("Alan", "Cambridge"), 2012, 950),
];


void main() {
print('6. 케임브리지에 거주하는 거래자의 모든 트랙잭션값을 출력하시오');
transactions.where((element) => element.trader.city == "Cambridge")
    .toList().forEach((element) {print(transactions);
    });

}


// 6. 케임브리지에 거주하는 거래자의 모든 트랙잭션값을 출력하시오
void quiz6() {

}

// 7. 전체 트랜잭션 중 최대값은 얼마인가?
// 8. 전체 트랜잭션 중 최소값은 얼마인가?


// 1. 2011년에 일어난 모든 트랜잭션을 찾아 가격 기준 오름차순으로 정리하여 이름을 나열하시오
void quiz1() {
  print('// 1. 2011년에 일어난 모든 트랜잭션을 찾아 가격 기준 오름차순으로 정리하여 이름을 나열하시오');
  (transactions.where((e) => e.year == 2011).toList()
    ..sort((a, b) => a.value.compareTo(b.value)))
      .forEach((e) {
    print(e.trader.name);
  });
}

// 2. 거래자가 근무하는 모든 도시를 중복 없이 나열하시오
void quiz2() {
  print('2. 거래자가 근무하는 모든 도시를 중복 없이 나열하시오');
  (transactions.map((e) => e.trader.city)).toSet().forEach(print);
}

// 3. 케임브리지에서 근무하는 모든 거래자를 찾아서 이름순으로 정렬하여 나열하시오
void quiz3() {
  print("3. 케임브리지에서 근무하는 모든 거래자를 찾아서 이름순으로 정렬하여 나열하시오");
  transactions.where((e) => e.trader.city == "Cambridge").toList()
      .forEach((element) {
    print(element.trader.name);
  });
}

// 4. 모든 거래자의 이름을 알파벳순으로 정렬하여 나열하시오 ???????
void quiz4() {
  print('4. 모든 거래자의 이름을 알파벳순으로 정렬하여 나열하시오');
  (transactions.map((e) => e.trader.name).toList()
    ..sort()).forEach(print);
}
// 5. 밀라노에 거래자가 있는가?
void quiz5() {
  print('5. 밀라노에 거래자가 있는가?');
  print(transactions.any((element) => element.trader.city == "Milan"));
}