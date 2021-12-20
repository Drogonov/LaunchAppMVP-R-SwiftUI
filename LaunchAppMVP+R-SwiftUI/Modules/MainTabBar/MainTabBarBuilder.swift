//
//  MainTabBarBuilder.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 13.12.2021.
//

import UIKit

protocol MainTabBarBuilderProtocol {
    var launchesBuilder: LaunchesBuilderProtocol { get set }
    var capsulesBuilder: CapsulesBuilderProtocol { get set }
    var settingsBuilder: SettingsBuilderProtocol { get set }
    
    init(
        launchesBuilder: LaunchesBuilderProtocol,
        capsulesBuilder: CapsulesBuilderProtocol,
        settingsBuilder: SettingsBuilderProtocol
    )
}

class MainTabBarBuilder: MainTabBarBuilderProtocol {
    var launchesBuilder: LaunchesBuilderProtocol
    var capsulesBuilder: CapsulesBuilderProtocol
    var settingsBuilder: SettingsBuilderProtocol
    
    required init(
        launchesBuilder: LaunchesBuilderProtocol = LaunchesBuilder(),
        capsulesBuilder: CapsulesBuilderProtocol = CapsulesBuilder(),
        settingsBuilder: SettingsBuilderProtocol = SettingsBuilder()
    ) {
        self.launchesBuilder = launchesBuilder
        self.capsulesBuilder = capsulesBuilder
        self.settingsBuilder = settingsBuilder
    }
}
