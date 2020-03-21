public protocol StoreState: Equatable, CustomLogDescriptionConvertible {}
public protocol ViewState: StoreState {}

public extension Equatable where Self: StoreState {
    static func == (_: Self, _: Self) -> Bool {
        return false
    }
}
