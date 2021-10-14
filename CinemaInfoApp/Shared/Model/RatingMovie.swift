import Foundation
import SwiftUI
import Combine

struct RatingMovie: Codable, MovieProtocol{
    var movieId: String
    var title: String
    var engTitle: String
    var productionYear:String
    var productionCountry: String
    var sizeType: String
    var genore: String
    var productionStatus: String
    var posterImg: String
    var releaseDate: String
    var updateDate: String
    var memo: String
    var director: String
    var actor: String
    var story: String
    var rating_num: String
    var site: String
    var created: String
    var jqplotSex: jqplotSex
    var jqplotAge: jqplotAge
    
    var movie: Movie {
        Movie(movieId: movieId, title: title, engTitle: engTitle, productionYear: productionYear, productionCountry: productionCountry, sizeType: sizeType, genore: genore, productionStatus: productionStatus, posterImg: posterImg, releaseDate: releaseDate, updateDate: updateDate, memo: memo, director: director, actor: actor, story: story)
    }
    
    
    enum CodingKeys: String, CodingKey {
        case movieId = "movie_id"
        case title
        case engTitle = "eng_title"
        case productionYear = "production_year"
        case productionCountry = "production_country"
        case sizeType = "size_type"
        case genore
        case productionStatus = "production_status"
        case posterImg = "poster_img"
        case releaseDate = "release_date"
        case updateDate = "updated_date"
        case memo
        case director = "director"
        case actor
        case story
        case rating_num = "rating_num"
        case site
        case created
        case jqplotSex = "jqplot_sex"
        case jqplotAge = "jqplot_age"
    }
}

