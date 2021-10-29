import SwiftUI

struct ReviewHistoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var baseViewModel: BaseViewModel
    @StateObject var reviewHistoryViewModel = ReviewHistoryViewModel()
    @StateObject var allReviewViewModel = AllReviewViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack(spacing: 35) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 10, height: 20)
                    })
                    
                    Text("리뷰 기록")
                        .font(.system(size: 26, weight: .bold))
                    
                    Spacer()
                    
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 18)
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(reviewHistoryViewModel.myReviewMovieId(), id: \.self) { movie in
                            VStack {
                                
                                HStack {
                                    Text(movie.title)
                                        .font(.system(size: 18, weight: .bold))
                                    
                                    Spacer()
                                    
                                    NavigationLink(destination: {
                                        NavigationLazyView(MovieDetail(movie: movie))
                                    }, label: {
                                        Image(systemName: "info.circle")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                    })
                                }
                                    
                                ReviewView(review: reviewHistoryViewModel.myReviews[movie]!, movie: movie, myReview: true, allReviewViewModel: allReviewViewModel) {
                                    reviewHistoryViewModel.myReviews.removeValue(forKey: movie)
                                    
                                }
                                
                                
                            }
                            
                        }
                        if reviewHistoryViewModel.loading {
                            VStack(alignment: .center) {
                                Spacer()
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                Spacer()
                            }
                                
                        }
                        
                    }
                    .padding(.horizontal, 6)
                }
                
                Spacer()
            }
            
        }
        .foregroundColor(.white)
        .navigationBarHidden(true)
        .onTapGesture {
            allReviewViewModel.editMode = false
            allReviewViewModel.menuControl?.wrappedValue = false
        }
        .onAppear(perform: {
            reviewHistoryViewModel.fetchMyReviews()
        })
        .onDisappear {
            reviewHistoryViewModel.stop()
        }
    }
}

struct ReviewHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewHistoryView()
            .environmentObject(BaseViewModel())
    }
}
