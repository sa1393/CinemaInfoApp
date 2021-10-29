import SwiftUI

struct ReviewEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var baseViewModel: BaseViewModel

    var movie: MovieProtocol
    var review: Review
    @StateObject var reviewEditViewModel = ReviewEditViewModel()
    @State var ratingNum: Int = 10

    init(movie: MovieProtocol, review: Review) {
        self.movie = movie
        self.review = review
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
                    
                    Text("리뷰 수정")
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

                        Text("리뷰는 공개되며 내 계정의 정보가\n일부 포함됩니다.")
                            .lineSpacing(1)
                            .font(.system(size: 14))
                            
                    }
                    
                    HStack {
                        ForEach(1..<11, id: \.self) { index in
                            
                            HStack{

                                if index % 2 == 1{
                                    Button(action: {
                                        print("왼쪽 별")
                                        ratingNum = index
                                    }, label: {
                                        Image(systemName: "star.leadinghalf.filled")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 10, height: 20, alignment: .leading)
                                            .clipped()
                                            .foregroundColor(index <= ratingNum ? .yellow : .white)
                                    })
                                        
                                    
                                }
                                else if index % 2 == 0{
                                    Button(action: {
                                        print("오른쪽 별")
                                        ratingNum = index
                                    }, label: {
                                        Image(systemName: "star.leadinghalf.filled")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 10, height: 20, alignment: .leading)
                                            .clipped()
                                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                            .foregroundColor(index <= ratingNum ? .yellow : .white)
                                        
                                    })
                                    .offset(x: -8)
                                }

                            }
                        }
                        
                    }

                    ReviewTextField(text: $reviewEditViewModel.comment)
                        
                    HStack {
                        Spacer()
                        Button(action: {
                            reviewEditViewModel.ReviewEdit(movieId: movie.movie.movieId, idx: review.idx, rating: ratingNum)
                            
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 100, height: 30)
                                    .cornerRadius(4)
                                   
                                HStack{
                                    Image(systemName: "pencil")
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .bold))
                                    Text("리뷰 작성")
                                        .foregroundColor(.black)
                                }
                            }
                           
                        })
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
    }
}

struct ReviewEdit_Previews: PreviewProvider {
    static var previews: some View {
        ReviewEditView(movie: exampleMovie1, review: exampleReview1)
    }
}
