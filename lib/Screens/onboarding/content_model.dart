class OnboardingContent {
  String? image;
  String? title;
  String? discription;

  OnboardingContent({this.image, this.title, this.discription});
}

List<OnboardingContent> contents = [
  OnboardingContent(
      title: 'Liga hinzufügen',
      image: 'assets/images/Liga_hinzufügen.png',
      discription: "Füge als erstes eine Liga hinzu. "
          "Drücke dafür auf den Button Hinzufügen"),
  OnboardingContent(
      title: 'Tippen',
      image: 'assets/images/tippen.png',
      discription: "Drücke um Spiele zu tippen auf den Reiter tippen."
          "Wähle dann deine Liga und Spieltage."
          "Anschließend kannst du Spiele tippen."),
  OnboardingContent(
      title: 'Rangliste',
      image: 'assets/images/Ligen_auswählen.png',
      discription: "Wähle, um dich mit anderen zu vergleichen den Reiter Ligen."
          "Drücke auf die gewünschte Liga."
          "Du siehst dann wie viele Punkte andere Tipper der Liga haben."),
  OnboardingContent(
      title: 'Punkte',
      image: 'assets/images/Tabelle.png',
      discription:
          "Wenn du getippt hast und das Spiel eingetragen ist (das kann evtl. dauern) bekommst du 5 Punkte, wenn das Ergebnis genau stimmt, 3 Punkte, wenn die Tendenz stimmt (z.B. gewonnen mit einem Tor Vorsprung) und einen Punkte wenn die Richtung stimmt (gewonnen/ verloren)."
          "Viel Spaß!"),
];
