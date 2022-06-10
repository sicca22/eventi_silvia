//
//  HomeView.swift
//  eventi_silvia
//
//  Created by iedstudent on 17/05/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            EventsView()
                .tabItem {
                    Label("Eventi", systemImage: "calendar")
                }
            CartView()
                .tabItem{
                    Label("carrello", systemImage: "cart.fill")
                }
            ProfileView()
                .tabItem{
                    Label("Profilo", systemImage: "person.fill")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
