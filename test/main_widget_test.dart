import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catalog/main.dart';
import 'package:image_test_utils/image_test_utils.dart';

void main() {
  testWidgets('RichTextTest0', (WidgetTester tester) async {
    await provideMockedNetworkImages(() async {
      await tester.pumpWidget(MyApp());

      String check = 'ok';
      final findStreamBuilder = find.byKey(const Key('long_list'));
      final findSliverGrid = find.byType(SliverGrid);
      final SliverGrid sliverGrid = tester.widget(findSliverGrid);
      final length = sliverGrid.delegate.estimatedChildCount;
      //final findContainer0 = find.byKey(const Key('container0'));
      //final Container container0 = tester.widget(findContainer0);
      //print(container0.constraints.heightConstraints().maxHeight);


      for (var i = 0; i < length; i++) {
        bool cycle = true;

        while (cycle) {
          if (find.byKey(Key('item_${i}_text')).toString().substring(0, 7) ==
              'exactly') {
            cycle = false;
            await tester.ensureVisible(find.byKey(Key('item_${i}_text')));
            final richText = find.byKey(Key('item_${i}_text'));
            final RichText richTextWidget = tester.widget(richText);
            final text = richTextWidget.text.toPlainText();
            print('test $text');
            if (text == '') {
              check = 'ne ok';
            }
          } else {
            await tester.drag(findStreamBuilder, const Offset(0, -50));
            await tester.pumpAndSettle();
          }
        }
      }
      print(check);
      expect(check, 'ok');
    });
  });

  testWidgets('RichTextTestMilk', (WidgetTester tester) async {
    await provideMockedNetworkImages(() async {
      await tester.pumpWidget(MyApp());

      final findButton = find.byKey(const Key('buttonMoloko'));
      await tester.tap(findButton);
      await tester.pump();
      final findSliverGrid = find.byType(SliverGrid);
      final SliverGrid sliverGrid = tester.widget(findSliverGrid);
      final length = sliverGrid.delegate.estimatedChildCount;

      String check = 'ok';

      for (var i = 0; i < length; i++) {
        for (var j = 0; j < 100; j++) {
          final richText = find.byKey(Key('item_${i}_text'));
          if (richText.toString().substring(0, 7) == 'exactly') {
            final RichText richTextWidget = tester.widget(richText);
            final text = richTextWidget.text.toPlainText();
            print('test $text');
            if (text != 'Молочный продукт /1кг') {
              check = 'ne ok';
            }
            break;
          }
          await tester.drag(
              find.byKey(
                const Key('long_list'),
              ),
              const Offset(0, -50));
          await tester.pumpAndSettle();
        }
      }
      print(check);
      expect(check, 'ok');
    });
  });

  testWidgets('RichTextTestCheese', (WidgetTester tester) async {
    await provideMockedNetworkImages(() async {
      await tester.pumpWidget(MyApp());

      final findButton = find.byKey(const Key('buttonCheese'));
      await tester.tap(findButton);
      await tester.pump();
      final findSliverGrid = find.byType(SliverGrid);
      final SliverGrid sliverGrid = tester.widget(findSliverGrid);
      final length = sliverGrid.delegate.estimatedChildCount;

      String check = 'ok';

      for (var i = 0; i < length; i++) {
        for (var j = 0; j < 100; j++) {
          final richText = find.byKey(Key('item_${i}_text'));
          if (richText.toString().substring(0, 7) == 'exactly') {
            final RichText richTextWidget = tester.widget(richText);
            final text = richTextWidget.text.toPlainText();
            print('test $text');
            if (text != 'Сыр /1кг') {
              check = 'ne ok';
            }
            break;
          }
          await tester.drag(
              find.byKey(
                const Key('long_list'),
              ),
              const Offset(0, -50));
          await tester.pumpAndSettle();
        }
      }
      print(check);
      expect(check, 'ok');
    });
  });

  testWidgets('RichTextTestMeet', (WidgetTester tester) async {
    await provideMockedNetworkImages(() async {
      await tester.pumpWidget(MyApp());

      final findButton = find.byKey(const Key('buttonMeet'));
      await tester.tap(findButton);
      await tester.pump();
      final findSliverGrid = find.byType(SliverGrid);
      final SliverGrid sliverGrid = tester.widget(findSliverGrid);
      final length = sliverGrid.delegate.estimatedChildCount;

      String check = 'ok';

      for (var i = 0; i < length; i++) {
        for (var j = 0; j < 100; j++) {
          final richText = find.byKey(Key('item_${i}_text'));
          if (richText.toString().substring(0, 7) == 'exactly') {
            final RichText richTextWidget = tester.widget(richText);
            final text = richTextWidget.text.toPlainText();
            print('test $text');
            if (text != 'Мясо /1кг') {
              check = 'ne ok';
            }
            break;
          }
          await tester.drag(
              find.byKey(
                const Key('long_list'),
              ),
              const Offset(0, -50));
          await tester.pumpAndSettle();
        }
      }
      print(check);
      expect(check, 'ok');
    });
  });





}
