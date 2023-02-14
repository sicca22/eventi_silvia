//
//  TrisGameView.swift
//  eventi_silvia
//
//  Created by Silvia Cicala on 13/12/22.
//

import SwiftUI

struct TrisGameView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var mosse: [Bool?] = [
        nil, nil, nil,
        nil, nil, nil,
        nil, nil, nil,
    ]
    
    private let winningSeries = [
        //Combinazioni Orizzontali
        [0, 1 ,2],
        [3, 4, 5],
        [6, 7, 8],
        //Combinazioni verticali
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        //Combinazioni diagonali
        [2, 4, 6],
        [0, 4, 8],
    ]
    
    @State private var isGiocatoreUno = true
    @State private var isGiocatoreComputer = false
    @State private var isMossaBloccata = false
    @State private var showAlertMessage = false
    @State private var alertMessage = "Partita Finita"
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack{
                    Spacer()
                    Button {
                        // Chiudo la pagina corrente
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.system(size: 22).bold())
                            .padding()
                    }
                    .padding()
                }
                Spacer()
                HStack {
                    Image("babbonatale")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160)
                        // Spostare oggetto nello spacer orizzontale
                        .offset(x: 10, y: 10)
                    Spacer()
                        .alert("\(alertMessage)", isPresented: $showAlertMessage){}
                }
                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                    ]) {
                        ForEach(0..<9){ item in
                            ZStack {
                                
                                Circle()
                                    .foregroundColor(.red)
                                    .frame(
                                        width: geo.size.width / 3 - 20,
                                        height: geo.size.width / 3 - 20
                                    )
                                
                                Image(systemName: mosse[item] == true ? "xmark" : "circle")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 40, height: 40)
                                    .opacity(mosse[item] == nil ? 0 : 1)
                                
                            }
                            // quando tocco:
                            .onTapGesture {
                                chosenMove(item)
                            }
                        }
                    }
                
                HStack {
                    Spacer()
                    Image("renna")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160)
                        .offset(x: 10, y: 10)
                }
                Spacer()
            }
        }
        
    }
    
    
    // Funzione x quando il giocatore preme la griglia
    
    
    private func chosenMove (_ item: Int) {
        // Innanzitutto, se la griglia è piena la partita è finita
        guard isGameOver == false else {return}
        // il guard controlla che la posizione della griglia sia vuota
        guard mosse[item] == nil else {return}
        // Se è vuota mi fa disegnare il simbolo
        mosse[item] = isGiocatoreUno
        // Ad ogni tocco cambia giocatore ----> commentata se gioco contro computer
        // isGiocatoreUno.toggle()
        computerMove()
    }
    
    private func computerMove() {
        Task {
            // Innanzitutto, se la griglia è piena la partita è finita
            guard isGameOver == false else {return}
            // Qui switcha booleano dopo che il giocatore ha giocato
            try? await Task.sleep(nanoseconds:500_000_000)
            
            // Calcola mossa che fa vincere il computer
            if let winningMove = isWinningMove(giocatore: false){
                mosse[winningMove] = false
                return
            }
            // Se il centro è libero il computer lo occupa x primo
            if mosse[4] == nil {
                mosse[4] = isGiocatoreComputer
                return
            }
            
            // Qui il computer deve cercare una casella libera
            // uso il ciclo repeat while, che esegue l''istruzione almeno una volta
             repeat {
                let grigliaRandom = Int.random(in: 0..<9)
                if mosse[grigliaRandom] == nil {
                    mosse[grigliaRandom] = false
                    return
                }
             } while isGameOver == false
        
        }
    }
    
    private var isGameOver: Bool? {
        if isWinner() != nil {
            showAlertMessage = true
            return true
        }
        
        // controllo se ci sono caselle libere
        if isGridFull {
            alertMessage = "Griglia piena, è patta! ❌"
            showAlertMessage = true
            return true
        }
        
    
        
        
        return false
    }
    
    // Ritorna true se il giocatore ha vinto, viceversa ritorna false
    // Se nessuno ha vinto ritorna nil
    private func isWinner() -> Bool? {
        // Controlla se c'è una combinazione vincente
        for serie in winningSeries {
            let serieOne = mosse[serie[0]]
            let serieTwo = mosse[serie[1]]
            let serieThree = mosse[serie[2]]
//            let serieFour = mosse[serie[3]]
//            let serieFive = mosse[serie[4]]
//            let serieSix = mosse[serie[5]]
//            let serieSeven = mosse[serie[6]]
//            let serieEight = mosse[serie[7]]
            
            let movesMade = [serieOne,serieTwo, serieThree,
                             //serieFour, serieFive, serieSix, serieSeven, serieEight
            ]
            
            if movesMade.filter({$0 == true}).count == 3 {
                alertMessage = "Hai Vinto!👑"
                return true
            }
            
            else if movesMade.filter({$0 == false}).count == 3 {
                alertMessage = "Hai perso...🥲"
                return false
            }
        }
        // nessuno dei due ha vinto
        return nil
    }
    
    
    private func isWinningMove(giocatore: Bool) -> Int? {
        // Controlla se c'è una combinazione vincente
        for serie in winningSeries {
            let serieOne = mosse[serie[0]]
            let serieTwo = mosse[serie[1]]
            let serieThree = mosse[serie[2]]
//            let serieFour = mosse[serie[3]]
//            let serieFive = mosse[serie[4]]
//            let serieSix = mosse[serie[5]]
//            let serieSeven = mosse[serie[6]]
//            let serieEight = mosse[serie[7]]
            
            let movesMade = [serieOne,serieTwo, serieThree,
                             //serieFour, serieFive, serieSix, serieSeven, serieEight
            ]
            
            // Continuo il controllo solo c'è almeno una mossa libera
            if movesMade.filter({$0 == nil}).count != 1 {
                continue
            }
            
            // Continuare solo se è una combinazione vincente x il computer
            if movesMade.filter({$0 == !giocatore}).count > 0 {
                continue
            }
            
            if movesMade[0] == nil {
                return serie[0]
            }
            
            if movesMade[1] == nil {
                return serie[1]
            }
            
            if movesMade[2] == nil {
                return serie[2]
            }
            
        }
        
        
        // nessuno dei due ha vinto
        return nil
    }
    private var isGridFull: Bool {
        // Controlla se nell'array mosse ce ne solo alcune uguali a nil
        let mosseRimaste = mosse.filter { mossa in
            mossa == nil
        }
        return mosseRimaste.count == 0
    }
}

struct TrisGameView_Previews: PreviewProvider {
    static var previews: some View {
        TrisGameView()
    }
}
