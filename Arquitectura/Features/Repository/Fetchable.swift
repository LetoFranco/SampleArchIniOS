//
//  Fetchable.swift
//  Arquitectura
//
//  Created by Franco Leto on 19/10/2022.
//

import Foundation

protocol FetchableCallback {
  associatedtype Model
  
  func fetch(_ callback: @escaping (Result<Model, Error>) -> Void)
}

protocol AsyncFetchable {
  associatedtype Model
  func fetch() async throws -> Model
}
