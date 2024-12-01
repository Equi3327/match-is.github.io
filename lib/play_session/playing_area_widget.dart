
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../game_internals/playing_card.dart';
import '../../style/palette.dart';
import '../blocs/board_bloc/board_bloc.dart';
import '../game_internals/player.dart';
import 'playing_card_widget.dart';

class PlayingAreaWidget extends StatefulWidget {
  const PlayingAreaWidget(
      {super.key, required this.pile, required this.currentPlayer});
  final List<PlayingCard> pile;
  final Player currentPlayer;

  @override
  State<PlayingAreaWidget> createState() => _PlayingAreaWidgetState();
}

class _PlayingAreaWidgetState extends State<PlayingAreaWidget> {
  bool isHighlighted = false;
  Offset lastElementOffset = Offset(0, 0);

  void _onDragLeave(PlayingCardDragData? data) {
    setState(() => isHighlighted = false);
  }

  bool _onDragWillAccept(DragTargetDetails<PlayingCardDragData>? data) {
    if (data == null || data.data.holder != widget.currentPlayer) return false;
    setState(() => isHighlighted = true);
    return true;
  }

  void _onDragAccept(DragTargetDetails<PlayingCardDragData> data) {
    debugPrint("data :: ${data.offset}");
    BlocProvider.of<BoardBloc>(context)
        .add(CurrentPlayerPlayingCard(card: data.data.card));
    // data.
    lastElementOffset = data.offset;
    setState(() => isHighlighted = false);
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width * 0.7,
      height: size.height * 0.5,
      child: PhysicalModel(
        color: isHighlighted ? palette.accept : palette.board,
        // shape: const StadiumBorder(),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        shadowColor: palette.trueBlack,
        elevation: 5.0,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: palette.redPen,
          child: _CardStack(widget.pile),
        ),
      ),
      // DragTarget<PlayingCardDragData>(
      //   builder: (context, candidateData, rejectedData) =>
      //       PhysicalModel(
      //     color: isHighlighted ? palette.accept : palette.board,
      //     // shape: const StadiumBorder(),
      //     borderRadius: const BorderRadius.all(Radius.circular(40)),
      //     shadowColor: palette.trueBlack,
      //     elevation: 5.0,
      //     clipBehavior: Clip.hardEdge,
      //     child: InkWell(
      //       splashColor: palette.redPen,
      //       child: _CardStack(widget.pile),
      //     ),
      //   ),
      //   onWillAcceptWithDetails: _onDragWillAccept,
      //   onLeave: _onDragLeave,
      //   onAcceptWithDetails: _onDragAccept,
      // ),
    );
  }
}

class _CardStack extends StatelessWidget {
  static const _leftOffset = 15.0;

  final List<PlayingCard> cards;

  const _CardStack(this.cards);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        for (var i = 0; i < cards.length; i++)
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Align(
                alignment: Alignment.center,
                child: Transform.translate(
                  offset: constraints.maxWidth > 600
                      ? Offset((-(cards.length - i - 1) * 16.0) + 150, 0)
                      : Offset((-(cards.length - i - 1) * 12.0) + 90, (-(cards.length - i - 1) * 12.0) + 90),
                  child: PlayingCardWidget(
                    card: cards[i],
                    show: true,
                  ),
                ),
              );
            },
            // child: Align(
            //   alignment: Alignment.center,
            //   child: Transform.translate(
            //     offset: Offset((-(cards.length - i - 1) * 16.0) + 150, 0),
            //     child: PlayingCardWidget(
            //       card: cards[i],
            //       show: true,
            //     ),
            //   ),
            // ),
          ),
      ],
    );
  }
}
