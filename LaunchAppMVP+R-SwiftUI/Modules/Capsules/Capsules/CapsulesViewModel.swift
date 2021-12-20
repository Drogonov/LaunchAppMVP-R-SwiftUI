//
//  CapsulesViewModel.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 12.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

struct CapsulesViewModel {
    var navigationTitle: String = ""
    var capsules: [CapsuleCellViewModel] = []
}

struct CapsuleCellViewModel {
    let id: UUID = UUID()
    var statusButtonColor: UIColor
    var capsuleName: String
    var capsuleEmoji: String
}
