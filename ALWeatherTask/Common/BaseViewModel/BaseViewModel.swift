import UIKit

// MARK: - ViewState

public enum BaseViewState: ViewState {
    case idle
    case isLoading(Bool)
    case loaded
    case error(ResultError, Bool)
}

// MARK: - BaseViewModel

public class BaseViewModel: NSObject {
    public func showError(_: ResultError, forHidden _: Bool) {}
}
