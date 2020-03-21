public enum GenericState<D, E: Error>: StoreState {
    case idle
    case loading(D?)
    case loaded(D)
    case error(E, D?)
}

public extension GenericState {
    var data: D? {
        switch self {
        case .idle:
            return nil
        case let .loaded(data):
            return data
        case let .loading(data):
            return data
        case let .error(_, data):
            return data
        }
    }

    var error: E? {
        switch self {
        case .idle, .loaded, .loading:
            return nil
        case let .error(error, _):
            return error
        }
    }

    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        case .idle, .loaded, .error:
            return false
        }
    }

    func map<V>(_ block: (D) -> V) -> GenericState<V, E> {
        switch self {
        case .idle:
            return GenericState<V, E>.idle
        case let .loading(data):
            return GenericState<V, E>.loading(data.map(block))
        case let .loaded(data):
            return GenericState<V, E>.loaded(block(data))
        case let .error(error, data):
            return GenericState<V, E>.error(error, data.map(block))
        }
    }

    func mapError<R>(_ block: (E) -> R) -> GenericState<D, R> {
        switch self {
        case .idle:
            return GenericState<D, R>.idle
        case let .loaded(data):
            return GenericState<D, R>.loaded(data)
        case let .loading(data):
            return GenericState<D, R>.loading(data)
        case let .error(error, data):
            return GenericState<D, R>.error(block(error), data)
        }
    }
}

public extension GenericState {
    mutating func toLoading() {
        switch self {
        case .loading:
            fatalError("Wrong state transition")
        case .loaded, .idle, .error:
            self = .loading(data)
        }
    }

    mutating func toLoaded(with data: D) {
        switch self {
        case .idle, .error, .loaded:
            fatalError("Wrong state transition")
        case .loading:
            self = .loaded(data)
        }
    }

    mutating func toError(with error: E) {
        switch self {
        case .idle, .error, .loaded:
            fatalError("Wrong state transition")
        case .loading:
            self = .error(error, data)
        }
    }
}
