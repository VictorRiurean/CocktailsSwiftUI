//
//  TipDetailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 26/01/2023.
//

import SwiftUI

struct TipDetailsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var isPresented: Bool
    
    @Binding var tip: Tip
    
    var body: some View {
        ZStack(alignment: .top) {
            (colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor())
                .ignoresSafeArea()
            
            VStack {
                Text(tip.shortDescription)
                    .font(.title)
                    .padding()
                
                tip.image
                    .resizable()
                    .frame(width: 300, height: 400)
                
                Text(tip.longDescription)
                    .font(.system(size: 18))
                    .padding()
                
                Spacer()
            }
            
            HStack(alignment: .top) {
                Spacer()
                
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "multiply.circle")
                        .foregroundColor(.gray)
                        .font(.title)
                }
            }
            .padding()
        }
    }
}

struct TipDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TipDetailsView(isPresented: .constant(true), tip: .constant(Tip.tips.first!))
    }
}
