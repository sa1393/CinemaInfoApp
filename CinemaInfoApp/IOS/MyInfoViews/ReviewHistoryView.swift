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
                    
                    Text(I18N.reviewHistory)
                        .font(.system(size: 26, weight: .bold))
                    
                    Spacer()
                    
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 18)
                if reviewHistoryViewModel.refresh.started && reviewHistoryViewModel.refresh.released {
                   ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(height: 20)
                }
      
                ScrollView(showsIndicators: false) {
                    CustomPullToScroll(refresh: $reviewHistoryViewModel.refresh) {
                        reviewHistoryViewModel.fetchMyReviews()
                    }
                    
                    VStack(alignment: .leading) {
                        ForEach(reviewHistoryViewModel.myReviews, id: \.self) { myReview in
                            
                            VStack {
                                HStack {
                                    Text(myReview.movie.movie.title ?? "")
                                        .font(.system(size: 18, weight: .bold))

                                    Spacer()

                                    NavigationLink(destination: {
                                        NavigationLazyView(MovieDetail(movie: myReview.movie))
                                    }, label: {
                                        Image(systemName: "info.circle")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                    })
                                }
                                ReviewView(review: myReview.review, movie: myReview.movie, myReview: true, allReviewViewModel: allReviewViewModel) {
                                    
                                    if let index = reviewHistoryViewModel.myReviews.firstIndex(of: myReview) {
                                        reviewHistoryViewModel.myReviews.remove(at: index)
                                    }
                                    

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
                    .offset(y: reviewHistoryViewModel.refresh.started && !reviewHistoryViewModel.refresh.released ? 28 : 0)
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
    
    func reloadData() {
        if reviewHistoryViewModel.refresh.released {
            DispatchQueue.main.async {
                reviewHistoryViewModel.fetchMyReviews()
                
            }
        }
        
    }
}

struct ReviewHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: ReviewHistoryView(), dark: true)
            .environmentObject(BaseViewModel())
    }
}
