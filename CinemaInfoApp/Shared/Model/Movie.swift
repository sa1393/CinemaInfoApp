import Foundation

protocol MovieProtocol{
    var movie: Movie { get }
}

struct Movie: Hashable, Equatable {
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
    
    var posterImgURL: URL? {
        if posterImg.isEmpty {
            return nil
        }
        
        if let url = URL(string: "\(SecretText.baseURL)images/beta/\(posterImg)") {
            return url
        }else {
            return nil
        }
    }
    
    
    var allGenore: [GenoreType?] {
        let tempGenore = genore.trimmingCharacters(in: [" "])
        let genoreArr = tempGenore.components(separatedBy: ",")
        
        let resultGenore = genoreArr.map{GenoreType(rawValue: "\($0)") ?? GenoreType.guitar}
        return resultGenore
    }
    
    var memos: [String] {
        let tempMemo = memo.trimmingCharacters(in: [" "])
        
        return tempMemo.components(separatedBy: "|")
    }
    
    var duration: String {
        let tempDuration: String? = memos.filter{$0.contains("분") && $0.contains("초")}[0]
        return tempDuration ?? ""
    }
    
    var age: AgeType {
        let tempYear: String = (memos.filter{$0.contains("관람가") || $0.contains("관람불가")}[0] ).trimmingCharacters(in: [" "])
        
        return AgeType(rawValue: tempYear) ?? AgeType.adult
    }
    
    var movieSizeType: SizeType {
        switch sizeType {
        case "장편" :
            return .long
        
        case "단편" :
            return .short
            
        default :
            return .long
        }
    }
    
    var favorite: Bool {
        return false
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
    }

}

enum AgeType : String, CaseIterable {
    case adult = "청소년관람불가"
    case youth = "15세관람가"
    case youthAfter = "15세이상관람가"
    case child = "12세이상관람가"
    case all = "전체관람가"
}

enum GenoreType : String, CaseIterable {
    case horror = "공포(호러)"
    case thriller = "스릴러"
    case action = "액션"
    case comedy = "코미디"
    case sf = "SF"
    case crime = "범죄"
    case romence = "멜로/로맨스"
    case mistery = "미스터리"
    case family = "가족"
    case documentory = "다큐멘터리"
    case war = "전쟁"
    case adventure = "어드벤처"
    case fantasy = "판타지"
    case animation = "애니메이션"
    case ero = "성인물(에로)"
    case drama = "드라마"
    case guitar = "기타"
    case all = "전체"
}

enum SizeType : String{
    case long = "장편"
    case short = "기타"
}
