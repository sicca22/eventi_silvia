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
    
    
    var loggedUser: UserModel?
    static var shared = LoginHelper()
    //questa funzione carica l'utente connessi dal databese del server
    func load() {
        let data = UserDefaults.standard.value(forKey: "LoggedUser") as? Data
        loggedUser = try? JSONDecoder().decode(UserModel.self, from: data ?? Data())
        if loggedUser != nil {
            isLogged = true
        } else {
            isLogged = false
        }
       
    }
    
    func save(userToSave:UserModel?) {
        if let user = userToSave {
            //c'è un utente da salvare
            isLogged = false
            //converto l'ggetto 'user maodel' in data
            let data = try? JSONEncoder().encode(user)
            
            UserDefaults.standard.set(data, forKey: "LoggedUser")
            //UserDefaults.standard.set(data, forKey: "LoggedUser")
        }
        else {
            isLogged = false
            //non c'è un utente da salvare
            //aggiorno il database dell'app
            UserDefaults.standard.removeObject(forKey: "LoggedUser")
        }
        
        // faccio scrivere immediamente le modiche sul database
        
        UserDefaults.standard.synchronize()
        
        //aggiorno la variabile dell'utente connesso
        loggedUser = userToSave
        //aggiorno la schermata nell'app
        isLogged = userToSave != nil ? true : false
    }
   
    
   
    
}
