////
////  BaseViewModel.swift
////
////  Created by Khaled kamal on 1/19/20.
////  Copyright © 2020 Khaled kamal. All rights reserved.
////
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
