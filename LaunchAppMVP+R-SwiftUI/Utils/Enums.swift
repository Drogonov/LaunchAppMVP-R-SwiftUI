//
//  Enums.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 17.12.2021.
//

import UIKit

enum TabBarItemType {
    case launches
    case capsules
    
    var type: UITabBarItem {
        switch self {
        case .launches:
            return UITabBarItem(
                title: "Launches",
                image: UIImage(systemName: "capslock")!,
                selectedImage: UIImage(systemName: "capslock.fill")!
            )
            
        case .capsules:
            return UITabBarItem(
                title: "Capsules",
                image: UIImage(systemName: "bolt.car")!,
                selectedImage: UIImage(systemName: "bolt.car.fill")!
            )
        }
    }
}

enum NotificationConfiguration {
    case textField
    case defaultAction
    case rejectAction
    
    init() {
        self = .defaultAction
    }
}
