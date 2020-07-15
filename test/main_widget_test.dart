import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catalog/main.dart';
import 'package:image_test_utils/image_test_utils.dart';

void main() {
  testWidgets('RichTextTest', (WidgetTester tester) async {
    await provideMockedNetworkImages(() async {
      await tester.pumpWidget(MyApp());


      String check = 'ok';


      for (var i = 0; i < 100; i++) {
        bool cycle = true;

        while (cycle) {
          if (find.byKey(Key('item_${i}_text')).toString().substring(0, 7) == 'exactly') {
            cycle = false;
            final richText = find.byKey(Key('item_${i}_text'));
            final RichText richTextWidget = tester.widget(richText);
            final text = richTextWidget.text.toPlainText();
            print('test $text');
            if(text == ''){
              check = 'ne ok';
            }
          } else {
            await tester.drag(
                find.byKey(
                  const Key('long_list'),
                ),
                const Offset(0, -50));
            await tester.pumpAndSettle();
          }
        }
      }
      print(check);
      expect(check, 'ok');
    });
  });
}
