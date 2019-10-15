import 'package:flutter/material.dart';

enum HolderState {
  REQUEST_IN_PROGRESS,
  REQUEST_SUCCESS,
  REQUEST_ERROR,
  IDLE,
}

class ImmutableHolder<T> with ChangeNotifier {
  T _value;

  bool _isLoading = false;

  String _errorMsg;

  HolderState _currentState = HolderState.IDLE;

  T get value => _value;
  bool get isLoading => _isLoading;
  String get errorMsg => _errorMsg;

  bool get isIdle => _currentState == HolderState.IDLE;
  bool get requestSuccess => _currentState == HolderState.REQUEST_SUCCESS;
  bool get isValueValid => _value != null;
  bool get hasError => _errorMsg != null;

  void resetState() {
    _currentState = HolderState.IDLE;
  }

  @override
  void addListener(listener) {
    super.removeListener(listener);
    super.addListener(listener);
  }
}

class Holder<T> extends ImmutableHolder<T> {
  set value(T newValue) {
    _isLoading = false;
    _value = newValue;
    notifyListeners();
  }

  set isLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  set errorMsg(String message) {
    _isLoading = false;
    _errorMsg = message;
    notifyListeners();
  }
}

typedef HolderBuilderListener<T> = Widget Function(
    BuildContext context, ImmutableHolder<T> holder);

class HolderBuilder<T> extends StatefulWidget {
  final HolderBuilderListener<T> builder;
  final ImmutableHolder<T> holder;
  final String debugLabel;

  HolderBuilder({
    Key key,
    @required this.holder,
    @required this.builder,
    this.debugLabel,
  }) : super(key: key);

  @override
  _HolderBuilderState<T> createState() => _HolderBuilderState<T>();
}

class _HolderBuilderState<T> extends State<HolderBuilder<T>> {
  FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    ModalRoute.of(context).addScopedWillPopCallback(() {
//      print('ESTA POPPEANDO');
//      return ModalRoute.of(context).willPop();
//    });

    return Focus(
      child: this.widget.builder(context, widget.holder),
    );
  }

  @override
  void dispose() {
    print('DISPOSE BASE HOLDER');
    _focusNode.dispose();
    super.dispose();
  }
}

class FocusedHolderState extends InheritedWidget {
  final FocusScopeNode _mainNode;

  FocusScopeNode get mainNode => _mainNode;

  FocusedHolderState({child})
      : _mainNode = FocusScopeNode(),
        super(child: child);

  static FocusedHolderState of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(FocusedHolderState)
          as FocusedHolderState;

  @override
  bool updateShouldNotify(FocusedHolderState oldWidget) =>
      oldWidget.mainNode != _mainNode;
}

class FocusedHolderBuilder<T> extends StatefulWidget {
  final HolderBuilderListener<T> builder;
  final ImmutableHolder<T> holder;

  FocusedHolderBuilder({
    Key key,
    @required this.holder,
    @required this.builder,
  }) : super(key: key);

  @override
  _FocusedHolderBuilderState<T> createState() =>
      _FocusedHolderBuilderState<T>();
}

class _FocusedHolderBuilderState<T> extends State<HolderBuilder<T>> {
  FocusScopeNode _currentNode;

  @override
  Widget build(BuildContext context) {
    return FocusedHolderState(
      child: Builder(builder: (context) {
        _currentNode = FocusedHolderState.of(context).mainNode;
        //todo: has to listen the holder
        return FocusScope(
          node: _currentNode,
          child: this.widget.builder(context, widget.holder),
        );
      }),
    );
  }

  @override
  void dispose() {
    print('DISPOSE BASE FOCUSED HOLDER');
    if (_currentNode != null) {
      _currentNode.dispose();
    }
    super.dispose();
  }
}
