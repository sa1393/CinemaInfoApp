import Foundation
import SwiftUI

let exampleMovie1 = AllMovie(movieId: "20078605", title: "낙엽귀근", engTitle: "Getting Home", productionYear: "2008", productionCountry: "중국", sizeType: "장편", genore: "코미디", productionStatus: "개봉", posterImg: "1626227128446_ea6fab6f794e4f58aa2eccdd08ce6f74.jpg", releaseDate: "감동 로드 트립 코미디", updateDate: "2021-03-02 14:27:54", memo: "장편 | 예술영화 | 코미디 | 101분 0초 | 15세이상관람가 | 중국", director: "장양", actor: "{}", story: "함께 일하던 절친한 친구가 갑작스런 죽음을 맞자\n사내는 고향의 가족 곁에 묻히게 해주겠다는\n살아생전 약속을 지키기 위해 시체를 짊어지고 먼 길을 떠난다.\n\n시체를 태운 버스 안에서 만난 강도.\n사랑하는 여인에게 뒤통수를 맞은 사내.\n5000m 산을 등반하며 자신과의 싸움을 해가는 남자.\n보일러 사고로 한쪽 얼굴을 잃어버린 여자.\n살아 있으면서 자신의 장례식을 지켜보는 노인까지.\n\n죽은 친구를 업고 가는 기막힌 동행길.\n사내는 세상에서 가장 특별한 인연들을 길 위에서 만나는데…")

let exampleMovie2 = AllMovie(movieId: "19848168", title: "블러드 심플", engTitle: "Blood Simple", productionYear: "1998", productionCountry: "미국", sizeType: "장편", genore: "범죄,드라마,스릴러", productionStatus: "개봉", posterImg: "1625710293371_47e4011d069644f5bd9f1e36d7274e59.jpg", releaseDate: "2019-10-17", updateDate: "2019-10-17 14:57:29", memo: "장편 | 예술영화 | 범죄, 드라마, 스릴러 | 95분 35초 | 15세이상관람가 | 미국", director: "조엘 코엔", actor: "{}", story: "삐뚤어진 욕망, 한 번의 잘못된 선택\n추잡한 비극이 시작된다!\n\n텍사스의 한마을, 술집을 운영하는 마티에게\n사립탐정 비저가 찾아와 그의 아내 애비와\n종업원 레이가 불륜을 저지르고 있다고 알려준다.\n마티는 레이를 해고하고 애비를 추궁하지만\n오히려 적반하장의 그들의 모습에 분노하게 되고\n비저에게 청부살인을 의뢰한다.\n그러나 딴 곳에 마음을 품은 비저는 해서는 안 될\n선택을 하게 되고 모두를 파극으로 밀어 넣게 되는데...")

let exampleMovie3 = AllMovie(movieId: "19878294", title: "모리스", engTitle: "Maurice", productionYear: "1987", productionCountry: "영국", sizeType: "장편", genore: "드라마,멜로/로맨스", productionStatus: "개봉", posterImg: "1625710059978_c806a95cc57b43e08c0ea37bb1139352.jpg", releaseDate: "2019-11-07", updateDate: "2019-11-14 15:19:31", memo: "장편 | 예술영화 | 드라마, 멜로/로맨스 | 140분 8초 | 15세이상관람가 | 영국", director: "제임스 아이보리", actor: "{}", story: "20세기 초 영국.")

let exampleReview1 = Review(id: UUID().uuidString, idx: 102717, movie_id: "20218904", site: "naver", created: "2021-08-31 09:35", writer: " 사자갈기를갈기갈기(kidi****)", comment: "올해의 영화입니다 꼭 보세요. 마스크는 꼭 새거 챙겨가세요. 3번쯤 눈물 수도꼭지 터집니다. 기분 좋은 눈물이고 상쾌유쾌경쾌하게 볼 수 있으니 걱정은 마세요", likeNum: 44, ratingNum: 10)

var exampleCategory: [String: [MovieProtocol]] = ["test": [exampleMovie1, exampleMovie2, exampleMovie3]]

extension String {
   func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height

}

extension EnvironmentValues {
    var isPreview: Bool {
        #if DEBUG
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        #else
        return false
        #endif
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


//reviews": [
//    {
//      "idx": 102717,
//      "movie_id": "20218904",
//      "site": "naver",
//      "created": "2021-08-31 09:35",
//      "writer": "사자갈기를갈기갈기(kidi****)",
//      "comment": "올해의 영화입니다 꼭 보세요. 마스크는 꼭 새거 챙겨가세요. 3번쯤 눈물 수도꼭지 터집니다. 기분 좋은 눈물이고 상쾌유쾌경쾌하게 볼 수 있으니 걱정은 마세요",
//      "like_num": 44,
//      "rating_num": 10
//    },

//{"movie_id":"20078605",
//"title":"낙엽귀근",
//"eng_title":"Getting Home",
//"production_year":"2008",
//"production_country":"중국",
//"size_type":"장편",
//"genore":"코미디",
//"production_status":"개봉",
//"poster_img":"1624433543613_42a2728a0f9246529a003e58360df6c8.jpg",
//"release_date":"감동 로드 트립 코미디",
//"updated_date":"2021-03-02 14:27:54",
//"memo":"장편 | 예술영화 | 코미디 | 101분 0초 | 15세이상관람가 | 중국",
//"director":"장양",
//"actor":"{}",
//"story":"함께 일하던 절친한 친구가 갑작스런 죽음을 맞자\n사내는 고향의 가족 곁에 묻히게 해주겠다는\n살아생전 약속을 지키기 위해 시체를 짊어지고 먼 길을 떠난다.\n\n시체를 태운 버스 안에서 만난 강도.\n사랑하는 여인에게 뒤통수를 맞은 사내.\n5000m 산을 등반하며 자신과의 싸움을 해가는 남자.\n보일러 사고로 한쪽 얼굴을 잃어버린 여자.\n살아 있으면서 자신의 장례식을 지켜보는 노인까지.\n\n죽은 친구를 업고 가는 기막힌 동행길.\n사내는 세상에서 가장 특별한 인연들을 길 위에서 만나는데…"}



