import SwiftUI

struct HomeView: View {
    @Environment(\.isPreview) var isPreview
    @StateObject var homeVM: HomeVM = HomeVM()
    
    //유저 정보창
    @State var showUserWindow = false
    
    let gradient1 = LinearGradient(
        gradient: Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.85), Color.black.opacity(0.9)]),
        startPoint: .bottom,
        endPoint: .top
    )
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    GeometryReader { proxy in
                        ScrollView(.vertical, showsIndicators: false){
                            LazyVStack {
                                ZStack {
                                    VStack(alignment: .leading) {
                                        if isPreview {
                                            HomeRankMovieSlide(movies: [exampleMovie3, exampleMovie2, exampleMovie1])
                                                .frame(width: proxy.size.width, height: proxy.size.width / 2 * 3)
                                        }
                                        else {
                                            if homeVM.rankMovies.count > 0 {
                                                HomeRankMovieSlide(movies: homeVM.rankMovies)
                                                    .frame(width: proxy.size.width, height: proxy.size.width / 2 * 3)
                                            }
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
                                    HomeCategoryList(movies: homeVM.categoryMovies[key]!, listName: key)
                                }
                                .padding(.horizontal, 6)
                            }
                            .padding(.bottom, UIScreen.tabbarHeight)
                        }
                        
                    }
                }
                
                .edgesIgnoringSafeArea(.top)
            }
            .foregroundColor(.white)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}

enum ScreeningState: String, CaseIterable {
    case screening = "상영중"
    case all = "모든 영화"
}

extension HomeView{
    var topMenu: some View {
        HStack(alignment: .top) {
            Image(systemName: "tortoise.fill")
                .resizable()
                .frame(width: 50, height: 30)
                .foregroundColor(.blue)
            
            Spacer()
            
        }
        .padding(.horizontal, 8)
        
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

