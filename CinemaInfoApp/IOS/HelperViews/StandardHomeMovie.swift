import SwiftUI
import Kingfisher

struct StandardHomeMovie: View {
    let posterImgURL: URL?

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            GeometryReader { proxy in
                
                if posterImgURL != nil {
                    
                    KFImage(posterImgURL)
                        .cancelOnDisappear(true)
                        .resizable()
                        .placeholder{

                            RoundedRectangle(cornerRadius: 4)
                                .frame(width: proxy.size.width, height: proxy.size.height)
                                .overlay(Color.gray)
                        
                        }
                        .scaledToFit()
                        .clipped()
                        .cornerRadius(8)
                }
                else {
                    VStack(alignment: .center) {
                        Text("이미지 없음")
                    }
                    .frame(width: .infinity, height: .infinity)
                    
                }
            }
        }
        .foregroundColor(.white)
    }
}

struct StandardHomeMovie_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BaseViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        
    }
}
