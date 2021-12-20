//
//  LaunchesViewModel.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 12.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct LaunchesViewModel {
    var navigationTitle: String = ""
    var launches: [LaunchesCellViewModel] = []
}

struct LaunchesCellViewModel {
    let id: UUID = UUID()
    var name: String = "unnamed"
    var details: String = "no data"
    var launchYear: String = "no year"
    var imageURL: String = ""
}
