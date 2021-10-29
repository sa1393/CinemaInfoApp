import Foundation

struct User: Codable {
    var id: String?
    var name: String?
    var pwd: String?
    var profile: Data?
    
    enum Codingkeys: String, CodingKey {
        case id
        case name
        case pwd
        case profile = "img"
    }
}

struct UserResponse: Codable {
    var result: User?
}

struct LoginUser: Codable {
    var id: String?
    var pwd: String?
}
