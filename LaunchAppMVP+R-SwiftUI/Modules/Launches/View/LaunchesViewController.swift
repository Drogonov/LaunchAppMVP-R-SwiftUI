//
//  LaunchesViewController.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 12.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LaunchesViewControllerProtocol: AnyObject {
    func setView(with viewModel: LaunchesViewModel)
}

class LaunchesViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: LaunchesPresenterProtocol?
    var launchesView = LaunchesView()
    
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

extension LaunchesViewController {
    private func configureUI() {
        presenter?.setView()
        configureLaunchesView()
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
    
    private func configureLaunchesView() {
        addMainViewToViewController(launchesView)
    }
    
    private func configureView(with viewModel: LaunchesViewModel) {
        launchesView.model = viewModel
    }
}

// MARK: - LaunchesViewControllerProtocol

extension LaunchesViewController: LaunchesViewControllerProtocol {
    func setView(with viewModel: LaunchesViewModel) {
        configureNavigationBar(navigationTitle: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}
