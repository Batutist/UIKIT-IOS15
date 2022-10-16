//
//  CardView.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 4/1/22.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        component
            .frame(width: 340, height: 220)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(radius: 20)
    }
    
    var component: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
//                        .foregroundColor(.themeAccentColor)
                }
                
                Spacer()
                
                Images.logoReactImage
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
            
            Spacer()
            
            Images.card1Image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
            
        }
    }
}

struct CardView1_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
