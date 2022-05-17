//
//  LoginHelper.swift
//  eventi_silvia
//
//  Created by iedstudent on 17/05/22.
//

import Foundation

class LoginHelper: ObservableObject {
    //ci dice se un utente è connessso, se è ?nill? non lo è , nessun utene connesso
    //ogni volta che cambia la variabile 
   @Published var isLogged: Bool? = nil
    //Singelton , pattern di progammazione che crea un (istanza di LoginHelper
    //oggettto una olta sola, accessibile a tutta la app
    //alternativa per non fare variabili statiche
    
    static var shared = LoginHelper()
    //questa funzione carica l'utente connessi dal databese del server
    func load() {
        //FAKE
        isLogged = false
    }
    
    func save() {
        isLogged = true
    }
    //facciamo finta di salvare l'utente
    
}
