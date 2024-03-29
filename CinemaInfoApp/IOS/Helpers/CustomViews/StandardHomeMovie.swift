import SwiftUI
import Kingfisher

struct StandardHomeMovie: View{
    let posterImgURL: URL?
    let movieError: () -> Void
    
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
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color.gray)
                                .aspectRatio(0.7, contentMode: .fill)
                        
                        }
                        .fade(duration: 0.3)
                        .onFailure { error in
                            print(error.localizedDescription)
                            movieError()
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
        Preview(source: ContentView(), dark: true)
            .environmentObject(BaseViewModel())        
    }
}

