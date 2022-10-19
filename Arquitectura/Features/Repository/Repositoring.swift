//
//  Repository.swift
//  Arquitectura
//
//  Created by Franco Leto on 19/10/2022.
//

import Foundation

struct RepositoryWithCallbacks<LocalStorage: StorableCallback, RemoteStorage: StorableCallback, Model: Codable>
where LocalStorage.Model == Model, RemoteStorage.Model == Model {
  
  let localStorage: LocalStorage
  let remoteStorage: RemoteStorage
  
  func sync(_ callback: @escaping (Result<Model, Error>) -> Void) {
    remoteStorage.fetch { result in
      switch result {
      case .success(let model):
        localStorage.store(model, callback: callback)
      case .failure(let error):
        callback(.failure(error))
      }
    }
  }
  
  func load(_ callback: @escaping (Result<Model, Error>) -> Void) {
    localStorage.fetch { result in
      switch result {
      case .success(let model):
        callback(.success(model))
      case .failure:
        sync(callback)
      }
    }
  }
}
