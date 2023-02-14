import Foundation

class CartHelper: ObservableObject{
   static var shared = CartHelper()
   
   @Published  private(set) var items: [EventModel] = [
   //manca internet
       //EventModel(id: 1, name: "Prova 1", price:10 ),
       //EventModel(id: 2, name: "Prova 2", price:100),
       //EventModel(id: 3, name: "Prova 3", price:20),
   ]
   
   @Published private(set) var itemsTogether: [EventModel] = []
   //la stringa del costo totale di tutti gli elementi nel carrello
   @Published private(set) var totalPriceString = "-"
   func add(item: EventModel) {
       // aggiungo l'evento al carrello (item è solo un nome)
       items.append(item)
       updateItemsTogether()
       calculateTotalPriceString()
   }
   func remove(item: EventModel) {
       if let index = items.lastIndex(of: item){
           items.remove(at: index)
       }
       calculateTotalPriceString()
   }
       func removeAll(item:EventModel){
           //deve filtrare array items self.item
           //self.items.filter{event in event.id != itemsTogether.count}
          // removeAll.self
           
           
           calculateTotalPriceString()
           updateItemsTogether()
   }
   private func updateItemsTogether() {
       self.itemsTogether = []
       
       for var event in items {
           //controllo se questo evento è stato già aggiunto
           if itemsTogether.contains(event) {
               continue
           }
           
           
           let quantity = items.filter{ $0.id == event.id}.count
           
           event.updateQuantity(quantity)
           itemsTogether.append(event)
       }
       
   }
   
   func calculateTotalPriceString() {
       //aggiornare la variabile di prezzo del carrello
       var totalPrice = 0
       for item in CartHelper.shared.items{
           //sommare il prezzo di ogni evento
           totalPrice += item.price ?? 0
           
       }
       var priceInEuro = Double(totalPrice)
       priceInEuro = priceInEuro/100
       
       let priceFormatted = String(format: "%.2f €", priceInEuro )
       totalPriceString = priceFormatted.replacingOccurrences(of: ".", with: ",")
         
    
       //formattare il prezzo totale e salvarlo su totalpricestring
      
        
   }
}


