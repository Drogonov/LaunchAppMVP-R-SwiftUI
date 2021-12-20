//
//  SettingsViewController.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 17.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SettingsViewControllerProtocol: AnyObject {
    func setView(with viewModel: SettingsViewModel)
}

class SettingsViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: SettingsPresenterProtocol?
    private lazy var settingsView = SettingsView(
        confirmButtonTapped: {
            self.confirmButtonTapped()
        }
    )

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - Configure UI

extension SettingsViewController {
    private func configureUI() {
        presenter?.setView()
        configureSettingsView()
    }
    
    private func configureNavigationBar(navigationTitle: String) {
        setNavigationBarTitle(with: navigationTitle)
    }
    
    private func configureSettingsView() {
        addMainViewToViewController(settingsView)
    }
    
    private func configureView(with viewModel: SettingsViewModel) {
        settingsView.model = viewModel
    }
}

// MARK: - SettingsViewControllerProtocol

extension SettingsViewController: SettingsViewControllerProtocol {
    func setView(with viewModel: SettingsViewModel) {
        configureNavigationBar(navigationTitle: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}

// MARK: - Helper Functions

extension SettingsViewController {
    private func confirmButtonTapped() {
        showNotification(
            title: "You confirmed new settings!",
            message: "Now your app is updated",
            defaultAction: true,
            defaultActionText: "OK",
            completion: {_,_ in }
        )
    }
}
