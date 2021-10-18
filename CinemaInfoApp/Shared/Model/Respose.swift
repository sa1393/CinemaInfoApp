import Foundation

struct MovieResponse: Codable {
    let movies: [AllMovie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "movies"
    }
}

struct MovieRankResponse: Codable {
    let movies: [RankMovie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "movies"
    }
}

struct MovieRatingResponse: Codable {
    let movies: [RatingMovie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "movies"
    }
}


struct ReviewResponse: Codable {
    let reviews: [Review]
    
    enum CodingKeys: String, CodingKey {
        case reviews = "reviews"
    }
}


