//
//  ProfileView.swift
//  eventi_silvia
//
//  Created by iedstudent on 10/06/22.
//

import SwiftUI

struct ProfileView: View {
    
   
    var body: some View {
        VStack{
            ImageView(url:LoginHelper.shared.loggedUser?.avatarUrl)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
        Text(LoginHelper.shared.loggedUser?.firstName ?? "Senza nome")
                .padding()
      
            Button {
                //codice bottone
                LoginHelper.shared.save(userToSave: nil)
            } label: {
                Text("LogOut")
                .foregroundColor(.white)
                .bold()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(.blue)
            .cornerRadius(16)
            
           
        }
    }
  
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
