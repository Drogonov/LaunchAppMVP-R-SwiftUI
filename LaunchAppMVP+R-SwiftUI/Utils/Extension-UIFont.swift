//
//  Extension-
UIFont.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 20.12.2021.
//

import UIKit
import SwiftUI

extension Font {
    static let titleFont = Font(UIFont.titleFont)
    static let subtitleFont = Font(UIFont.subtitleFont)
    static let bodyFont = Font(UIFont.bodyFont)
    static let emojiFont = Font(UIFont.emojiFont)
}

extension UIFont {
    static let titleFont = UIFont.systemFont(ofSize: 20, weight: .bold)
    static let subtitleFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
    static let bodyFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    static let emojiFont = UIFont.systemFont(ofSize: 64, weight: .bold)
}
