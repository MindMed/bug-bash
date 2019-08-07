import Foundation

class Address {
  var fullAddress: String
  
  init(fullAddress: String) {
    self.fullAddress = fullAddress
  }
}

class Player {
  var name: String
  var address: Address
  
  init(name: String, address: Address) {
    self.name = name
    self.address = address
  }
}
