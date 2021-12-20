//
//  Constants.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 10.12.2021.
//

import UIKit
import SwiftUI

struct Display {
    static var width = UIScreen.main.bounds.width
    static var height = UIScreen.main.bounds.width
}

struct Constants {
    static let baseUrlString = "https://api.spacexdata.com/v3"
    static let baseURL: URL = {
        URL(string: baseUrlString)!
    }()
    
    static let delay: UInt32 = 1
    static let smallPadding: CGFloat = 8
    static let standartPadding: CGFloat = 16
    static let imageSize: CGFloat = 120
    static let buttonHeight: CGFloat = 40
    static let cornerRadius: CGFloat = 10
}
