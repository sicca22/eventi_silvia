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
    @State var isStarted = false
    var body: some View {
        if isStarted {
            //ContentView()
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
                    .foregroundColor(.white)
                    .frame(width: 300, height: 300)
                    .overlay{
                        VStack{
                            Text("battle of")
                                
                            Text("2 JellyFish")
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
                    try? await Task.sleep(nanoseconds: 3_000_000_000)
                    //apro la pagina principale dell'app
                    withAnimation{
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
