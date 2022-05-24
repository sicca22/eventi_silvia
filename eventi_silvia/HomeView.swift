//
//  HomeView.swift
//  eventi_silvia
//
//  Created by iedstudent on 17/05/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Benvenuto!")
            
            Button ("Logout") {
                //UserDefaults.standard.save()
                LoginHelper.shared.save(userToSave: nil)
            }
            //fare log
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
