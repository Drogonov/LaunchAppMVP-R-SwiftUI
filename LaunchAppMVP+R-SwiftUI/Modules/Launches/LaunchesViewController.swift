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
    private var launchesTableView = LaunchesTableView()
    
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
        configureTableView()
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
    
    private func configureTableView() {
        launchesTableView.set(launches: [])
        addUIViewToViewController(launchesTableView)
    }
    
    private func configureView(with viewModel: LaunchesViewModel) {
        launchesTableView.set(launches: viewModel.launches)
    }
}

// MARK: - LaunchesViewControllerProtocol

extension LaunchesViewController: LaunchesViewControllerProtocol {
    func setView(with viewModel: LaunchesViewModel) {
        configureNavigationBar(navigationTitle: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}
