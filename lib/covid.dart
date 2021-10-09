class Covid {
  final String country;
  final String updateDate;
  final int todayCases;
  final int todayDeaths;
  final int todayRecovered;
  final int cases;
  final int deaths;
  final int recovered;
  final int Hospitalized;
  final int tests;
  

  Covid(
      {required this.country,
      required this.updateDate,
      required this.todayCases,
      required this.todayDeaths,
      required this.todayRecovered,
      required this.cases,
      required this.deaths,
      required this.recovered,
      required this.Hospitalized,
      required this.tests,
      
      });

  factory Covid.fromJson(Map<String, dynamic> json) {
    return Covid(
      country: json['country'],
      updateDate: json['UpdateDate'],
      todayCases: json['todayCases'],
      todayDeaths: json['todayDeaths'],
      todayRecovered: json['todayRecovered'],
      cases: json['cases'],
      deaths: json['deaths'],
      recovered: json['recovered'],
      Hospitalized: json['Hospitalized'],
      tests: json['tests'],
    );
  }
}
