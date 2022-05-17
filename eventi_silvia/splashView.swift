//
//  splashView.swift
//  BattleMiddleHeart
//
//  Created by iedstudent on 05/04/22.
//

import SwiftUI


struct SplashView: View {
    @State var isAnimating = false
    //se la pagina principale è visibile
    @StateObject var sharedLogin = LoginHelper.shared
   
    var body: some View {
        if sharedLogin.isLogged == true {
            //c'è un utente connesso e mostro direttamente la pagine aprincipale
            HomeView()
            
        }else if sharedLogin.isLogged == false {
            //non c'è un utente loggato e mostro la pagine di benvenuto 
            WelcomeView()
        }else {
            //mostro lo splash con lo screen
            ZStack {
                GeometryReader{ deviceGeo in
                    Image("splashView")
                        .resizable()
                        .scaledToFill()
                        .frame(width: deviceGeo.size.width,
                               height: deviceGeo.size.height)
                }
               
                    
                
                Circle ()
                    .foregroundColor(.init(hex:0xFEFEFE))
                    .frame(width: 300, height: 300)
                    .overlay{
                        VStack{
                            Text("EventApp")
                                
                           
                            Text("🐌🐌🐌")
                        }
                    }
                    .opacity(isAnimating ? 1 : 0 )
                    .scaleEffect(isAnimating ? 1 : 0.5)
                    .animation(.spring(response:2, dampingFraction: 0.5), value : isAnimating)
            }
            .ignoresSafeArea()
            .onAppear{
                //aspeto che sia finita l'amìnimazione e creo un task
                Task {
                    isAnimating = true
                    try? await Task.sleep(nanoseconds: 2_500_000_000)
                    //apro la pagina principale dell'app
                    withAnimation{
                       LoginHelper.shared.load()
                        //isStarted = true
                        
                    }
                }
            }
        }

    }
}

struct splashView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
           SplashView()
        }
    }
}
