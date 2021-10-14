import SwiftUI

struct MyInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black
                .ignoresSafeArea()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            
            VStack(alignment: .leading) {
                HStack(spacing: 30) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 10, height: 20)
                            .foregroundColor(.white)
                    })
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(Color.black)
                VStack {
                    
                }

                
            }
            .frame(maxWidth: .infinity)
            
        }
        .foregroundColor(.white)
    }
}

struct MyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyInfoView()
    }
}
