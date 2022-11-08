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
    
    var body: some View {
        NavigationView {
            VStack{
                
                ImageView(url:user?.avatarUrl)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                Button ("modifica profilo") {
                    //boolean per la nuova modale
                    isChangeAvatarOpen.toggle()
                }
                .padding()
                .fullScreenCover(isPresented: $isChangeAvatarOpen) {
                    EditProfileView()
                }
                
                Text(user?.firstName ?? "Senza nome")
                    .padding()
                Button {
                    isShowingSingUP.toggle()
                }label:{
                    Text("modifica avatar")
                        .sheet(isPresented:$isShowingSingUP ) {
                            GalleryPicker(selectedImage: $pickedImage)
                        }
                        .onChange(of: pickedImage) { _ in
                            //eseguo codice quando un utente vuole cambiare un immagine
                            self.sendAvatarToServer(avatar: pickedImage)
                        }
                    
                }
                
                //Image(uiImage: pickedImage ?? UIImage())
                
                
                
                Button {
                    //codice bottone
                    LoginHelper.shared.save(userToSave: nil)
                } label: {
                    Text("LogOut")
                        .foregroundColor(.white)
                        .bold()
                    
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color("baseColor"))
                .cornerRadius(16)
                
                
            }
            .navigationTitle("Profilo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
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
        return ProfileView()
    }
}
