//
//  Storable.swift
//  Arquitectura
//
//  Created by Franco Leto on 19/10/2022.
//

import Foundation

protocol StorableCallback: FetchableCallback {
  associatedtype Model
  
  func store(_ model: Model, callback: @escaping (Result<Model, Error>) -> Void)
}


protocol AsyncStorable: AsyncFetchable {
  associatedtype Model
  
  func store(_ model: Model) async throws -> Model
}
