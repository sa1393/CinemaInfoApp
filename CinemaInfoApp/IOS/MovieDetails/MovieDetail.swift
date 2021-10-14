import SwiftUI
import Kingfisher
import Foundation

struct MovieDetail: View {
    @Environment(\.presentationMode) var presentationMode
    
    var movie: MovieProtocol
    var screening: Bool
    
    @StateObject var movieDetailVM: MovieDetailVM = MovieDetailVM()
    
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
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 10, height: 20)
                            .foregroundColor(.white)
                        
                    })
                        .padding(.vertical, 8)
                        .padding(.horizontal, 18)
                    
                    Spacer()
                }
                
                ScrollView {
                    ZStack {
                        detailImage
                        
                        content
                    }
                    .frame(maxHeight: .infinity)
                }
                .foregroundColor(.white)
                
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            movieDetailVM.movie = movie
            movieDetailVM.fetchReviews()
        }
        
    }
}

extension MovieDetail {
    var detailImage: some View {
        ZStack {
            VStack {
                if movie.movie.posterImgURL != nil {
                    KFImage(movie.movie.posterImgURL)
                        .placeholder {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                        .resizable()
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 3 * 2)
                    
                }
                else {
                    Text("이미지 없음")
                }
                
                Spacer()
            }
            VStack {
                Rectangle()
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 3 * 2)
                    .foregroundColor(.clear)
                    .background(gradient)
                    .background(gradient2)
                Spacer()
            }
        }
    }
}

extension MovieDetail {
    var content: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(movie.movie.title)
                        .font(.largeTitle)
                        .bold()
                    Text("\(movie.movie.engTitle) (\(movie.movie.productionYear))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            
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
            
            MovieDetailSwitcher(movieDetailVM: movieDetailVM, movie: movie, screening: screening)
        }
        .padding(.top, UIScreen.screenHeight / 3 * 2 - 80)
        .padding(.horizontal, 6)
        
    }
}

extension MovieDetail {
    @ViewBuilder
    func createMemo(memo: String, memoTitle: String) -> some View{
        VStack (alignment: .leading){
            Text(memo)
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, memoTitle == "시간" ? -4 : 0)
            Text(memoTitle)
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetail(movie: exampleMovie1)
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
        
        NavigationView {
            
            MovieDetail(movie: exampleMovie3)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
        }
        
    }
}
