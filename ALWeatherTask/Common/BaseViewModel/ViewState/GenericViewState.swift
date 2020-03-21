public enum GenericViewState<D, E: Error>: ViewState {
    case loading(D?)
    case loaded(D)
    case emptyCase
    case error(E, D?)
}

// Because sometimes we simply want to render that there's been an error, without further details...
public enum GenericViewState2<D>: ViewState {
    case loading(D?)
    case loaded(D)
    case emptyCase
    case error(D?)
}

public extension GenericState {
    func map<V, R>(dataTransform: (D) -> V, errorTransform: (E) -> R, isEmpty: (V) -> Bool) -> GenericViewState<V, R> {
        switch self {
        case .idle:
            return GenericViewState<V, R>.loading(nil)
        case let .loading(data):
            return GenericViewState<V, R>.loading(data.map(dataTransform))
        case let .loaded(data):
            let viewData = dataTransform(data)
            return isEmpty(viewData) ? GenericViewState<V, R>.emptyCase : GenericViewState<V, R>.loaded(viewData)
        case let .error(error, data):
            return GenericViewState<V, R>.error(errorTransform(error), data.map(dataTransform))
        }
    }

    func map<V>(dataTransform: (D) -> V, isEmpty: (V) -> Bool) -> GenericViewState2<V> {
        switch self {
        case .idle:
            return GenericViewState2<V>.loading(nil)
        case let .loading(data):
            return GenericViewState2<V>.loading(data.map(dataTransform))
        case let .loaded(data):
            let viewData = dataTransform(data)
            return isEmpty(viewData) ? GenericViewState2<V>.emptyCase : GenericViewState2<V>.loaded(viewData)
        case let .error(_, data):
            return GenericViewState2<V>.error(data.map(dataTransform))
        }
    }
}
