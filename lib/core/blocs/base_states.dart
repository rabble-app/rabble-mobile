class RabbleBaseState {
  final bool initializing;
  final bool primaryBusy;
  final bool secondaryBusy;
  final bool tertiaryBusy;
  final bool share;
  final bool changePostalCode;
  final bool idle;
  final bool error;
  final bool empty;
  final dynamic data;

  RabbleBaseState({
    bool initializing = false,
    bool busy = false,
    bool idle = false,
    bool error = false,
    bool empty = false,
    bool secondaryBusy = false,
    bool tertiaryBusy = false,
    bool changePostalCode = false,
    bool share = false,
    dynamic data = dynamic,
  })  : this.initializing = initializing,
        this.primaryBusy = busy,
        this.idle = idle,
        this.error = error,
        this.empty = empty,
        this.secondaryBusy = secondaryBusy,
        this.share = share,
        this.tertiaryBusy = tertiaryBusy,
        this.changePostalCode = changePostalCode,
        this.data = data;

  RabbleBaseState.initializing() : this(initializing: true);

  RabbleBaseState.primaryBusy() : this(busy: true);

  RabbleBaseState.idle() : this(idle: true);

  RabbleBaseState.error() : this(error: true);

  RabbleBaseState.empty() : this(empty: true);

  RabbleBaseState.secondaryBusy() : this(secondaryBusy: true);

  RabbleBaseState.tertiaryBusy() : this(tertiaryBusy: true);

  RabbleBaseState.changePostalCode() : this(changePostalCode: true);

  RabbleBaseState.share() : this(share: true);

  RabbleBaseState.response(data) : this(data: data);
}
