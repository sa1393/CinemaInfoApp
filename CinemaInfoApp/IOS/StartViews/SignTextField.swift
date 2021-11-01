import SwiftUI
import Combine

struct SignTextField: View {
    var placeHolder: String
    var secure: Bool
    @State var isTapped: Bool = false
    
    @Binding var signField: SignField

    var body: some View {
        VStack {
            
            HStack {
                
                TextField("", text: $signField.text) { (status) in
                    if status {
                        withAnimation(.easeInOut.speed(1.5)) {
                            isTapped = true
                        }
                    }
                } onCommit: {
                    if signField.text == "" {
                        withAnimation(.easeInOut.speed(1.5)) {
                            isTapped = false
                        }
                    }
                }
                .placeHolder(hint: Text(placeHolder)
                                .foregroundColor(isTapped ? Color.white : Color.gray)
                                .scaleEffect(isTapped ? 0.6 : 1, anchor: .leading)
                                .offset(y: isTapped ? -18 : 0)
                                
                )
                .font(.system(size: 20))
                .padding(.horizontal, 12)
                .foregroundColor(Color.white)
                
                
            }
            .frame(height: 50)
            .background(isTapped ? Color(hex: "#464646") : Color(hex: "#323232"))
            .cornerRadius(4.0)
            .overlay(Rectangle()
                        .frame(height: signField.isError ? 2 : 0)
                        .foregroundColor(.red)
                        .offset(y: 27))
            
            if signField.isError {
                Text(signField.errorMsg)
                    .foregroundColor(.red)
                    .font(.system(size: 18, weight: .bold))
            }
        }
        
    }
}



struct SignTextField_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(BaseViewModel())
    }
}
