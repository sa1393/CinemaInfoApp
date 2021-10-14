import SwiftUI

struct LoadingView: View {
    let mainWidth = UIScreen.main.bounds.width * 0.73
    private let contentOffset: CGFloat = 18
    private let contentLine: CGFloat = 10        // content line width

    private var contentWidth: CGFloat {
        (self.mainWidth - 4.0 * self.contentOffset) / 3.0
    }
    
    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Image(systemName: "tortoise")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .foregroundColor(.red)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
