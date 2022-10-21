//
//  ProfileView.swift
//  eventi_silvia
//
//  Created by iedstudent on 10/06/22.
//

import SwiftUI

struct ProfileView: View {
  @State var isShowingSingUP = false
    @State var pickedImage : UIImage?
   
    var body: some View {
        NavigationView {
        VStack{
          
            ImageView(url:LoginHelper.shared.loggedUser?.avatarUrl)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
        Text(LoginHelper.shared.loggedUser?.firstName ?? "Senza nome")
                .padding()
            Button {
                isShowingSingUP.toggle()
            }label:{
                Text(LoginHelper.shared.loggedUser?.firstName ?? "Senza nome")
                    .sheet(isPresented:$isShowingSingUP ) {
                        GalleryPicker(selectedImage: $pickedImage)
                    }
                    .onChange(of: pickedImage) { _ in
                        
                    }
                
            }
            
            Image(uiImage: pickedImage?? )
            
            
            
            Button {
                //codice bottone
                LoginHelper.shared.save(userToSave: nil)
            } label: {
                Text("LogOut")
                .foregroundColor(.white)
                .bold()
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color("baseColor"))
            .cornerRadius(16)
            
           
        }
        .navigationTitle("Profilo")
        .navigationBarTitleDisplayMode(.inline)
        }
    }
  
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
