import SwiftUI

struct SearchView: View {
    @StateObject var searchVM = SearchVM()

    var body: some View {
        VStack {
            VStack {
                HStack {
                    MySearchBar(text: $searchVM.searchString)
                }
                .onChange(of: searchVM.searchString) { search in
                    searchVM.fetchMovies(searchText: search)
                }
                HStack {
                    Text(I18N.searchResult)
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
        .ignoresSafeArea(.keyboard)
        .padding(.top, 18)
        .padding(.horizontal, 6)
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.automatic)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: SearchView(), dark: true)
            
    }
}
