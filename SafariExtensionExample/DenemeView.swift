//
//  DenemeView.swift
//  SafariExtensionExample
//
//  Created by Deniz Ata Eş on 24.03.2023.
//

import SwiftUI

struct DenemeView: View {
    //    let strokeColor = Color(UIImage(named: "image")?.averageColor ?? .systemGray3)
    @State var title: String = "Nike Air Force"
    @State var description: String = "Gerçekten Mükemmel Bir Ayakkabı sakın kaçırmayın"
    @State var price: String = "Fiyat Ekle"
    
    var body: some View {
        VStack(alignment: .center, spacing: 24){
            Spacer()
            Text("Nike Air Force")
                .font(.title)
            Image("image")
                .resizable()
                .frame(width: 260,height: 260)
                .cornerRadius(5)
                .shadow(color: .purple, radius: 10)
            
            Text("www.trendyol.com")
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
                    .padding()
                    .foregroundColor(.white)
                    .background(.purple)
                    .clipShape(Capsule())
            }

           
                
//                TextField("Price", text: $price)
//                    .foregroundColor(.green)
//                    .font(.system(size: 14))
//                    .bold()
//
//
//
//                TextField("Başlık", text: $title)
//                    .font(.system(size: 14))
//
//                TextField("", text: $description)
//                    .font(.system(size: 12))
            
            
            
            
        }
    }
}

struct DenemeView_Previews: PreviewProvider {
    static var previews: some View {
        DenemeView()
    }
}
