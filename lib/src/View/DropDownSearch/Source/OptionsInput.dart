import 'dart:async';
import 'dart:math';

import 'package:base/src/Model/InputOptionObject.dart';
import 'package:base/src/Widget/input/InputInfoWidget.dart';
import 'package:flutter/material.dart';

import 'SuggestionsBoxController.dart';

typedef OptionsInputSuggestions<T> = FutureOr<List<T>> Function(String query);
typedef OptionSelected<T> = void Function(T data, bool selected);
typedef OptionsBuilder<T> = Widget Function(BuildContext context, _OptionsInputState<T> state, T data);

class OptionsInput<T> extends StatefulWidget {
  final OptionsInputSuggestions<T> findSuggestions;
  final ValueChanged<T> onChanged;
  final OptionsBuilder<T> suggestionBuilder;
  final TextEditingController? textEditingController;
  final double suggestionsBoxMaxHeight;
  final double inputHeight;
  final double spaceSuggestionBox;
  final FocusNode focusNode;
  final InputDecoration? inputDecoration;
  final TextInputAction? textInputAction;
  final TextStyle? textStyle;
  final double scrollPadding;
  final List<T> initOptions;
  final double borderRadius;
  final Color backgroundColor;
  final bool enabled;
  final String? hintText;
  final Stream<InputOptionObject>? inputOptionObject;

  const OptionsInput({
    Key? key,
    required this.findSuggestions,
    required this.onChanged,
    required this.suggestionBuilder,
    this.textEditingController,
    required this.focusNode,
    this.inputDecoration,
    this.textInputAction,
    this.textStyle,
    this.suggestionsBoxMaxHeight = 0,
    this.scrollPadding = 40,
    this.initOptions = const [],
    this.inputHeight = 40,
    this.spaceSuggestionBox = 4,
    this.borderRadius = 0,
    this.backgroundColor = Colors.white,
    this.enabled = true,
    this.hintText,
    this.inputOptionObject,
  }) : super(key: key);

  @override
  _OptionsInputState<T> createState() => _OptionsInputState<T>();
}

class _OptionsInputState<T> extends State<OptionsInput<T>> {
  final _layerLink = LayerLink();
  final _suggestionsStreamController = StreamController<List<T>>.broadcast();
  int _searchId = 0;
  late SuggestionsBoxController _suggestionsBoxController;
  late FocusNode _focusNode;
  final _scrollController = ScrollController();
  RenderBox? get renderBox => context.findRenderObject() as RenderBox;

  @override
  void initState() {
    super.initState();
    _suggestionsBoxController = SuggestionsBoxController(context);
    _focusNode = widget.focusNode;
    _focusNode.addListener(_handleFocusChanged);
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _initOverlayEntry();
    });
  }


  @override
  Widget build(BuildContext context) {
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (SizeChangedLayoutNotification val) {
        WidgetsBinding.instance?.addPostFrameCallback((_) async {
          _suggestionsBoxController.overlayEntry?.markNeedsBuild();
        });
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Column(
          children: [
            InputInfoWidget(
              controller: widget.textEditingController,
              focusNode: _focusNode,
              onChanged: _onSearchChanged,
              hintText: widget.hintText ?? "",
              //decoration: widget.inputDecoration,
              textInputAction: widget.textInputAction ?? TextInputAction.done,
              maxLines: 1,
              //style: widget.textStyle,
              onSubmitted: _onSearchChanged,
              scrollPaddingBottom: widget.scrollPadding,
              enable: widget.enabled,
              inputOptionObject: widget.inputOptionObject,
            ),
            CompositedTransformTarget(
              link: _layerLink,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //_focusNode.removeListener(_handleFocusChanged);
    _suggestionsStreamController.close();
    _suggestionsBoxController.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _initOverlayEntry() {
    _suggestionsBoxController.overlayEntry = OverlayEntry(
      builder: (context) {
        final size = renderBox!.size;
        final renderBoxOffset = renderBox!.localToGlobal(Offset.zero);
        final topAvailableSpace = renderBoxOffset.dy;
        final mq = MediaQuery.of(context);
        final bottomAvailableSpace = mq.size.height - mq.viewInsets.bottom - renderBoxOffset.dy - size.height;
        final showTop = topAvailableSpace > bottomAvailableSpace;
        final _suggestionBoxHeight =
            showTop ? min(topAvailableSpace, widget.suggestionsBoxMaxHeight) : min(bottomAvailableSpace, widget.suggestionsBoxMaxHeight);

        final compositedTransformFollowerOffset =
            showTop ? Offset(0, -size.height - widget.spaceSuggestionBox) : Offset(0, widget.spaceSuggestionBox);

        return StreamBuilder<List<T>>(
          stream: _suggestionsStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              var suggestionsListView = Material(
                elevation: 0,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: widget.backgroundColor,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: _suggestionBoxHeight,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.black54.withOpacity(0.3), offset: const Offset(0, 0), blurRadius: 4.0),
                      ],
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                    child: Scrollbar(
                      controller: _scrollController,
                      trackVisibility: true,
                      child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return widget.suggestionBuilder(context, this, snapshot.data![index]);
                        },

                      ),
                    ),
                  ),
                ),
              );
              // var suggestionsListView = Container(
              //   decoration: BoxDecoration(
              //     color: widget.backgroundColor,
              //     boxShadow: <BoxShadow>[
              //       BoxShadow(color: Colors.black54, offset: Offset(0, 0), blurRadius: 4.0),
              //     ],
              //     borderRadius: BorderRadius.circular(widget.borderRadius),
              //   ),
              //   child: ConstrainedBox(
              //     constraints: BoxConstraints(
              //       maxHeight: _suggestionBoxHeight,
              //     ),
              //     child: ListView.builder(
              //       shrinkWrap: true,
              //       padding: EdgeInsets.zero,
              //       itemCount: snapshot.data!.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return widget.suggestionBuilder(context, this, snapshot.data![index]);
              //       },
              //     ),
              //   ),
              // );

              return Positioned(
                width: size.width,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: compositedTransformFollowerOffset,
                  child: !showTop
                      ? suggestionsListView
                      : FractionalTranslation(
                          translation: const Offset(0, -1),
                          child: suggestionsListView,
                        ),
                ),
              );
            }
            return Container();
          },
        );
      },
    );
  }

  void selectSuggestion(T data) {
    _suggestionsStreamController.add([]);
    widget.onChanged(data);
  }

  void _onSearchChanged(String value) async {
    final localId = ++_searchId;
    final results = await widget.findSuggestions(value);
    if (_searchId == localId && mounted) {
      _suggestionsStreamController.add(results);
    }
  }

  void _handleFocusChanged() {
    if (_focusNode.hasFocus) {
      _suggestionsBoxController.open();
      Future.delayed(const Duration(milliseconds: 100)).then((value) => _suggestionsStreamController.add(widget.initOptions));
    } else {
      _suggestionsBoxController.close();
    }
  }
}
