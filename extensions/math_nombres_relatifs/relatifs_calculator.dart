/// Modèle mathématique pour les opérations et règles sur les nombres relatifs (5ème)
class RelatifModel {
  final int valeur;

  const RelatifModel(this.valeur);

  int get distanceAZero => valeur.abs();
  bool get estPositif => valeur >= 0;
  bool get estNegatif => valeur < 0;
  int get oppose => -valeur;

  String get ecritureSignee => valeur > 0 ? '+$valeur' : '$valeur';

  /// Résultat d'une opération avec explication pédagogique
  static RelatifOperationResult additionner(int a, int b) {
    final resultat = a + b;
    String explication;
    if ((a >= 0 && b >= 0) || (a <= 0 && b <= 0)) {
      explication =
          'Même signe : on garde le signe commun et on additionne les distances à zéro (${a.abs()} + ${b.abs()} = ${resultat.abs()}).';
    } else {
      final plusLoin = a.abs() >= b.abs() ? a : b;
      explication =
          'Signes différents : on prend le signe du nombre le plus éloigné de zéro ($plusLoin) et on soustrait les distances à zéro (${a.abs() > b.abs() ? '${a.abs()} - ${b.abs()}' : '${b.abs()} - ${a.abs()}'}).';
    }
    return RelatifOperationResult(
      terme1: a,
      terme2: b,
      operateur: '+',
      resultat: resultat,
      explication: explication,
      etapeIntermediaire: '($a) + ($b) = $resultat',
    );
  }

  static RelatifOperationResult soustraire(int a, int b) {
    final resultat = a - b;
    final opposeB = -b;
    final explication =
        'Soustraire un nombre revient à ajouter son opposé : ($a) - ($b) devient ($a) + ($opposeB).';
    return RelatifOperationResult(
      terme1: a,
      terme2: b,
      operateur: '-',
      resultat: resultat,
      explication: explication,
      etapeIntermediaire: '($a) - ($b) = ($a) + ($opposeB) = $resultat',
    );
  }
}

class RelatifOperationResult {
  final int terme1;
  final int terme2;
  final String operateur;
  final int resultat;
  final String explication;
  final String etapeIntermediaire;

  const RelatifOperationResult({
    required this.terme1,
    required this.terme2,
    required this.operateur,
    required this.resultat,
    required this.explication,
    required this.etapeIntermediaire,
  });
}
