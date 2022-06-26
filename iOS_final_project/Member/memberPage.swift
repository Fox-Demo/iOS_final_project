//
//  memberPage.swift
//  iOS_final_project
//
//  Created by li on 2022/6/12.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import FirebaseAuth

struct memberPage: View {
    
    @State var name: String? = ""
    @State var isLogin: Bool = false
    @State var edit = false
    @State var login = false
    @State var signup = false
    @State var logout = false
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var filterIntensity = 0.5
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userInfor: UserInfor
    
    let context = CIContext()
    let genders = ["Male", "Female"]
    
    var body: some View {
        VStack{
            let date = userInfor.birthday
            if let user = Auth.auth().currentUser {
                ZStack {
                    Spacer()
                    Circle()
                        .fill(Color(hue: 0.456, saturation: 0.972, brightness: 1.0))
                        .frame(width: 200, height: 200)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.blue)
                        .font(.system(size:15))
                        .onTapGesture {
                            showingImagePicker = true
                        }
                        .frame(width: 200.0, height: 200.0)
                    
                    image?
                        .resizable()
                        .frame(width: 200, height:200)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .padding(20)
                }
                .frame(width: 200.0, height: 200.0)
                .padding([.horizontal, .bottom])
                .onChange(of: inputImage) { _ in loadImage() }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
                
                Text(user.displayName ?? "Unknow")

                    .font(.system(size: 28))
                    .bold()
                    .frame(width: 250, height: 30)
                
                HStack{
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 15.0, height: 15)
                        .foregroundColor(.blue)
                    Button(
                        "編輯",
                        action: {
                            edit = true
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    )
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                    .padding(.leading, -2.0)
                    .sheet(isPresented: $edit) {
                        EditName()
                    }
                }
                .frame(width: 370)
                
                List{
                    HStack{
                        Text("Email:")
                            .padding(-6.0)
                        Text("\(user.email ?? "error")")
                            .padding(.leading,35)
                    }
                    
                    HStack{
                        Text("Birthday:")
                            .padding(-6.0)
                        Text("\(userInfor.birthday,style: .date)")
                            .padding(.leading,10)
                    }
                    
                    HStack{
                        Text("Gender:")
                            .padding(-6.0)
                        Text(self.genders[userInfor.selectedGender]).tag(userInfor.selectedGender)
                            .padding(.leading,20)
                            .fixedSize()
                    }
                    
                    HStack{
                        Text("Address:")
                            .padding(-6.0)
                        Text("\(userInfor.address)")
                            .padding(.leading,15)
                            .fixedSize()
                    }
                    .padding(0.0)
                }
                .listStyle(.inset)
                .frame(width: 400, height: 350)
                
                
                VStack(spacing: 0){
                    Button {
                        do{
                            try Auth.auth().signOut()
                            logout = true
//                            dismiss()
                            
                        }
                        catch{}
                    }
                    
                    label: {
                        Text("登出")
                            .font(.system(size: 25))
                            .foregroundColor(.red)
                            .underline()
                            .padding(.bottom,20)
                    }
                    .padding(.bottom,30)
                    .alert("登出成功", isPresented: $logout, actions:{
                        Button("OK"){
                            logout = false
                            dismiss()
                        }
                    })
                }
            }
            else{
                logoutPage()
            }
        }
        .frame(width: 350, height: 700)
        .padding()
    }
        
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Success!")
        }
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct memberPage_Previews: PreviewProvider {
    static var previews: some View {
        memberPage()
            .environmentObject(UserInfor())
    }
}
