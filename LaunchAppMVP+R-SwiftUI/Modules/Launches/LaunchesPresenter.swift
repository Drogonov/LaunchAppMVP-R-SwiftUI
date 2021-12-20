//
//  LaunchesPresenter.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 12.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

protocol LaunchesPresenterProtocol: AnyObject {
    init(
        view: LaunchesViewControllerProtocol,
        router: RouterProtocol
    )
    func setView()
    func routeToSettings(with viewController: UIViewController)
}

class LaunchesPresenter {
    
    // MARK: - Services
    
    @Inject var spaceXDataService: SpaceXDataService
    
    // MARK: - Properties
    
    weak var view: LaunchesViewControllerProtocol?
    var router: RouterProtocol

    private var viewModel = LaunchesViewModel()

    // MARK: - Construction
    
    required init(
        view: LaunchesViewControllerProtocol,
        router: RouterProtocol
    ) {
        self.view = view
        self.router = router
    }
}

// MARK: - LaunchesPresenterProtocol

extension LaunchesPresenter: LaunchesPresenterProtocol {
    func setView() {
        viewModel.navigationTitle = "Launches"
        loadLaunches()
        self.view?.setView(with: viewModel)
    }
    
    func routeToSettings(with viewController: UIViewController) {
        let model = SettingsModel(type: .launches)
        router.showSettings(with: model)
    }
}

// MARK: - Helper Functions

extension LaunchesPresenter {
    private func loadLaunches() {
        self.router.showLoader()
        spaceXDataService.getLaunchesList { [weak self] result in
            guard let self = self else { return }
            sleep(Constants.delay)
            switch result {
            case .success(let response):
                guard let launches = response else { return }
                self.configureLaunchesArray(with: launches)
                self.router.hideLoader()
            case .failure(let error):
                self.router.hideLoader()
                debugPrint(error)
            }
        }
    }
    
    private func configureLaunchesArray(with response: [LaunchMo]) {
        viewModel.launches = response.map { model in
            return LaunchesCellViewModel(
                name: model.missionName ?? "unnamed",
                details: model.details ?? "no data",
                launchYear: model.launchYear ?? "no data",
                imageURL: model.links?.missionPatchSmall ?? ""
            )
        }
        self.view?.setView(with: viewModel)
    }
}
