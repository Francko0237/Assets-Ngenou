/// Modèle mathématique pour les opérations et simplifications de fractions
class FractionModel {
  final int numerateur;
  final int denominateur;

  const FractionModel(this.numerateur, this.denominateur)
      : assert(denominateur > 0, 'Le dénominateur doit être strictement positif');

  double get valeurDecimale => numerateur / denominateur;
  double get pourcentage => (numerateur / denominateur) * 100;

  /// Plus Grand Commun Diviseur (Algorithme d'Euclide)
  static int pgcd(int a, int b) {
    int x = a.abs();
    int y = b.abs();
    while (y != 0) {
      int t = y;
      y = x % y;
      x = t;
    }
    return x == 0 ? 1 : x;
  }

  /// Simplification en fraction irréductible
  FractionModel simplifier() {
    final diviseur = pgcd(numerateur, denominateur);
    return FractionModel(numerateur ~/ diviseur, denominateur ~/ diviseur);
  }

  bool get estIrreductible => pgcd(numerateur, denominateur) == 1;

  FractionModel additionner(FractionModel autre) {
    final nouveauNum = (numerateur * autre.denominateur) + (autre.numerateur * denominateur);
    final nouveauDen = denominateur * autre.denominateur;
    return FractionModel(nouveauNum, nouveauDen).simplifier();
  }

  FractionModel soustraire(FractionModel autre) {
    final nouveauNum = (numerateur * autre.denominateur) - (autre.numerateur * denominateur);
    final nouveauDen = denominateur * autre.denominateur;
    return FractionModel(nouveauNum, nouveauDen).simplifier();
  }

  FractionModel multiplier(FractionModel autre) {
    return FractionModel(
      numerateur * autre.numerateur,
      denominateur * autre.denominateur,
    ).simplifier();
  }

  @override
  String toString() => '$numerateur/$denominateur';
}
