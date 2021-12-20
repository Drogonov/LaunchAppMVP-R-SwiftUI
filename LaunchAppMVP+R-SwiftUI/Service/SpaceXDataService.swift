//
//  SpaceXDataService.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 12.12.2021.
//

import Foundation
import Moya

// Протокол репозитория для взаимодействия с акциями
protocol SpaceXDataServiceProtocol {
    /// получение списка блока выгодно
    func getLaunchesList(
        completion: @escaping ((Result<[LaunchMo]?, HTMAPIError>) -> Void)
    )
    /// получение списка блока акции
    func getCapsulesList(
        completion: @escaping ((Result<[CapsuleMo]?, HTMAPIError>) -> Void)
    )
    
    func getCapsule(
        serial: String,
        completion: @escaping ((Result<CapsuleMo?, HTMAPIError>) -> Void)
    )
}

final class SpaceXDataService: SpaceXDataServiceProtocol, Injectable {
    
    private let provider = MoyaProvider<SpaceXDataAPI>()
    
    func getLaunchesList(completion: @escaping ((Result<[LaunchMo]?, HTMAPIError>) -> Void)) {
        provider.request(
            .getLaunches
        ) { result in
            switch result {
            case .success(let response):
                guard let responseModel = try? response.map([LaunchMo].self) else {
                    completion(.failure(.deserialization))
                    return
                }
                completion(.success(responseModel))
            case .failure(let error):
                print(error)
                completion(.failure(.unknown))
            }
        }
    }
    
    func getCapsulesList(completion: @escaping ((Result<[CapsuleMo]?, HTMAPIError>) -> Void)) {
        provider.request(
            .getCapsules
        ) { result in
            switch result {
            case .success(let response):
                guard let responseModel = try? response.map([CapsuleMo].self) else {
                    completion(.failure(.deserialization))
                    return
                }
                completion(.success(responseModel))
            case .failure(let error):
                print(error)
                completion(.failure(.unknown))
            }
        }
    }
    
    func getCapsule(serial: String, completion: @escaping ((Result<CapsuleMo?, HTMAPIError>) -> Void)) {
        provider.request(
            .getCapsule(serial: serial)
        ) { result in
            switch result {
            case .success(let response):
                guard let responseModel = try? response.map(CapsuleMo.self) else {
                    completion(.failure(.deserialization))
                    return
                }
                completion(.success(responseModel))
            case .failure(let error):
                print(error)
                completion(.failure(.unknown))
            }
        }
    }
}
