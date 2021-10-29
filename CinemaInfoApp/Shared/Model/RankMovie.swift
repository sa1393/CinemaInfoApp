import Foundation
import Combine
import SwiftUI

struct RankMovie: Codable, MovieProtocol{
    var movieId: String?
    var title: String?
    var engTitle: String?
    var productionYear:String?
    var productionCountry: String?
    var sizeType: String?
    var genore: String?
    var productionStatus: String?
    var posterImg: String?
    var releaseDate: String?
    var updateDate: String?
    var memo: String?
    var director: String?
    var actor: String?
    var story: String?
   
    var site: String?
    var created: String?
    var reservationRate: Float?
    var sales: Int?
    var audienceCount: Int?
    var jqplotSex: jqplotSex?
    var jqplotAge: jqplotAge?
    var charmPoint: charmPoint?
    
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
        case site
        case created
        case reservationRate = "reservation_rate"
        case sales = "sales"
        case audienceCount = "audience_count"
        case jqplotSex = "jqplot_sex"
        case jqplotAge = "jqplot_age"
        case charmPoint = "charm_point"
    }
}

struct jqplotSex : Codable {
    var mal: Int?
    var fem: Int?
}

struct jqplotAge: Codable {
    var oneAge: Int?
    var twoAge: Int?
    var threeAge: Int?
    var fourAge: Int?
    var fiveAge: Int?
    
    enum CodingKeys: String, CodingKey {
        case oneAge = "10"
        case twoAge = "20"
        case threeAge = "30"
        case fourAge = "40"
        case fiveAge = "50"
    }
}

struct charmPoint: Codable {
    var derected: Int?
    var actor: Int?
    var story: Int?
    var visulBeauty: Int?
    var ost: Int?
    
    enum CodingKeys: String, CodingKey {
        case derected
        case actor
        case story
        case visulBeauty = "visual_beauty"
        case ost
    }
    
}
