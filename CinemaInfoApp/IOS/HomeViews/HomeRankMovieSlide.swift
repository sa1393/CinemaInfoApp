import SwiftUI
import Kingfisher

struct HomeRankMovieSlide: View {
    var movies: [MovieProtocol]
    
    var memoString: String = ""
    
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.4),  Color.black.opacity(1)]),
        startPoint: .center,
        endPoint: .bottom
    )

    var body: some View {
        VStack {
            TabView {
                ForEach(movies.map { $0.movie }, id: \.self) { movie in
                    if movie.posterImgURL != nil {
                        
                        ZStack {
                            KFImage(movie.posterImgURL)
                                .cancelOnDisappear(true)
                                .resizable()
                                .placeholder{
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                }
                                .scaledToFit()
                                .overlay(gradient)
                            
                            VStack {
                                Spacer()
                                
                                HStack {
                                    ForEach(0..<movie.memos.count, id: \.self) { index in

                                        Text(movie.memos[index])
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(Color.white)

                                    }
                                }
                                .padding(.bottom, 30)
                                
                                HStack {
                                    Spacer()
                                    NavigationLink(destination: NavigationLazyView(MovieDetail(movie: movies.first{
                                        $0.movie.movieId == movie.movieId
                                    }!))) {
                                        HStack {
                                            VStack {
                                                Image(systemName: "info.circle")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                                Text("Info")
                                                    .offset(y: -8)
                                            }
                                            .foregroundColor(Color.white)
                                        }
                                    }
                                }
                                .padding(.horizontal, 50)
                            }
                            
                        }
                        
                    }
                    else {
                        Text("이미지 없음")
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}



struct HomeRankMovieSlide_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            HomeRankMovieSlide(movies: [exampleMovie3, exampleMovie1, exampleMovie2])
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth / 2 * 3)
        }
        
    }
}
