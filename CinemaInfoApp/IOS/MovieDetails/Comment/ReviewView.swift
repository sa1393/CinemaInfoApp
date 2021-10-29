import SwiftUI

struct ReviewView: View {
    var screenX = UIScreen.main.bounds.width
    var review: Review
    var lastReviewStar: Int
    var myReview: Bool
    var movie: MovieProtocol
    @ObservedObject var allReviewViewModel: AllReviewViewModel
    
    
    @State var reviewMenu: Bool = false
    
    var reloadData: () -> Void
    
    init(review: Review, movie: MovieProtocol, myReview: Bool, allReviewViewModel: AllReviewViewModel, reloadData:@escaping () -> Void) {
        self.review = review
        self.myReview = myReview
        
        lastReviewStar = review.ratingNum % 2
        self.allReviewViewModel = allReviewViewModel
        self.movie = movie
        self.reloadData = reloadData
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(review.writer)
                    Spacer()
                    
                    Button(action: {
                        if !allReviewViewModel.editMode {
                            withAnimation(.easeInOut.speed(1.5)){
                                allReviewViewModel.menuControl = $reviewMenu
                                reviewMenu = true
                                allReviewViewModel.editMode = true
                            }
                        }
                        else {
                            withAnimation(.easeInOut.speed(1.5)){
                                allReviewViewModel.menuControl?.wrappedValue = false
                                allReviewViewModel.editMode = false
                            }
                        }
                    }, label: {
                        VStack(spacing: 3) {
                            Circle()
                                .frame(width: 5, height: 5)
                            Circle()
                                .frame(width: 5, height: 5)
                            Circle()
                                .frame(width: 5, height: 5)
                        }
                    })
                }
                
                HStack {
                    if review.ratingNum <= 0 && lastReviewStar <= 0 {
                        Text("평점 없음")
                    }
                    else {
                        ForEach(0..<review.ratingNum / 2, id: \.self) { num in
                            Image(systemName: "star.fill")
                                .padding(.horizontal, -4)
                        }
                        
                        if lastReviewStar > 0 {
                            Image(systemName: "star.leadinghalf.filled")
                        }
                    }
                    
                    Spacer()
                    
                    Text(review.created)
                        .foregroundColor(.gray)
                    
                }
                .padding(.leading, 6)
                .padding(.bottom, 1)
                .padding(.vertical, 8)
                .foregroundColor(.yellow)
                
                HStack() {
                    Text(review.comment)
                    Spacer()
                }
                
                Rectangle()
                    .frame(width: screenX * 0.97, height: 1)
                    .padding(.vertical, 4)
                    .foregroundColor(.gray)
                    
            }
            .foregroundColor(.white)
            
            if reviewMenu {
                HStack {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        if myReview {
                            NavigationLink(destination: {
                                NavigationLazyView(ReviewEditView(movie: movie, review: review))
                            }, label: {
                                Text("리뷰 수정")
                                    .foregroundColor(.black)
                                    .padding(8)
                            })
                            
                            Button(action: {
                                withAnimation(.easeInOut.speed(1.5)){
                                    allReviewViewModel.DeleteReview(idx: review.idx, movieId: movie.movie.movieId, realoadData: reloadData)
                                    allReviewViewModel.menuControl?.wrappedValue = false
                                    allReviewViewModel.editMode = false
                                }
                            }, label: {
                                Text("리뷰 삭제")
                                    .foregroundColor(.black)
                                    .padding(8)
                                
                            })
                        }
                        else {
                            Button(action: {
                                withAnimation(.easeInOut.speed(1.5)){
                                    allReviewViewModel.menuControl?.wrappedValue = false
                                    allReviewViewModel.editMode = false
                                }
                            }, label: {
                                Text("부적절한 리뷰로 신고")
                                    .foregroundColor(.black)
                                    .padding(8)
                                
                            })
                            
                        }
               
                    }
                    .frame(width: 120)
                    .background(Color.white)
                }
                .offset(y: -18)
            }
            
           
            
        }
    }
}

struct ReviewComment_Previews: PreviewProvider {
    static var previews: some View {

        ZStack {
            Color.black
            
            ReviewView(review: exampleReview1, movie: exampleMovie1, myReview: true, allReviewViewModel: AllReviewViewModel()) {
                
            }
        }
        
      
       
    }
}
