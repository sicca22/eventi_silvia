//
//  CartHelper.swift
//  eventi_silvia
//
//  Created by iedstudent on 14/06/22.
//

import Foundation
class CartHelper: ObservableObject {
    static var shared = CartHelper()
    
    
    
    
    //lista
    
    @Published private(set) var items: [EventModel] = [
        //solo perche manca internet
        //EventModel(id: 1, name: "prova 1"),
        //EventModel(id: 2, name: "prova 2"),
        //EventModel(id: 3, name: "prova 3")
    ]
    //per calcolare il totale nel carrello 
    @Published private(set) var totalPriceString = " "
    
    
    func add(item: EventModel) {
          // aggiungo l'evento al carrello (item è solo un nome)
          items.append(item)
        calculateTotalPrice()
    }
    func remove(item: EventModel) {
          if let index = items.lastIndex(of: item) {
              items.remove(at: index)
              
              
          }
        calculateTotalPrice()
          
          
      }
    
    func removeALL(item:EventModel) {
        //prossima lezione
        calculateTotalPrice()
    }
    
    func calculateTotalPrice(){
        //TODO: aggiornare la variabile total price string
        var totalPrice = 0
        
        
        for item in CartHelper.shared.items {
            totalPrice += item.price ?? 0
            
        }
        var priceInEuro = Double(totalPrice)
        priceInEuro = priceInEuro / 100
        
        let priceFormatter = String.init(format: "%.2f €", priceInEuro)
        
        //sostyituisco i punti con le virgole
        totalPriceString = priceFormatter.replacingOccurrences(of: ".", with: ",")
       //totalPriceString = "(\)€"
         
    }
    
    
}
