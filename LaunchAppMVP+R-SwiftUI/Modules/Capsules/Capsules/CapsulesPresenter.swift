//
//  CapsulesPresenter.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 12.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import UIKit

protocol CapsulesPresenterProtocol: AnyObject {
    init(
        view: CapsulesViewControllerProtocol,
        router: RouterProtocol
    )
    
    func setView()
    func routeToDetails(with capsuleSerial: String?, and viewController: UIViewController)
    func routeToSettings(with viewController: UIViewController)
}

class CapsulesPresenter: ObservableObject {
    
    // MARK: - Services
    
    @Inject var spaceXDataService: SpaceXDataService

    // MARK: - Properties
    
    weak var view: CapsulesViewControllerProtocol?
    var router: RouterProtocol
    
    @ObservedObject private var viewModel = CapsulesViewModel()
    
    // MARK: - Construction
    
    required init(
        view: CapsulesViewControllerProtocol,
        router: RouterProtocol
    ) {
        self.view = view
        self.router = router
    }
}

// MARK: - CapsulesPresenterProtocol

extension CapsulesPresenter: CapsulesPresenterProtocol {
    func setView() {
        loadCapsules()
        self.view?.setView(with: viewModel)
    }
        
    func routeToDetails(with capsuleSerial: String?, and viewController: UIViewController) {
        guard let capsuleSerial = capsuleSerial else { return }
        let model = CapsuleDetailsModel(serial: capsuleSerial)
        router.showDetailCapsules(with: viewController, and: model)
    }
    
    func routeToSettings(with viewController: UIViewController) {
        let model = SettingsModel(type: .capsules)
        router.showSettings(with: model)
    }
}

// MARK: - Helper Functions

extension CapsulesPresenter {
    private func loadCapsules() {
        self.router.showLoader()
        spaceXDataService.getCapsulesList { [weak self] result in
            guard let self = self else { return }
            sleep(Constants.delay)
            switch result {
            case .success(let response):
                guard let capsules = response else { return }
                self.configureCapsulesArray(with: capsules)
                self.router.hideLoader()
            case .failure(let error):
                self.router.hideLoader()
                debugPrint(error)
            }
        }
    }
    
    private func configureCapsulesArray(with response: [CapsuleMo]) {
        viewModel.capsules = response.map { model in
            let statusButtonColor: Color = model.status == "active" ? .green : .red
            let serial = model.capsuleSerial ?? "no serial"
            
            return CapsuleCellViewModel(
                statusButtonColor: statusButtonColor,
                capsuleName: serial,
                capsuleEmoji: "🛰"
            )
        }
        self.view?.setView(with: viewModel)
    }
}
