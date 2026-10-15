import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

// Found in Plotwatch: a row grew to the height of a portrait photo.
void main() {
  testWidgets('Given a card and a tall photo in an intrinsic-height row '
      'then the card sets the height and the photo fills it', (tester) async {
    const card = Key('card');
    const photo = Key('photo');
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 600,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: SizedBox(key: card, height: 200)),
                  Expanded(
                    child: IgnoreIntrinsicHeight(
                      // Stands for a portrait photo: taller than the card.
                      child: SizedBox(key: photo, height: 500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byKey(card)).height, 200);
    expect(tester.getSize(find.byKey(photo)).height, 200);
  });
}
