import Foundation

struct Review: Codable, Identifiable, Hashable {
    var id = UUID().uuidString
    var idx: Int?
    var movie_id: String?
    var site: String?
    var created: String?
    var writer: String?
    var comment: String?
    var likeNum: Int?
    var ratingNum: Int?
    
    enum CodingKeys: String, CodingKey {
        case idx
        case movie_id = "movie_id"
        case site
        case created
        case writer
        case comment
        case likeNum = "like_num"
        case ratingNum = "rating_num"
    }
}

struct ReviewInsert: Codable {
    var movieId: String
    var comment: String
    var ratingNum: Int
    
    enum CodingKeys: String, CodingKey {
        case movieId = "movie_id"
        case comment
        case ratingNum = "rating_num"
    }
}

struct ReviewEdit: Codable {
    var idx: Int
    var movieId: String
    var comment: String
    var ratingNum: Int
    
    enum CodingKeys: String, CodingKey {
        case idx
        case movieId = "movie_id"
        case comment
        case ratingNum = "rating_num"
    }
}


struct ReviewDelete: Codable {
    var idx: Int
    var movieId: String
    
    
    enum CodingKeys: String, CodingKey {
        case idx
        case movieId = "movie_id"
    }
}
