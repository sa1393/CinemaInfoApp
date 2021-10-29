import Foundation

struct MovieResponse: Codable {
    let movies: [AllMovie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "movies"
    }
}

struct ResultBoolResponse: Codable {
    let result: Bool
}

struct ResultStringResponse: Codable {
    let result: String
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

struct MyReviewResponse: Codable {
    let movies: [AllMovie]
    let reviews: [Review]
}
