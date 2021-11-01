import Foundation

extension String {
    func localized(comment: String) -> String {
        return NSLocalizedString(self, value: self, comment: comment)
    }
}

struct I18N {
    static let movieInfo = "movie_info".localized(comment: "영화정보")
    static let reviewWirte = "review_write".localized(comment: "리뷰 쓰기")
    static let searchResult = "search_result".localized(comment: "검색 결과")
    static let searchReady = "search_ready".localized(comment: "")
    static let searchNone = "search_none".localized(comment: "")
    static let signup = "signup".localized(comment: "")
    static let signin = "signin".localized(comment: "")
    static let id = "id".localized(comment: "")
    static let pwd = "pwd".localized(comment: "")
    static let name = "name".localized(comment: "")
    static let profile = "profile".localized(comment: "")
    static let autoLogin = "auto_login".localized(comment: "")
    static let pickProfile = "pick_profile".localized(comment: "")
    static let tutorialMovieInfoContent = "tutorial_movieInfo_content".localized(comment: "")
    static let tutorialReviewContent = "tutorial_review_content".localized(comment: "")
    static let noLoginStart = "noLoginStart".localized(comment: "")
    static let start = "start".localized(comment: "")
    static let noImage = "no_image".localized(comment: "")
    static let signinFail = "signin_fail".localized(comment: "")
    static let signupFail = "signup_fail".localized(comment: "")
    static let setting = "setting".localized(comment: "")
    static let close = "close".localized(comment: "")
    static let join = "join".localized(comment: "")
    static let info = "info".localized(comment: "")
    static let searchHint = "search_hint".localized(comment: "")
    static let reviewHistory = "review_history".localized(comment: "")
    static let signOut = "sign_out".localized(comment: "")
}
