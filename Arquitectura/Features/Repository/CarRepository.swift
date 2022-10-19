//
//  CarRepository.swift
//  Arquitectura
//
//  Created by Franco Leto on 19/10/2022.
//

import Foundation

struct Car {
  let id: String
  let model: String
}

protocol CarFetchable {
  func fetch(_ callback: @escaping (Result<Car, Error>) -> Void)
}

protocol CarStorable: CarFetchable {
  func store(_ model: Car, callback: @escaping () -> Void)
}

struct CarRepository {
  
  let localAPI: CarStorable
  let remoteAPI: CarStorable
  
  func sync(_ callback: @escaping (Result<Car,Error>) -> Void) {
    remoteAPI.fetch { result in
      switch result {
      case .success(let car):
        localAPI.store(car) {
          callback(.success(car))
        }
      case .failure(let error):
        callback(.failure(error))
      }
    }
  }
  
  func load(_ callback: @escaping (Result<Car,Error>) -> Void) {
    localAPI.fetch { result in
      switch result {
      case .success(let car): callback(.success(car))
      case .failure: sync(callback)
      }
    }
  }
}


