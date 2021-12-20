//
//  SpaceXDataAPI.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 10.12.2021.
//

import Foundation
import Moya

enum SpaceXDataAPI {
    case getCapsules
    case getCapsule(serial: String)
    case getLaunches
}

extension SpaceXDataAPI: TargetType {
    var baseURL: URL {
        Constants.baseURL
    }
    
    var path: String {
        switch self {
        case .getCapsules:
            return "/capsules"
        case .getLaunches:
            return "/launches"
        case .getCapsule(serial: let serial):
            return "/capsules/" + serial
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCapsules,
             .getLaunches,
             .getCapsule:
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        default: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
