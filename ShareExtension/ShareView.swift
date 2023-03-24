//
//  ShareView.swift
//  ShareExtension
//
//  Created by Deniz Ata Eş on 24.03.2023.
//

import SwiftUI
import Kingfisher

struct ShareView: View {
    
       var model: OpenGraphInfo?
       var shareController: ShareViewController?
       
       let strokeColor = Color(UIImage(named: "image")?.averageColor ?? .systemGray3)
       @State var title: String
       @State var description: String
       @State var price: String = "Fiyat Ekle"

       init(model: OpenGraphInfo?, shareController: ShareViewController?) {
           self.model = model
           self.shareController = shareController
           
           // Eğer model içinde title değeri mevcutsa, title değişkenini bu değerle başlat
           if let title = model?.title {
               self._title = State(initialValue: title)
           } else {
               self._title = State(initialValue: "Başlık")
           }
           
           if let description = model?.description {
               self._description = State(initialValue: description)
           } else {
               self._description = State(initialValue: "Açıklama")
           }
       }
       
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 24){
                Text(model?.title ?? "")
                    .font(.title)
                if let image = model?.image{
                    KFImage(image)
                        .resizable()
                        .frame(width: 160,height: 160)
                        .cornerRadius(5)
                        .shadow(color: strokeColor, radius: 10)
                }
                Text(model?.url.description ?? "")
                    .font(.footnote)
                    .shadow(radius: 1)
                
                HStack{
                    Image(systemName: "dollarsign.circle")
                        .foregroundColor(.green)
                    Text("255 TL")
                        .bold()
                        .foregroundColor(.green)
                }
                
                Button {
                    
                } label: {
                    Text("Kaydet")
                        .fontWeight(.bold)
                        .frame(width: UIScreen.main.bounds.width - 32 ,height: 50)
                        .background(.purple)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        shareController?.close()
                    } label: {
                        Text("Vazgeç")
                            .foregroundColor(Color(.systemRed))
                            .bold()
                    }

                }
            }
            
        }
        
    }
}
