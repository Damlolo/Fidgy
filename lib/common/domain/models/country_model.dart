class CountryModel {
  final String name;
  final String phoneCode;
  final String iso2Code;

  CountryModel({
    required this.name,
    required this.phoneCode,
    required this.iso2Code,
  });

  String get flag => String.fromCharCodes([
        127365 + iso2Code.toLowerCase().codeUnitAt(0),
        127365 + iso2Code.toLowerCase().codeUnitAt(1),
      ]);
}
