import SwiftUI

struct AllReviewView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var movieDetailVM: MovieDetailVM
    @ObservedObject var allReviewViewModel: AllReviewViewModel
    
    var myReview: Review?
    
    var body: some View {
        ZStack {
            Color.black
                
            VStack {
                HStack(spacing: 35) {
                    Button(action: {
                        movieDetailVM.reviews = []
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 10, height: 20)
                            .foregroundColor(.white)
                        
                    })
                    
                    Text("모든 리뷰")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)
                
                    Spacer()
                }
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(allReviewViewModel.reviews, id: \.self) { review in
                            ReviewView(review: review, movie: movieDetailVM.movie, myReview: myReview?.idx == review.idx ? true : false, allReviewViewModel: allReviewViewModel) {
                                allReviewViewModel.firstLoadComment(movieId: movieDetailVM.movie.movie.movieId, size: allReviewViewModel.page)
                            }
                                .onAppear {
                                    print(index)
                                    print(allReviewViewModel.page)
                                    if allReviewViewModel.reviews.firstIndex(where: {$0.idx == review.idx}) == allReviewViewModel.page - 1 && !allReviewViewModel.last {
                                        print("last index")
                                        allReviewViewModel.loadMoreComment(movieId: movieDetailVM.movie.movie.movieId)
                                    }
                                }
                        }
                       
                        if allReviewViewModel.reviewLoading {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .frame(width: 20, height: 20)
                                Spacer()
                            }
                        }
                    }
                }
                Spacer()
            }
            
        }
        .navigationBarHidden(true)
        .onTapGesture {
            allReviewViewModel.editMode = false
            allReviewViewModel.menuControl?.wrappedValue = false
        }
        .onAppear {
            allReviewViewModel.firstLoadComment(movieId: movieDetailVM.movie.movie.movieId, size: 20)
        }
    }
}

struct AllReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AllReviewView(movieDetailVM: MovieDetailVM(movie: exampleMovie1), allReviewViewModel: AllReviewViewModel())
    }
}
