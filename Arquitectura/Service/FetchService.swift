import Foundation

struct Product: Codable {
  let name: String
  let price: Double
  let extraDetails: String
  let location: String
  let imageUrl: String
  let isLiked: Bool
  
  static var mock1: Product {
    .init(name: "Prueba Producto 1", price: 20000000, extraDetails: "2019 - 37.000 Km", location: "Algun Lugar, Caba", imageUrl: "", isLiked: true)
  }
  
  static var mock2: Product {
    .init(name: "Prueba Producto 2", price: 3000, extraDetails: "2020 - 10.000 Km", location: "Otro Lugar, Caba", imageUrl: "", isLiked: false)
  }
  
}

protocol FetchService {
  func fetch(_ callback: @escaping ([String]) -> Void)
  func fetch(_ callback: @escaping ([Product]) -> Void)
}

struct MockFetchService: FetchService {
  
  func fetch(_ callback: @escaping ([String]) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      callback(["Value1", "Value2"])
    }
  }
  
  func fetch(_ callback: @escaping ([Product]) -> Void) {
    callback([Product.mock1, Product.mock2])
  }
}


struct RestFetchService: FetchService {
  
  func fetch(_ callback: @escaping ([String]) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      callback(["Value1", "Value2"])
    }
  }
  
  func fetch(_ callback: @escaping ([Product]) -> Void) {
    callback([])
  }
}
