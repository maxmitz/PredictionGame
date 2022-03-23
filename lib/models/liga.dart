class Liga {
  final String verbandname;
  final String teamtypsname;
  final String spielklassename;
  final String liganame;
  final String ligalink;

  Liga(
      {this.verbandname,
      this.teamtypsname,
      this.spielklassename,
      this.liganame,
      this.ligalink});
}

class Ligen {
  final List<Liga> ligenliste;

  Ligen({this.ligenliste});
}
