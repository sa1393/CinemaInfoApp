import SwiftUI

struct SearchView: View {
    @StateObject var searchVM = SearchVM()
}

extension SearchView {
    var body: some View {
        NavigationView{
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
                            Text("Search Result")
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(.vertical)
                    }
                    
                    
                    ScrollView {
                        VStack{
                            if searchVM.searchLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            }
                            else {
                                SearchResultGrid(movies: searchVM.searchResultMovies)
                            }
                           
                        }
                    }
                }
                .padding(.top, 18)
                .padding(.horizontal, 6)
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
