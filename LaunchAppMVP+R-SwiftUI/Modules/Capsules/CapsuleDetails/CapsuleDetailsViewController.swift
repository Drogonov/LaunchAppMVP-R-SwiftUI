//
//  CapsuleDetailsViewController.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 13.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CapsuleDetailsViewControllerProtocol: AnyObject {
    func setView(with viewModel: CapsuleDetailsViewModel)
}

class CapsuleDetailsViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: CapsuleDetailsPresenterProtocol?
    private var capsuleTableView = CapsuleDetailsTableView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - Configure UI

extension CapsuleDetailsViewController {
    private func configureUI() {
        presenter?.setView()
        configureTableView()
        view.backgroundColor = .systemGroupedBackground
    }
    
    private func configureNavigationBar(navigationTitle: String) {
        setNavigationBarTitle(with: navigationTitle)
    }
    
    private func configureTableView() {
        capsuleTableView.set(capsuleValues: [])
        addUIViewToViewController(capsuleTableView)
    }
    
    private func configureView(with viewModel: CapsuleDetailsViewModel) {
        capsuleTableView.set(capsuleValues: viewModel.capsuleValues)
    }
}

// MARK: - CapsuleDetailsViewControllerProtocol

extension CapsuleDetailsViewController: CapsuleDetailsViewControllerProtocol {
    func setView(with viewModel: CapsuleDetailsViewModel) {
        configureNavigationBar(navigationTitle: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}
