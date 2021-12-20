//
//  CapsulesViewModel.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 12.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

class CapsulesViewModel: ObservableObject {
    let navigationTitle: String = "Capsules"
    @Published var capsules: [CapsuleCellViewModel] = []
}
