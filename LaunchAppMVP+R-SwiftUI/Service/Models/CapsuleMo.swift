//
//  CapsuleMo.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 12.12.2021.
//

import Foundation

// MARK: - CapsuleMo

struct CapsuleMo: Codable {
    let capsuleID: String
    let capsuleSerial: String?
    let details: String?
    let landings: Int?
    let missions: [Mission]?
    let originalLaunch: String?
    let originalLaunchUnix: Int?
    let reuseCount: Int?
    let status: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case capsuleID = "capsule_id"
        case capsuleSerial = "capsule_serial"
        case details = "details"
        case landings = "landings"
        case missions = "missions"
        case originalLaunch = "original_launch"
        case originalLaunchUnix = "original_launch_unix"
        case reuseCount = "reuse_count"
        case status = "status"
        case type = "type"
    }
}

// MARK: - Mission

struct Mission: Codable {
    let name: String
    let flight: Int
}
