import Foundation

class Address {
    var fullAddress: String

    init(fullAddress: String) {
        self.fullAddress = fullAddress
    }
}

typealias DidGetPhotos = (_ photos: Array<Any>) -> Void

class Player {
    var name: String
    var address: Address
    var didGetPhotos: DidGetPhotos?

    init(name: String, address: Address) {
        self.name = name
        self.address = address
    }

    func getPhotos() {
        // we assume that we downloaded some photos from server and assigned them to photos variable
        let photos = [Any]()

        if let didGetPhotos = didGetPhotos {
            didGetPhotos(photos)
        }
    }
}
