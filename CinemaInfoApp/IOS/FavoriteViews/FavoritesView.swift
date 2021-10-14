import SwiftUI

struct FavoritesView: View {  
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("좋아요 목록")
                    .font(.system(size: 36, weight: .bold))
                Spacer()
                
                    
            }
            .padding(.top, 18)
            .foregroundColor(.white)
        }
        

    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
