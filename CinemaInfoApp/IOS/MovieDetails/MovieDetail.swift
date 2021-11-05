import SwiftUI
import Kingfisher
import Foundation

struct MovieDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    var movie: MovieProtocol
    var screening: Bool
    
    @StateObject var movieDetailVM: MovieDetailVM = MovieDetailVM()
    @ObservedObject var allReviewViewModel: AllReviewViewModel = AllReviewViewModel()
    
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.black.opacity(0),  Color.black.opacity(1)]),
        startPoint: .center,
        endPoint: .bottomLeading
    )
    
    let gradient2 = LinearGradient(
        gradient: Gradient(colors: [Color.black.opacity(0),  Color.black.opacity(1)]),
        startPoint: .center,
        endPoint: .bottomTrailing
    )
    
    init(movie: MovieProtocol) {
        self.movie = movie
        
        if movie is RatingMovie {
            screening = true
        }
        else {
            screening = false
        }
        
        print(movie.movie.posterImgURL)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black
            
            VStack {
                CustomNavigationBar(title: movie.movie.title ?? "")
                
                ScrollView(showsIndicators: false) {
                    ZStack {
                        VStack {
                            if movie.movie.posterImgURL != nil {
                                KFImage(movie.movie.posterImgURL)
                                    .placeholder {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    }
                                    .resizable()
                                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth / 2 * 3)
                                    .overlay(
                                        ZStack {
                                            gradient
                                            gradient2
                                        }
                                    )
                            }
                            else {
                                Text(I18N.noImage)
                            }
                            
                            Spacer()
                        }
                        
                        content
                    }
                    .frame(maxHeight: .infinity)
                }
                .foregroundColor(.white)
                
            }

        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            allReviewViewModel.editMode = false
            allReviewViewModel.menuControl?.wrappedValue = false
        }
        .onAppear() {
            movieDetailVM.movie = movie
            
            if baseViewModel.isLogin {
                movieDetailVM.fetchMyReview(movieId: movie.movie.movieId)
            }
            withAnimation(.easeInOut.speed(1.5)) {
                movieDetailVM.previewComment()
            }
         
        }
        
    }
}
extension MovieDetail {
    var content: some View {
        VStack {
            HStack(spacing: 25) {
                KFImage(movie.movie.posterImgURL)
                    .placeholder {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                    .resizable()
                    .frame(width: 100, height: 150)
                
                VStack(alignment: .leading) {
                    Text(movie.movie.title ?? "")
                        .font(.largeTitle)
                        .bold()
                    Text("\(movie.movie.engTitle ?? "") (\(movie.movie.productionYear ?? ""))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()

                }
                Spacer()
            }
            .frame(height: 150)
            
            HStack() {
                createMemo(memo: movie.movie.duration, memoTitle: "시간")
                
                Spacer()
                createMemo(memo: movie.movie.productionCountry, memoTitle: "만든 나라")
                Spacer()
                createMemo(memo: movie.movie.age.rawValue, memoTitle: "연령 제한")
                Spacer()
                createMemo(memo: movie.movie.genore, memoTitle: "장르")
            }
            .padding(.vertical, 25)
            
            VStack(alignment: .center) {
                if movieDetailVM.myReviewLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        Spacer()
                    }
                }
                else {
                    if let myReview = movieDetailVM.myReview {
                        Text("내가 쓴 댓글")
                            .font(.system(size: 18, weight: .bold))
                        
                        ReviewView(review: myReview, movie: movie, myReview: true, allReviewViewModel: allReviewViewModel) {
                            movieDetailVM.fetchMyReview(movieId: movie.movie.movieId)
                            movieDetailVM.fetchReviews(offset: 0, size: 4)
                        }
                    } else {
                        if baseViewModel.isLogin {
                            HStack {
                                Text("내가 쓴 리뷰가 없습니다.")
                                    .font(.system(size: 18, weight: .semibold))
                                Spacer()
                                NavigationLink(destination: {
                                    ReviewWrite(movie: movie)
                                }, label: {
                                    Image(systemName: "pencil")
                                    Text(I18N.reviewWrite)
                                        .font(.system(size: 18, weight: .semibold))
                                })
                            }
                        }
                        else {
                            HStack {
                                Spacer()
                                NavigationLink(destination: {
                                    SignInView()
                                        .environmentObject(baseViewModel)
                                }, label: {
                                    Image(systemName: "pencil")
                                    Text(I18N.reviewWrite)
                                        .font(.system(size: 18, weight: .bold))
                                })
        
                                Spacer()
                                
                            }
                        }
                    }
                    
                }
                
            }
            .padding(.vertical, 15)

            MovieDetailSwitcher(movieDetailVM: movieDetailVM, movie: movie, screening: screening, myReview: movieDetailVM.myReview, allReviewViewModel: allReviewViewModel)
            
        }
        .padding(.top, UIScreen.screenWidth / 2 * 3 - 150)
        .padding(.horizontal, 6)
    }
}

extension MovieDetail {
    @ViewBuilder
    func createMemo(memo: String?, memoTitle: String?) -> some View{
        VStack (alignment: .leading){
            Text(memo ?? "")
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, memoTitle == "시간" ? -4 : 0)
            Text(memoTitle ?? "")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: MovieDetail(movie: exampleMovie1), dark: true)
            .environmentObject(BaseViewModel())
    }
}
