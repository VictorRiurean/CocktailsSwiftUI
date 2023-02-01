//
//  CocktailCellView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import NukeUI
import SwiftUI

struct CocktailCellView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest var fetchRequest: FetchedResults<Cocktail>
    
    var body: some View {
        HStack {
            if let drink = fetchRequest.first {
                LazyImage(url: URL(string: drink.unwrappedThumbnail))
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
                    .padding()
            } else {
                Image(systemName: "questionmark.app.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
                    .padding()
                    .foregroundColor(colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor())
                    
            }
            
            VStack(alignment: .leading) {
                if let drink = fetchRequest.first {
                    Text(drink.unwrappedDrink)
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(drink.unwrappedInstructions)
                        .font(.subheadline)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                } else {
                    Text("Something very wrong happened here 😱")
                }
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            
            Spacer()
                
            if let drink = fetchRequest.first {
                Button {
                    drink.isFavourite.toggle()
                    
                    try? moc.save()
                } label: {
                    Image(systemName: drink.isFavourite ? "heart.fill" : "heart")
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                .buttonStyle(BorderlessButtonStyle())
            }
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor())
        .cornerRadius(15)
    }
    
    init(drinkName: String) {
        _fetchRequest = FetchRequest<Cocktail>(sortDescriptors: [], predicate: NSPredicate(format: "\(FilterKey.drinkName.rawValue) \(PredicateFormat.equalsTo.rawValue) %@", drinkName))
    }
}

struct CocktailCellView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailCellView(drinkName: "A1")
    }
}
