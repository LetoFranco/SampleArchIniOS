//
//  RespositorableTests.swift
//  ArquitecturaTests
//
//  Created by Franco Leto on 18/10/2022.
//

import Foundation
import XCTest
@testable import Arquitectura

class CarRepositoryTests: XCTestCase {

  func testFetchLocalIfExists() throws {
    let localStorage = MockCarStorage(Car.mock)
    let remoteStorage = MockCarStorage()
    
    let sut = CarRepository(localAPI: localStorage, remoteAPI: remoteStorage)
    
    let expectation = XCTestExpectation(description: "Al cargar el auto se trae de local ya que existe")
    sut.load { result in
      switch result {
      case .success: expectation.fulfill()
      case .failure: break
      }
    }
    
    wait(for: [expectation], timeout: 3)
  }
  
  func testSyncFromRemote() {
    let localStorage = MockCarStorage()
    let remoteStorage = MockCarStorage(Car.mock)
    
    let sut = CarRepository(localAPI: localStorage, remoteAPI: remoteStorage)
    
    let expectation = XCTestExpectation(description: "Al cargar el auto se trae de remoto porque no existe en local")
    XCTAssertNil(localStorage.car)
    sut.load { result in
      switch result {
      case .success:
        expectation.fulfill()
        XCTAssertNotNil(localStorage.car)
        XCTAssertNotNil(remoteStorage.car)
        XCTAssertEqual(localStorage.car!.id, remoteStorage.car!.id)
      case .failure: break
      }
    }
    
    wait(for: [expectation], timeout: 3)
  }
}

class MockCarStorage: CarStorable {
  
  private (set) var car: Car?
  
  init(_ car: Car? = nil) {
    self.car = car
  }
  
  func fetch(_ callback: @escaping (Result<Car, Error>) -> Void) {
    guard let car = car else {
      callback(.failure(TestError.nonExistingElement))
      return
    }
    callback(.success(car))
  }
  
  func store(_ model: Car, callback: @escaping () -> Void) {
    self.car = model
    callback()
  }
}

extension Car {
  static var mock: Car {
    Car(id: "123", model: "Fiat")
  }
  
  static var mock1: Car {
    Car(id: "23", model: "Audi")
  }
}

enum TestError: Error {
  case nonExistingElement
}
