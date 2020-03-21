////
////  BaseViewModel.swift
////  Servent
////
////  Created by Khaled kamal on 1/19/20.
////  Copyright © 2020 Khaled kamal. All rights reserved.
////
//
import UIKit
//
//// MARK: - ViewState
//
public enum BaseViewState: ViewState {
    case idle
    case isLoading(Bool)
    case loaded
    case error(ResultError, Bool)
}

//
//// MARK: - BaseViewModel
//
public class BaseViewModel: ViewModel<BaseViewState> {
    public init() {
        super.init(initialState: .idle)
    }

    public func showError(_ error: ResultError, forHidden hidden: Bool) {
        self.state = .loaded
        self.state = .error(error, hidden)
    }
}
