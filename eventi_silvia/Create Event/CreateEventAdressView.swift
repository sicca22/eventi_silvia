//
//  CreateEventAdressView.swift
//  eventi_silvia
//
//  Created by iedstudent on 15/11/22.
//


import SwiftUI
import MapKit

struct CreateEventAddressView: View {
    
    @EnvironmentObject var event: CreatingEventModel
    @State var gotoNext = false
    @State var address : String = ""
    
    
    
    var body: some View {
        VStack (alignment: .leading){
            HStack (alignment: .bottom){
                CustumTextField(
                    title: "Indirizzo",
                    placeholder: "Inserisci l'indirizzo",
                    text: $event.address
                    
                )
                .padding(.bottom)
                
                Button {
                    geocodeAddress()
                } label: {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .padding()
                }
                
                .background(Color("baseColor"))
                .cornerRadius(16)
                .padding(.bottom, 33)
                
            }
            
            

          
            
            MapView(coordinate: $event.coordinate)
                .onChange(of: event.coordinate, perform: { newValue in
                    locationUpdated()
                })
                .frame(maxHeight: .infinity)
                .cornerRadius(16)
            Text(event.coordinate.debugDescription)
               .font(.system(size: 14))
               .foregroundColor(.white)
                .onChange(of: event.coordinate) { newValue in
                    locationUpdated()
                }
            Spacer()
            Button  {
                gotoNext = true
            } label: {
                Text("Avanti")
                    .frame(maxWidth: .infinity)
                    .font(.system(size:16).bold())
                    .foregroundColor(.white)
                    
                    .padding()
            }
            .background(Color("baseColor2"))
            .cornerRadius(16)
            .padding(.bottom)
            
            NavigationLink(destination: CreateEventCoverView(), isActive: $gotoNext) {}
                .opacity(0)
            
            
            
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Mappa Evento")
    }
    //richiamare quando cambiano le coordinate
    //per calcolare nome alle corrispettive coordinate
    @MainActor func locationUpdated() {
        
        Task {
           let address = await LocationHelper.address(from: event.coordinate)
            event.address =  address ?? ""
            
        }
    }
    
    @MainActor func geocodeAddress() {
        Task {
            let coordinate = await LocationHelper.coordinate(from: event.address)
            event.coordinate = coordinate
            
        }
    }
}

struct CreateEventAddress_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventAddressView()
            .environmentObject(CreatingEventModel())
    }
}









