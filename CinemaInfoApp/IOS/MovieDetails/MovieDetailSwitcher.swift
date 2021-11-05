import SwiftUI

struct MovieDetailSwitcher: View {
    @State var currentTab: DetailTab = .story
    @State var page: Int = 1
    var allTab: [DetailTab]
    
    @ObservedObject var movieDetailVM: MovieDetailVM
    @ObservedObject var allReviewViewModel: AllReviewViewModel
    
    var movie: MovieProtocol
    var screening: Bool
    
    var testNum: Int = 0
    var myReview: Review?
    
    func widthForTab(_ tab:DetailTab) -> CGFloat{
        let string = tab.rawValue
        return string.widthOfString(usingFont: .systemFont(ofSize: 24, weight: .bold))
    }
    
    init(movieDetailVM: MovieDetailVM, movie: MovieProtocol, screening: Bool = true, myReview: Review?, allReviewViewModel: AllReviewViewModel) {
        self.movieDetailVM = movieDetailVM
        self.movie = movie
        self.screening = screening
        self.allTab = [DetailTab]()
        self.myReview = myReview
        self.allReviewViewModel = allReviewViewModel
        
        allTab.append(.story)
        allTab.append(.commnet)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(spacing: 20){
                ForEach(allTab, id: \.self) { tab in
                    VStack {
                        Rectangle()
                            .frame(width: widthForTab(tab), height: 6)
                            .foregroundColor(currentTab == tab ? .blue : .clear)
                        
                        Button(action: {
                            withAnimation(.easeInOut.speed(1.5)) {
                                currentTab = tab
                            }
                            
                        }, label: {
                            Text("\(tab.rawValue)")
                                .font(.system(size: 24, weight: .bold))
                        })
                    }
                }
                Spacer()
            }
            
            VStack(alignment: .leading) {
                switch currentTab {
                case .story:
                    Text(movie.movie.story ?? "")
                        .font(.system(size: 18, weight: .semibold))
                case .commnet:
                    if movieDetailVM.loading {
                        HStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            Spacer()
                        }
                    }
                    else {
                        if movieDetailVM.reviews.count <= 0 {
                            VStack(alignment: .center) {
                                Text("작성된 댓글이 없습니다.")
                                    .font(.system(size: 18, weight: .bold))
                                    .padding(.vertical, 30)
                            }
                        }
                        else {
                            ForEach(movieDetailVM.reviews, id: \.self) { review in
                                if let review = review, let myReview = myReview{
                                    if myReview.idx == review.idx {
                                        ReviewView(review: review, movie: movie, myReview: true, allReviewViewModel: allReviewViewModel) {
                                            movieDetailVM.fetchMyReview(movieId: movie.movie.movieId)
                                            movieDetailVM.fetchReviews(offset: 0, size: 4)
                                        }
                                    }
                                    else {
                                        ReviewView(review: review, movie: movie, myReview: false, allReviewViewModel: allReviewViewModel) {
                                            movieDetailVM.fetchMyReview(movieId: movie.movie.movieId)
                                            movieDetailVM.fetchReviews(offset: 0, size: 4)
                                        }
                                    }
                                }
                                else {
                                    ReviewView(review: review, movie: movie, myReview: false, allReviewViewModel: allReviewViewModel) {
                                        movieDetailVM.fetchMyReview(movieId: movie.movie.movieId)
                                        movieDetailVM.fetchReviews(offset: 0, size: 4)
                                    }
                                }
                                
                                
                            }
                            
                            NavigationLink(destination: {
                                NavigationLazyView(AllReviewView(movieDetailVM: movieDetailVM, allReviewViewModel: allReviewViewModel, myReview: myReview))
                            }, label: {
                                HStack {
                                    Spacer()
                                        Text("리뷰 모두 보기")
                                            .font(.system(size: 18, weight: .bold))
                                    Spacer()
                                }
                            })
                        }
                    }
                    
                    
                }
                Spacer()
            }
            .padding(.top, 4)
        }
        .foregroundColor(.white)
    }
}

enum DetailTab: String {
    case story = "Story"
    case commnet = "Comment"
}

struct MovieDetailSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: MovieDetailSwitcher(movieDetailVM: MovieDetailVM(movie: exampleMovie1), movie: exampleMovie1, screening: false, myReview: exampleReview1, allReviewViewModel: AllReviewViewModel()), dark: true)
        
    }
}
