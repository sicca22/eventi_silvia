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
        Text(LoginHelper.shared.loggedUser?.firstName ?? "senza nome")
        Button ("Logout") {
            LoginHelper.shared.save(userToSave: nil)
        }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
