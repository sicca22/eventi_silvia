//
//  ProfileView.swift
//  eventi_silvia
//
//  Created by iedstudent on 10/06/22.
//
import DBNetworking
import SwiftUI

struct ProfileView: View {
    @State var isShowingSingUP = false
    @State var pickedImage : UIImage?
    @State var isChangeAvatarOpen = false
    @State var user = LoginHelper.shared.loggedUser
  
    //variabile usata da efitProfileView per ricaricare questa pagina
    //quando viene aggiunto l'utente connesso
    @State var refreshUser = false
    
    var body: some View {
        NavigationView {
           
            VStack (alignment: .center
            ){
                Text(user?.firstName ?? "FirstName")
                    .bold()
                    .padding()
                ImageView(url:user?.avatarUrl)
                    .frame(width: 160, height:160)
                    .clipShape(Circle())
                    .padding(.bottom)
                
                VStack (alignment: .center
                ) {
                    Button ("Modifica profilo") {
                        //boolean per la nuova modale
                        isChangeAvatarOpen.toggle()
                    }
                    .padding(.bottom)
                    .fullScreenCover(isPresented: $isChangeAvatarOpen) {
                        EditProfileView(refreshUser: $refreshUser)
                    }
                    .onChange(of: refreshUser) { _ in
                        if refreshUser == true {
                            user = LoginHelper.shared.loggedUser
                            
                            refreshUser = false
                        }
                        
                    }
                    
                    
                   
                    VStack {
                        Button {
                            isShowingSingUP.toggle()
                        }label:{
                            Text("Modifica avatar")
                                .sheet(isPresented:$isShowingSingUP ) {
                                    GalleryPicker(selectedImage: $pickedImage)
                                }
                                .onChange(of: pickedImage) { _ in
                                    //eseguo codice quando un utente vuole cambiare un immagine
                                    sendAvatarToServer(avatar: pickedImage)
                                }
                            
                            
                            
                           
                            }
                        
                    .padding(.bottom)
                    }
                    VStack {
                        NavigationLink(destination: CameraView(contents: [user?.ar ?? ARContent()])) {
                                Text("ARobject")
                                    .foregroundColor(.red)
                        }
                    }
                }
                
                
                //Image(uiImage: pickedImage ?? UIImage()) LoginHelper.shared.save(userToSave: nil)
                
                Spacer()
               
                HStack {
                  
                        Button  {
                            LoginHelper.shared.save(userToSave: nil)
                        } label: {
                            Text("Esci")
                                .font(.system(size:16).bold())
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .background(Color("baseColor2"))
                        .cornerRadius(16)
                        .padding()
                        
                        
                    
                    
                    .navigationTitle("Profilo")
                    .navigationBarTitleDisplayMode(.inline)
                .padding()
                }
            }
        }}
    func sendAvatarToServer(avatar: UIImage?) {
        guard let avatar = avatar else {
            //non c'è nessun avatar da caricare
            return
        }
        //riduco limmagine
       let resized = UIHelper.resize(image: avatar,
                                     targetSize: CGSize (width: 500, height: 500))
        let compressed = UIHelper.compress(image: resized, compression: 0.8)
        let multipartFile = DBNetworking.MultipartFile(
            parameterName: "avatar",
            fileName: "avatar.jpg",
            mimeType: "avatar/jpg",
            data: compressed
        )
        
        //invio l'immagine al server
        let request = DBNetworking.request(
        url: "https://edu.davidebalistreri.it/app/postman",
        type: .multipartPost,
        authToken:LoginHelper.shared.loggedUser?.authToken,
        multipartFiles: [multipartFile]
        )
        Task{
            let response = await request.response(type:ResponseModel.self)
            if response.success {
                //avatar modificato correttamente 
                if let updateUser = response.body?.data {
                    LoginHelper.shared.save(userToSave: updateUser)
                    user = updateUser
                }
                
            } else {
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        LoginHelper.shared.load()
        return
            ProfileView()
        
    }
}
