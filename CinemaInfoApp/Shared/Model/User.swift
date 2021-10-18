import Foundation


struct User: Codable {
    var id: String?
    var name: String?
    var pwd: String?
    var profileURL: String?
    
    enum Codingkeys: String, CodingKey {
        case id
        case name
        case pwd
        case profileURL = "profile_url"
    }
}

struct UserResponse: Codable {
    var result: User
}

struct LoginUser: Codable {
    var id: String?
    var pwd: String?
}
