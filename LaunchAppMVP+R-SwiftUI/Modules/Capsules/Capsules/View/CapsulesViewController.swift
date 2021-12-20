//
//  CapsulesViewController.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 12.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CapsulesViewControllerProtocol: AnyObject {
    func setView(with viewModel: CapsulesViewModel)
}

class CapsulesViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: CapsulesPresenterProtocol?
    lazy var capsulesView = CapsulesView(
        capsuleTapped: { capsuleSerial in
            self.presenter?.routeToDetails(with: capsuleSerial, and: self)
        }
    )
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func settingsTapped() {
        presenter?.routeToSettings(with: self)
    }
}

// MARK: - Configure UI

extension CapsulesViewController {
    private func configureUI() {
        presenter?.setView()
        configureCapsulesView()
    }
    
    private func configureNavigationBar(navigationTitle: String) {
        setNavigationBarTitle(with: navigationTitle)
        let image = UIImage(systemName: "gear")!
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(settingsTapped)
        )
    }
    
    private func configureCapsulesView() {
        addMainViewToViewController(capsulesView)
    }
    
    private func configureView(with viewModel: CapsulesViewModel) {
        capsulesView.model = viewModel
    }
}

// MARK: - CapsulesViewControllerProtocol

extension CapsulesViewController: CapsulesViewControllerProtocol {
    func setView(with viewModel: CapsulesViewModel) {
        configureNavigationBar(navigationTitle: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}
