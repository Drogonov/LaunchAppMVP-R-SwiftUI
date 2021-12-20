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
    private var capsulesCollectionView = CapsulesCollectionView()
    
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
        configureCollectionView()
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
    
    private func configureCollectionView() {
        capsulesCollectionView.delegate = self
        capsulesCollectionView.set(capsules: [])
        addUIViewToViewController(capsulesCollectionView)
    }
    
    private func configureView(with viewModel: CapsulesViewModel) {
        capsulesCollectionView.set(capsules: viewModel.capsules)
    }
}

// MARK: - CapsulesViewControllerProtocol

extension CapsulesViewController: CapsulesViewControllerProtocol {
    func setView(with viewModel: CapsulesViewModel) {
        configureNavigationBar(navigationTitle: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}

// MARK: - CapsulesCollectionViewDelegate

extension CapsulesViewController: CapsulesCollectionViewDelegate {
    func capsuleTapped(with capsuleSerial: String?) {
        presenter?.routeToDetails(with: capsuleSerial, and: self)
    }
}
