import SwiftUI
import simd

struct ReviewWrite: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    var movie: MovieProtocol
    @StateObject var reviewWriteViewModel = ReviewWriteViewModel()
    @State var ratingNum: Int = 10

    init(movie: MovieProtocol) {
        self.movie = movie
    }
    
    var body: some View {
        ZStack {
            Color.black
            
            VStack {
                HStack(spacing: 35) {
                    
                    Button(action: {
                        
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                    })
                    
                    Text(I18N.reviewWirte)
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
                        

                        Text("")
                            .lineSpacing(1)
                            .font(.system(size: 14))
                            
                    }
                    
                    HStack {
                        ForEach(1..<11, id: \.self) { index in
                            
                            HStack{

                                if index % 2 == 1{
                                    Button(action: {
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

                    ReviewTextField(text: $reviewWriteViewModel.comment)
                        
                    HStack {
                        Spacer()
                        Button(action: {
                            reviewWriteViewModel.ReviewWrite(movieId: movie.movie.movieId, rating: ratingNum)
                        }, label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 100, height: 30)
                                    .cornerRadius(4)
                                   
                                HStack{
                                    Image(systemName: "pencil")
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .bold))
                                    Text(I18N.reviewWirte)
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
            if reviewWriteViewModel.loding {
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
            self.reviewWriteViewModel.cancellable = self.reviewWriteViewModel
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

struct CommentWrite_Previews: PreviewProvider {
    static var previews: some View {
        ReviewWrite(movie: exampleMovie1)
            .environmentObject(BaseViewModel())
    }
}

