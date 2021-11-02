import SwiftUI

struct CustomNavigationBar: View {
    var title: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack(spacing: 35) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 10, height: 20)
                        .foregroundColor(.white)
                })
                
                Text(title)
                    .foregroundColor(Color.white)
                    .font(.system(size: 26, weight: .bold))
                
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 18)
            
        }
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        
        Preview(source: CustomNavigationBar(title: "test"), dark: true)
    }
}
