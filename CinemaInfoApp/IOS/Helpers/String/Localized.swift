import Foundation

extension String {
    func localized(comment: String) -> String {
        return NSLocalizedString(self, value: self, comment: comment)
    }
}

struct I18N {
    //tab
    static let home = "home".localized(comment: "홈")
    static let search = "search".localized(comment: "검색")
    static let myInfo = "my_info".localized(comment: "내 정보")

    //img
    static let noImage = "no_image".localized(comment: "이미지 없음")
    
    //homeView
    static let movieInfo = "movie_info".localized(comment: "영화정보")
    static let info = "info".localized(comment: "정보")
    
    //searchView
    static let searchHint = "search_hint".localized(comment: "searchBar place holder")
    static let searchResult = "search_result".localized(comment: "검색 결과")
    static let searchReady = "search_ready".localized(comment: "검색 입력전")
    static let searchNone = "search_none".localized(comment: "검색 결과가 없을때")
    
    //myInfoView
    static let userEdit = "user_edit".localized(comment: "유저 수정")
    static let edit = "edit".localized(comment: "수정")
    static let userInfo = "user_info".localized(comment: "유저 정보")
    static let signOut = "sign_out".localized(comment: "로그 아웃")
    static let setting = "setting".localized(comment: "설정")
    
    //tutorialView
    static let noLoginStart = "noLoginStart".localized(comment: "")
    static let start = "start".localized(comment: "")
    static let tutorialMovieInfoContent = "tutorial_movieInfo_content".localized(comment: "")
    static let tutorialReviewContent = "tutorial_review_content".localized(comment: "")
    
    //review
    static let review = "review".localized(comment: "")
    static let reviewWrite = "review_write".localized(comment: "리뷰 쓰기")
    static let reviewAll = "review_all".localized(comment: "")
    static let reviewEdit = "review_edit".localized(comment: "")
    static let reviewWriteContent = "review_write_content".localized(comment: "")
    static let reviewHistory = "review_history".localized(comment: "")
    static let reviewDelete = "review_delete".localized(comment: "")
    
    //sign
    static let passwordCheck = "password_check".localized(comment: "")
    static let passwordEdit = "password_edit".localized(comment: "")
    static let signup = "signup".localized(comment: "")
    static let signin = "signin".localized(comment: "")
    static let id = "id".localized(comment: "")
    static let pwd = "pwd".localized(comment: "")
    static let name = "name".localized(comment: "")
    static let profile = "profile".localized(comment: "")
    static let autoLogin = "auto_login".localized(comment: "")
    static let pickProfile = "pick_profile".localized(comment: "")
    static let join = "join".localized(comment: "")
    
    //msg
    static let signinFail = "signin_fail".localized(comment: "")
    static let signupFail = "signup_fail".localized(comment: "")
    static let passwordCheckFail = "password_check_fail".localized(comment: "")
    static let passwordCheckError = "password_check_error".localized(comment: "")
    static let passwordEditSucces = "password_edit_succes".localized(comment: "")
    static let passwordEditFail = "password_edit_fail".localized(comment: "")
    
    static let idEmptyMsg = "id_empty_msg".localized(comment: "")
    static let passwordEmptyMsg = "password_empty_msg".localized(comment: "")
    
    static let close = "close".localized(comment: "")
    static let check = "check".localized(comment: "")
}
