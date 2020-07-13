import 'package:catalog/global_variable.dart';
import 'package:catalog/product.dart';

void filter(int value) {
  print(value);

  Map _idAndProduct = <int, Product>{};
  var numberAndId = numberAndIdSet(idAndProductUnmodifiable);

  if (value == 1) {
    _idAndProduct = idAndProductUnmodifiable;
    filteredMap.add(numberAndId);
  } else {
    for (var i = 0; i < idAndProductUnmodifiable.length; i++) {
      print(i);
      print(idAndProductUnmodifiable[numberAndId[i]].title);
      if (idAndProductUnmodifiable[numberAndId[i]].category == value) {
        _idAndProduct[numberAndId[i]] =
            idAndProductUnmodifiable[numberAndId[i]];
      }
    }
    numberAndId = numberAndIdSet(_idAndProduct);
    filteredMap.add(numberAndId);
  }
}
