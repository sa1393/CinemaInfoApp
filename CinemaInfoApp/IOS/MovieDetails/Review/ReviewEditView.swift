import SwiftUI

struct ReviewEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var baseViewModel: BaseViewModel

    var movie: MovieProtocol
    var review: Review
    @ObservedObject var reviewEditViewModel = ReviewEditViewModel()
    @State var currentRatingNum: Int = 10
    @State var isTapped = false

    init(movie: MovieProtocol, review: Review) {
        self.movie = movie
        self.review = review
        
        if let ratingNum = review.ratingNum {
            print(ratingNum)
            currentRatingNum = ratingNum
        }
        
        if let comment = review.comment {
            print(comment)
            reviewEditViewModel.comment = comment
        }
        
    }
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
            VStack {
                HStack(spacing: 35) {
                    
                    Button(action: {
                        
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                    })
                    
                    Text(I18N.reviewEdit)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 18)
                

                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(baseViewModel.user?.name ?? "")
                            .font(.system(size: 14))

                        Text(I18N.reviewWriteContent)
                            .lineSpacing(1)
                            .font(.system(size: 14))
                            
                    }
                    
                    HStack {
                        ForEach(1..<11, id: \.self) { index in
                            
                            HStack{

                                if index % 2 == 1{
                                    Button(action: {
                                        currentRatingNum = index
                                    }, label: {
                                        Image(systemName: "star.leadinghalf.filled")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 10, height: 20, alignment: .leading)
                                            .clipped()
                                            .foregroundColor(index <= currentRatingNum ? .yellow : .white)
                                    })
                                        
                                    
                                }
                                else if index % 2 == 0{
                                    Button(action: {
                                        currentRatingNum = index
                                    }, label: {
                                        Image(systemName: "star.leadinghalf.filled")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 10, height: 20, alignment: .leading)
                                            .clipped()
                                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                            .foregroundColor(index <= currentRatingNum ? .yellow : .white)
                                        
                                    })
                                    .offset(x: -8)
                                }

                            }
                        }
                        
                    }

                    ReviewTextField(text: $reviewEditViewModel.comment, isTapped: $isTapped)
                        
                    HStack {
                        Spacer()
                        Button(action: {
                            reviewEditViewModel.ReviewEdit(movieId: movie.movie.movieId, idx: review.idx, rating: currentRatingNum)
                            
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                                HStack{
                                    Image(systemName: "pencil")
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .bold))
                                    Text(I18N.reviewWrite)
                                        .foregroundColor(.black)
                                }
                        })
                            .background(Rectangle())
                        Spacer()
                        
                    }
                    
                }
                .padding(.horizontal, 45)
                .padding(.top, 18)

                Spacer()

            }
            if reviewEditViewModel.loading {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(width: 30, height: 30)
                        Spacer()
                    }
                    Spacer()
                }
                .background(Color.black.opacity(0.9))
            }
        }
        .foregroundColor(Color.white)
        .navigationBarHidden(true)
        .onAppear {
            self.reviewEditViewModel.cancellable = self.reviewEditViewModel
               .$offReview
               .sink(receiveValue: { offReview in
                   guard offReview else { return }
                   
                   DispatchQueue.main.async {
                       self.presentationMode.wrappedValue.dismiss()
                   }
               }
           )
        }
        .onDisappear {
            self.reviewEditViewModel.stop()
        }
    }
}

struct ReviewEdit_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: ReviewEditView(movie: exampleMovie1, review: exampleReview1), dark: true)
            .environmentObject(BaseViewModel())
        
    }
}
