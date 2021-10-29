import SwiftUI

struct SearchView: View {
    @StateObject var searchVM = SearchVM()
}

extension SearchView {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    HStack {
                        MySearchBar(text: $searchVM.searchString)
                    }
                    .onChange(of: searchVM.searchString) { search in
                        searchVM.fetchMovies(searchText: search)
                    }
                    HStack {
                        Text("검색 결과")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.vertical)
                }
                if searchVM.searchLoading {
                    VStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(width: 40, height: 40)
                            
                        Spacer()
                    }
                }
                else {
                    ScrollView(showsIndicators: false) {
                        SearchResultGrid(searchViewModel: searchVM)
                            
                            .frame(maxHeight: .infinity)
                        
    
                    }
                }
            }
            .padding(.top, 18)
            .padding(.horizontal, 6)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        SearchView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        
    }
}
