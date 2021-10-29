import SwiftUI

struct HomeView: View {
    @Environment(\.isPreview) var isPreview
    @StateObject var homeVM: HomeVM = HomeVM()
    
    let gradient1 = LinearGradient(
        gradient: Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.85), Color.black.opacity(0.9)]),
        startPoint: .bottom,
        endPoint: .top
    )
    
    var body: some View {
        ZStack {
            Color.black

            VStack {
                GeometryReader { proxy in
                    ScrollView(.vertical, showsIndicators: false){
                        LazyVStack {
                            ZStack {
                                VStack(alignment: .leading) {
                                    if homeVM.rankMovies.count > 0 {
                                        HomeRankMovieSlide(movies: homeVM.rankMovies)
                                            .frame(width: proxy.size.width, height: proxy.size.width / 2 * 3)
                                    }
                                    else {
                                        VStack(alignment: .center) {
                                            HStack(alignment: .center){
                                                ProgressView()
                                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                                    .frame(width: 30, height: 30)
                                            }
                                        }
                                        .frame(width: proxy.size.width, height: proxy.size.width / 2 * 3)
                                    }

                                }
                                
                                VStack {
                                    topMenu
                                        .frame(height: proxy.size.height / 5)
                                        .background(gradient1)
                                    
                                    Spacer()
                                }
                            }
                            
                            ForEach(homeVM.allCategories, id: \.self) { key in
                                
                                HomeCategoryList(listName: key, title: homeVM.categoryMovies[key]?.title, genore: homeVM.categoryMovies[key]?.genore, rated: homeVM.categoryMovies[key]?.rated, size: homeVM.categoryMovies[key]?.size)
                            }
                            .padding(.horizontal, 6)
                            
                        }
                        .padding(.bottom, UIScreen.tabbarHeight)
                    }
                    
                }
            }
        }
        .foregroundColor(.white)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            homeVM.fetchRankMovies(size: 5)
        }
        .onDisappear {
            print("disapeper")
        }
        .preferredColorScheme(.dark)
    }
}

enum ScreeningState: String, CaseIterable {
    case screening = "상영중"
    case all = "모든 영화"
}

extension HomeView{
    var topMenu: some View {
        VStack {
            
            HStack(alignment: .top) {
                Image(systemName: "tortoise.fill")
                    .resizable()
                    .frame(width: 50, height: 30)
                    .foregroundColor(.blue)
                
                Spacer()
                
            }
            .padding(.horizontal, 8)
            Spacer()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BaseViewModel())
        HomeView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        HomeView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}

