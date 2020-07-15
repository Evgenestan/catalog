import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catalog/main.dart';
import 'package:image_test_utils/image_test_utils.dart';

void main() {
  testWidgets('VisualTest', (WidgetTester tester) async {
    await provideMockedNetworkImages(() async {
      await tester.pumpWidget(MyApp());

      String check = 'ok';
      final findStreamBuilder = find.byKey(const Key('long_list'));
      final findSliverGrid = find.byType(SliverGrid);
      final SliverGrid sliverGrid = tester.widget(findSliverGrid);
      final length = sliverGrid.delegate.estimatedChildCount;
      final findContainer = find.byKey(const Key('container0'));
      final containerSizeHeight = tester.getSize(findContainer).height;


      for (var i = 0; i < length; i++) {
        bool cycle = true;



        while (cycle) {
          if (find.byKey(Key('item_${i}_text')).toString().substring(0, 7) ==
              'exactly') {
            cycle = false;


            final findPadding = find.byKey(Key('padding$i'));
            final findPositioned = find.byKey(Key('positioned$i'));
            await tester.ensureVisible(findPositioned);

             final stackGet = tester.getTopRight(findPositioned);
             final fittedBoxGet = tester.getTopRight(findPadding);
            print(stackGet);
            print(fittedBoxGet);
            if(stackGet.dy - 10 != fittedBoxGet.dy) {
              check = 'ne ok';
              print('$check on $i');
            }







          } else {
            await tester.drag(findStreamBuilder,  Offset(0, -1 * containerSizeHeight));
            await tester.pumpAndSettle();
          }
        }
      }
      print(check);
      expect(check, 'ok');
    });
  });






}
