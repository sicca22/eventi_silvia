//
//  splashView.swift
//  BattleMiddleHeart
//
//  Created by iedstudent on 05/04/22.
//

import SwiftUI


struct SplashView: View {
    //impostiamo il colore per tutto l'app
    //intercetto la creazione di questa pagina per modificare lo stile e colori dell'app
    init() {
        //navigation  bar
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = UIColor(named: "baseColor2")
        //per cambiare il colore del testo
        navigationAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 22)
        ]
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        
        //tab bar
        
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = UIColor(named: "secColor")
        UITabBar.appearance().standardAppearance = tabAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        
        //tab bar items
        
    }
    
    
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
                    Image("splashImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: deviceGeo.size.width,
                               height: deviceGeo.size.height)
                }
               
                    
                
                Circle ()
                    .foregroundColor(.init(hex:0xFEFEFE, alpha: 0.7))
                    
                    .frame(width: 200, height: 200)
                    .overlay{
                        VStack{
                            Text("EventiLenti")
                                
                           
                            Text("🍊🍊🍊")
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
//5RXRb7v837xkgoBKWYN3YHPV2Ju9oMj1YxvOOBWBEpKeyoLebS
