//
//  CapsuleDetailsPresenter.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 13.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI

protocol CapsuleDetailsPresenterProtocol: AnyObject {
    init(
        view: CapsuleDetailsViewControllerProtocol,
        router: RouterProtocol,
        model: CapsuleDetailsModel
    )
    func setView()
}

class CapsuleDetailsPresenter: ObservableObject {
    
    // MARK: - Services
    
    @Inject var spaceXDataService: SpaceXDataService
    
    // MARK: - Properties
    
    weak var view: CapsuleDetailsViewControllerProtocol?
    var router: RouterProtocol
    var model: CapsuleDetailsModel
    
    @ObservedObject var viewModel = CapsuleDetailsViewModel()
    
    // MARK: - Construction
    
    required init(
        view: CapsuleDetailsViewControllerProtocol,
        router: RouterProtocol,
        model: CapsuleDetailsModel
    ) {
        self.view = view
        self.router = router
        self.model = model
    }
}

// MARK: - CapsuleDetailsPresenterProtocol

extension CapsuleDetailsPresenter: CapsuleDetailsPresenterProtocol {
    func setView() {
        viewModel.navigationTitle = "Capsule " + model.serial
        loadCapsule()
        self.view?.setView(with: viewModel)
    }
}

// MARK: - Helper Functions

extension CapsuleDetailsPresenter {
    private func loadCapsule() {
        self.router.showLoader()
        spaceXDataService.getCapsule(serial: model.serial) { [weak self] result in
            guard let self = self else { return }
            sleep(Constants.delay)
            switch result {
            case .success(let response):
                guard let capsules = response else { return }
                self.configureCapsule(with: capsules)
                self.router.hideLoader()
            case .failure(let error):
                self.router.hideLoader()
                debugPrint(error)
            }
        }
    }
    
    func configureCapsule(with response: CapsuleMo) {
        var capsuleValues: [CapsuleDetailsCellViewModel] = []
        
        capsuleValues.append(
            CapsuleDetailsCellViewModel(
                title: "Symbol",
                value: "🛰"
            )
        )
        
        capsuleValues.append(
            CapsuleDetailsCellViewModel(
                title: "Landings",
                value: response.landings?.numberToString ?? "No info"
            )
        )
        
        capsuleValues.append(
            CapsuleDetailsCellViewModel(
                title: "Details",
                value: response.details ?? "No info"
            )
        )
        
        viewModel.capsuleValues = capsuleValues
        self.view?.setView(with: viewModel)
    }
}
