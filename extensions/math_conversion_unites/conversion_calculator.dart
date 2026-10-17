import 'dart:math' as math;

/// Calculateur et utilitaire pour les conversions d'unités et rangs décimaux
class ConversionCalculator {
  static final Map<String, List<String>> unitesParGrandeur = {
    'longueur': ['km', 'hm', 'dam', 'm', 'dm', 'cm', 'mm'],
    'masse': ['t', 'q', 'kg', 'hg', 'dag', 'g', 'dg', 'cg', 'mg'],
    'capacite': ['kL', 'hL', 'daL', 'L', 'dL', 'cL', 'mL'],
    'aire': ['km²', 'hm²', 'dam²', 'm²', 'dm²', 'cm²', 'mm²'],
  };

  static final Map<String, List<double>> facteursParGrandeur = {
    'longueur': [1000, 100, 10, 1, 0.1, 0.01, 0.001],
    'masse': [1000000, 100000, 1000, 100, 10, 1, 0.1, 0.01, 0.001],
    'capacite': [1000, 100, 10, 1, 0.1, 0.01, 0.001],
    'aire': [1000000, 10000, 100, 1, 0.01, 0.0001, 0.000001],
  };

  /// Convertit une valeur d'une unité vers une autre
  static double convertir({
    required String grandeur,
    required double valeur,
    required String uniteDepart,
    required String uniteCible,
  }) {
    final unites = unitesParGrandeur[grandeur];
    final facteurs = facteursParGrandeur[grandeur];
    if (unites == null || facteurs == null) return valeur;

    final idxDep = unites.indexOf(uniteDepart);
    final idxCib = unites.indexOf(uniteCible);
    if (idxDep == -1 || idxCib == -1) return valeur;

    final fDep = facteurs[idxDep];
    final fCib = facteurs[idxCib];
    return (valeur * fDep) / fCib;
  }

  /// Décompose un nombre en puissances de 10
  static Map<String, dynamic> decomposerDecimal(double nombre) {
    final str = nombre.toString();
    final parts = str.split('.');
    final intPart = parts[0];
    final decPart = parts.length > 1 ? parts[1] : '';

    final morceaux = <String>[];
    for (int i = 0; i < intPart.length; i++) {
      final ch = intPart[i];
      if (ch != '0') {
        final puissance = intPart.length - 1 - i;
        final facteur = math.pow(10, puissance);
        morceaux.add('($ch × $facteur)');
      }
    }
    for (int i = 0; i < decPart.length; i++) {
      final ch = decPart[i];
      if (ch != '0') {
        final denom = math.pow(10, i + 1);
        morceaux.add('($ch / $denom)');
      }
    }

    return {
      'partieEntiere': intPart,
      'partieDecimale': decPart,
      'canonique': morceaux.join(' + '),
    };
  }
}
