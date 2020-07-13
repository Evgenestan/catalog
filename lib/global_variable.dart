import 'package:catalog/product.dart';
import 'package:rxdart/rxdart.dart';

Map<int, Product> idAndProductUnmodifiable = <int, Product>{};
final filteredMap = PublishSubject<Map<int, int>>();
Map<int, Product> idAndProduct = <int, Product>{};
