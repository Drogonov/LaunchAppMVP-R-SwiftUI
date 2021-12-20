//
//  LaunchesBuilder.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 12.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LaunchesBuilderProtocol {
    func createLaunchesModule(router: RouterProtocol) -> UIViewController
}

class LaunchesBuilder: LaunchesBuilderProtocol {
    func createLaunchesModule(router: RouterProtocol) -> UIViewController {
        let view = LaunchesViewController()
        let presenter = LaunchesPresenter(
            view: view,
            router: router
        )
        view.presenter = presenter
        return view
    }
}
