import SwiftUI

struct MovieDetailSwitcher: View {
    @State var currentTab: DetailTab = .story
    @State var page: Int = 1
    var allTab: [DetailTab]
    
    @ObservedObject var movieDetailVM: MovieDetailVM
    
    var movie: MovieProtocol
    var screening: Bool
    
    var testNum: Int = 0
    
    func widthForTab(_ tab:DetailTab) -> CGFloat{
        let string = tab.rawValue
        return string.widthOfString(usingFont: .systemFont(ofSize: 24, weight: .bold))
    }
    
    init(movieDetailVM: MovieDetailVM, movie: MovieProtocol, screening: Bool = true) {
        self.movieDetailVM = movieDetailVM
        self.movie = movie
        self.screening = screening
        self.allTab = [DetailTab]()
        
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
                    Text(movie.movie.story)
                        .font(.system(size: 18, weight: .semibold))
                case .commnet:
                    HStack {
                        Spacer()
                        NavigationLink(destination: CommentWrite(movie: movie)) {
                            
                            Text("리뷰 작성하기")
                                .font(.system(size: 18, weight: .bold))
                        }
                        Spacer()
                    }
                    .padding(.vertical, 12)
                    if movieDetailVM.reviews.count <= 0 {
                        VStack(alignment: .center) {
                            Text("작성된 댓글이 없습니다.")
                                .padding(.vertical, 30)
                        }
                    }
                    
                    ForEach(movieDetailVM.reviews, id: \.self) { review in
                        CommentView(review: review)
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
        ScrollView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                MovieDetailSwitcher(movieDetailVM: MovieDetailVM(movie: exampleMovie1), movie: exampleMovie1, screening: false)
            }
        }
        
        
    }
}
