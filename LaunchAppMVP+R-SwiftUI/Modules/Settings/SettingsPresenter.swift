//
//  SettingsPresenter.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 17.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI

protocol SettingsPresenterProtocol: AnyObject {
    init(
        view: SettingsViewControllerProtocol,
        router: RouterProtocol,
        model: SettingsModel
    )
    func setView()
}

class SettingsPresenter: ObservableObject {
    
    // MARK: - Services
    
    // MARK: - Properties
    
    weak var view: SettingsViewControllerProtocol?
    var router: RouterProtocol
    var model: SettingsModel
    
    @ObservedObject var viewModel = SettingsViewModel()
    
    // MARK: - Construction
    
    required init(
        view: SettingsViewControllerProtocol,
        router: RouterProtocol,
        model: SettingsModel
    ) {
        self.view = view
        self.router = router
        self.model = model
    }
}

// MARK: - SettingsPresenterProtocol

extension SettingsPresenter: SettingsPresenterProtocol {
    func setView() {
        configureViewModel()
        self.view?.setView(with: viewModel)
    }
}

// MARK: - Helper Functions

extension SettingsPresenter {
    func configureViewModel() {
        switch model.type {
        case .launches:
            viewModel.navigationTitle = "Launches Settings"
            viewModel.text = "Falcon 9 is a reusable, two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of people and payloads into Earth orbit and beyond. Falcon 9 is the world’s first orbital class reusable rocket. Reusability allows SpaceX to refly the most expensive parts of the rocket, which in turn drives down the cost of space access."
            viewModel.buttonText = "Confirm"
        case .capsules:
            viewModel.navigationTitle = "Capsules Settings"
            viewModel.text = "The Dragon spacecraft is capable of carrying up to 7 passengers to and from Earth orbit, and beyond. It is the only spacecraft currently flying that is capable of returning significant amounts of cargo to Earth, and is the first private spacecraft to take humans to the space station."
            viewModel.buttonText = "Confirm"
        }
    }
}
