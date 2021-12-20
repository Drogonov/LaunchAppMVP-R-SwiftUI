//
//  LaunchMo.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 12.12.2021.
//

import Foundation

// MARK: - LaunchMo

struct LaunchMo: Codable {
    let flightNumber: Int?
    let missionName: String?
    let details: String?
    let launchYear: String?
    let links: Links?


    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case details = "details"
        case launchYear = "launch_year"
        case links = "links"
    }
}

// MARK: - Links

struct Links: Codable {
    let missionPatch: String?
    let missionPatchSmall: String?

    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
        case missionPatchSmall = "mission_patch_small"
    }
}
