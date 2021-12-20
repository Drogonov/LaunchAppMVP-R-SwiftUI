//
//  SettingsBuilder.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 17.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SettingsBuilderProtocol {
    func createSettingsModule(router: RouterProtocol, model: SettingsModel) -> UIViewController
}

class SettingsBuilder: SettingsBuilderProtocol {
    func createSettingsModule(router: RouterProtocol, model: SettingsModel) -> UIViewController {
        let view = SettingsViewController()
        let presenter = SettingsPresenter(
            view: view,
            router: router,
            model: model
        )
        view.presenter = presenter
        return view
    }
}
