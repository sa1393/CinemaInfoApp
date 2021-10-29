import SwiftUI
import Kingfisher

struct HomeRankMovieSlide: View {
    var movies: [MovieProtocol]
    
    var memoString: String = ""
    @State var currentMovieIndex: Int = 0
    
    let gradient1 = LinearGradient(
        gradient: Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.3), Color.black.opacity(1)]),
        startPoint: .center,
        endPoint: .top
    )
    
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.4),  Color.black.opacity(1)]),
        startPoint: .center,
        endPoint: .bottom
    )

    var body: some View {
        ZStack {
            TabView(selection: $currentMovieIndex) {
                ForEach(movies.map { $0.movie }.indices, id: \.self) { index in
                    if movies[index].movie.posterImgURL != nil {
                        KFImage(movies[index].movie.posterImgURL)
                            .cancelOnDisappear(true)
                            .resizable()
                            .placeholder{
                                ZStack() {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                }
                                
                            }
                            .edgesIgnoringSafeArea(.top)
                            .scaledToFit()
                            .overlay(gradient)
                            .overlay(gradient1)
                            .tag(index)
                    }
                    else {
                        Text("이미지 없음")
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            
            VStack {
                Spacer()
                
                HStack {
                    ForEach(0..<movies[currentMovieIndex].movie.allGenore.count, id: \.self) { index in

                        Text(movies[currentMovieIndex].movie.allGenore[index]?.rawValue ?? "기타")
                            

                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 4, height: 4)
                            .padding(.horizontal, -1)
                        

                    }
                    Text(movies[currentMovieIndex].movie.age.rawValue ?? "")
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 4, height: 4)
                        .padding(.horizontal, -1)
                    
                    Text(movies[currentMovieIndex].movie.productionCountry ?? "")
                        
                }
                .font(.system(size: 12, weight: .bold))
                .frame(height: 22)
                .padding(.bottom, 30)
                
                HStack {
                    Spacer()
                    NavigationLink(destination: NavigationLazyView(MovieDetail(movie: movies[currentMovieIndex]
                    ))) {
                        HStack {
                            VStack {
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Info")
                                    .offset(y: -8)
                            }
                        }
                    }
                }
                .padding(.horizontal, 50)
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth / 2 * 3)
            .foregroundColor(Color.white)
            
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
