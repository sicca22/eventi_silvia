//
//  CreateEventDataView.swift
//  eventi_silvia
//
//  Created by Silvia Cicala on 06/12/22.
//


import SwiftUI

struct CreateEventDateView: View {
    
    @EnvironmentObject var event: CreatingEventModel
    
    @State var gotoNext = false
    
    @State var date = Date()
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Nome evento: \(event.nome)").bold()
                .padding(.bottom)
            
           Text("Data:\(event.dateString)").bold()
            
            DatePicker("", selection: $event.data)
                .datePickerStyle(.graphical)
            
            Spacer()
            
            
            Button  {
                gotoNext = true
            } label: {
                Text("Avanti")
                    .font(.system(size:16).bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .background(Color("baseColor2"))
            .cornerRadius(16)
            
            
            NavigationLink(destination: CreateEventAddressView(), isActive: $gotoNext) {}
                .opacity(0)
            
        }
        .padding()
        .navigationTitle("Scegli data")
    }
}

struct CreateEventDateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventDateView()
            .environmentObject(CreatingEventModel())
    }
}
