import SwiftUI
import simd

struct CommentWrite: View {
    @Environment(\.presentationMode) var presentationMode
    var movie: MovieProtocol
    @StateObject var commentWriteViewModel = CommentWriteViewModel()
    @State var currentStar: Int = 8
    

    init(movie: MovieProtocol) {
        self.movie = movie
    }
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
            VStack {
                HStack {
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                    })
                    
                    Spacer()
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 18)
                

                VStack(alignment: .leading, spacing: 0) {
                    Text("이름위치")
                        .font(.system(size: 14))

                    Text("리뷰는 공개되며 내 계정의 정보가\n일부 포함됩니다.")
                        .lineSpacing(1)
                        .font(.system(size: 14))
                        .padding(.vertical, 12)
                    HStack {
                        ForEach(1...currentStar+1, id: \.self) { index in
                            
                            HStack{
                                if index == currentStar+1 {
                                    
                                }
                                else if index % 2 == 1{
                                    Button(action: {
                                        print("왼쪽 별")
                                        currentStar = index
                                    }, label: {
                                        Image(systemName: "star.leadinghalf.filled")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 10, height: 20, alignment: .leading)
                                            .clipped()
                                            .foregroundColor(.yellow)
                                    })
                                        
                                    
                                }
                                else if index % 2 == 0{
                                    Button(action: {
                                        print("오른쪽 별")
                                        currentStar = index
                                    }, label: {
                                        Image(systemName: "star.leadinghalf.filled")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 10, height: 20, alignment: .leading)
                                            .clipped()
                                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                            .foregroundColor(.yellow)
                                        
                                    })
                                    .offset(x: -8)
                                }
                            }
                        }
                        
                    }

                    CommentTextField(text: $commentWriteViewModel.comment)
                        .padding(.vertical, 20)
                        
                }
                .padding(.horizontal, 45)
                .padding(.top, 18)
                
                Spacer()

            }
        }
        .foregroundColor(Color.white)
        .navigationBarHidden(true)
    }
}

struct CommentWrite_Previews: PreviewProvider {
    static var previews: some View {
        CommentWrite(movie: exampleMovie1)
    }
}