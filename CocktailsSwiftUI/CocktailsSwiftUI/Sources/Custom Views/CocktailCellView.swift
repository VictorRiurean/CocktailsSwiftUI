//
//  CocktailCellView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 19/01/2023.
//

import NukeUI
import SwiftUI

struct CocktailCellView: View {
    
    // MARK: Environment
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    
    // MARK: FetchRequests
    
    @FetchRequest var fetchRequest: FetchedResults<Cocktail>
    
    
    // MARK: State
    
    @State private var play = false
    @State private var selectedCocktailID = UUID()
    @State private var animationID = 0
    
    
    // MARK: Private properties
    
    private var letter: String?
    
    // MARK: Body
    
    var body: some View {
        HStack {
            if let drink = fetchRequest.first {
                if let image = drink.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 35))
                        .padding()
                } else {
                    /// We use Nuke's LazyImage because it adds caching functionality
                    LazyImage(url: URL(string: drink.unwrappedThumbnail))
                        .frame(width: 70, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 35))
                        .padding()
                }
            } else {
                Image(systemName: "questionmark.app.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
                    .padding()
                    .foregroundColor(colorScheme == .light ? AppColors.getRandomLightColor(with: letter) : AppColors.getRandomDarkColor(with: letter))
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
                    if !drink.isFavourite {
                        play = true
                        selectedCocktailID = drink.unwrappedID
                        animationID += 1
                    }
                    
                    drink.isFavourite.toggle()
                    
                    try? moc.save()
                } label: {
                    Image(systemName: drink.isFavourite ? "heart.fill" : "heart")
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                /// Without this modifier the frame of the button is too large and the button may
                /// end up taking away tap gestures from the cell thus disabling navigation
                .buttonStyle(BorderlessButtonStyle())
                .overlay(alignment: .center) {
                    /// We only want to animate the button that was tapped
                    if selectedCocktailID == drink.unwrappedID {
                        LottiePlusView(
                            name: LottieView.Animations.like.rawValue,
                            animationSpeed: 4,
                            play: $play
                        )
                        .frame(width: 50, height: 50)
                        /// This modifier allows taps to go through the animation view
                        .allowsHitTesting(false)
                        /// This is rather obscure, but in order for the view to
                        /// re-render the LottieView something in it needs to
                        /// change so we need to update its id, otherwise it would
                        /// just animate the first time isFavourite is set to true
                        .id(animationID)
                    }
                }
                .animation(.easeOut(duration: 1), value: drink.isFavourite)
            }
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(colorScheme == .light ? AppColors.getRandomLightColor(with: letter) : AppColors.getRandomDarkColor(with: letter))
        .cornerRadius(15)
    }
    
    
    // MARK: Lifecycle
    
    init(drinkName: String, letter: String? = nil) {
        _fetchRequest = FetchRequest<Cocktail>(sortDescriptors: [], predicate: NSPredicate(format: "\(FilterKey.drinkName.rawValue) \(PredicateFormat.equalsTo.rawValue) %@", drinkName))
        
        self.letter = letter
    }
}

struct CocktailCellView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailCellView(drinkName: "A1")
    }
}
