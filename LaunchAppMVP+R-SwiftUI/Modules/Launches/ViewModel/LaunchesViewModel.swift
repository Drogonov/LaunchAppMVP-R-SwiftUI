//
//  LaunchesViewModel.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 12.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

class LaunchesViewModel: ObservableObject {
    let navigationTitle: String = "Launches"
    @Published var launches: [LaunchesCellViewModel] = []
}
