//
//  Router.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 12.12.2021.
//

import Foundation
import UIKit

protocol RouterProtocol {
    
    init(
        tabBarController: MainTabBarController,
        mainTabBarBuilder: MainTabBarBuilderProtocol
    )
    
    func initialMainTabBar()
    func showDetailCapsules(with vc: UIViewController, and model: CapsuleDetailsModel)
    func showSettings(with model: SettingsModel)
    
    func showLoader()
    func hideLoader()
}

import UIKit

class Router {
    
    // MARK: - Properties
    
    var tabBarController: MainTabBarController
    var mainTabBarBuilder: MainTabBarBuilderProtocol
    
    // MARK: - Construction
    
    required init(
        tabBarController: MainTabBarController,
        mainTabBarBuilder: MainTabBarBuilderProtocol
    ) {
        self.tabBarController = tabBarController
        self.mainTabBarBuilder = mainTabBarBuilder
    }
    
}

extension Router: RouterProtocol {
    func initialMainTabBar() {
        let launchesController = mainTabBarBuilder.launchesBuilder.createLaunchesModule(router: self)
        let capsulesController = mainTabBarBuilder.capsulesBuilder.createCapsulesModule(router: self)
        
        let vcArray: [(vc: UIViewController, tabBarItemType: TabBarItemType)] = [
            (vc: launchesController, tabBarItemType: .launches),
            (vc: capsulesController, tabBarItemType: .capsules)
        ]
        
        tabBarController.configureTabBar(with: vcArray)
    }
            
    func showDetailCapsules(with vc: UIViewController, and model: CapsuleDetailsModel) {
        let detailViewController = mainTabBarBuilder.capsulesBuilder.createCapsuleDetailsModule(
            router: self,
            model: model
        )
        guard let navController = tabBarController.getNavController(with: vc) else { return }
        navController.pushViewController(detailViewController, animated: true)
    }
    
    func showSettings(with model: SettingsModel) {
        let settingsViewController = mainTabBarBuilder.settingsBuilder.createSettingsModule(
            router: self,
            model: model
        )
        let navController = UINavigationController(rootViewController: settingsViewController)
        settingsViewController.modalPresentationStyle = .formSheet
        tabBarController.present(navController, animated: true, completion: nil)
    }
    
    func showLoader() {
        tabBarController.showLoader()
    }
    
    func hideLoader() {
        tabBarController.hideLoader()
    }
}
