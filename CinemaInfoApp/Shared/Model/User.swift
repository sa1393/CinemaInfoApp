import Foundation

struct User: Codable {
    var id: String?
    var name: String?
    var pwd: String?
    var profile: String?
    
    var profileURL: URL? {
        if let profile = profile {
            if !profile.isEmpty {
                return URL(string: "\(SecretText.baseURL)users/images/\(profile)")
            }
            else {
                return nil
            }
        }
        else {
             return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pwd
        case profile = "profile_url"
    }
}

struct UserResponse: Codable {
    var result: User?
}

struct SignUser: Codable {
    var id: String?
    var pwd: String?
}
