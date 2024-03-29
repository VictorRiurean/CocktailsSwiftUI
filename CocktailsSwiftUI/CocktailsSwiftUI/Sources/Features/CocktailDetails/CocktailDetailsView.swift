//
//  CocktailDetailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import NukeUI
import SwiftUI

struct CocktailDetailsView: View {
    
    // MARK: Environment
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentation
    
    
    // MARK: FetchRequests
    
    @FetchRequest var cocktail: FetchedResults<Cocktail>
    @FetchRequest var components: FetchedResults<Component>
    
    
    // MARK: State
    
    @State private var isFetching = true
    @State private var isShowingMissingCocktailAlert = false
    @State private var isShowingDeleteCocktailAlert = false
    @State private var cocktailWasDeleted = false
    @State private var isAnimating = false
    
    
    // MARK: Private properties
    
    private let viewModel = CocktailDetailsViewModel()
    private let name: String
    
    
    // MARK: Public properties
    
    var shouldAnimate: Bool
    
    
    // MARK: Body
    
    var body: some View {
        if let cocktail = cocktail.first {
            ScrollView {
                ZStack {
                    VStack {
                        ImageAndTitleView(cocktail: cocktail)
                        
                        ComponentsView(components: Array(components))
                        
                        PreparationView(cocktail: cocktail)
                        
                        Spacer()
                    }
                    .navigationTitle(cocktail.unwrappedDrink)
                    .navigationBarTitleDisplayMode(.inline)
                    
                    if isAnimating {
                        LottiePlusView(name: LottieView.Animations.confetti.rawValue, contentMode: .scaleToFill)
                    }
                }
            }
            .navigationBarBackButtonTitleHidden()
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        isShowingDeleteCocktailAlert = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .alert("Are you sure you want to delete this cocktail?", isPresented: $isShowingDeleteCocktailAlert) {
                        Button("Delete", role: .destructive) {
                            /// We do it in this order because otherwise the view will redraw
                            /// once the fetchRequest is updated and the screen becomes jerky
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                presentation.wrappedValue.dismiss()
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                delete(cocktail: cocktail)
                            }
                        }
                        .foregroundColor(colorScheme == .light ? AppColors.darkGray : .orange)
                        .buttonStyle(PlainButtonStyle())
                        
                        Button("Cancel", role: .cancel) { }
                    }
                    
                    Button {
                        cocktail.isFavourite.toggle()
                        
                        try? moc.save()
                    } label: {
                        cocktail.isFavourite ? Image(systemName: "heart.fill") : Image(systemName: "heart")
                    }
                    .foregroundColor(colorScheme == .light ? AppColors.darkGray : .orange)
                    .buttonStyle(PlainButtonStyle())
                    
                    /// ShareLink is normally used in SwiftUI, but as of iOS 16
                    /// toolbars do not support it, so we have to go for this instead
                    Button(action: actionSheet) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .foregroundColor(colorScheme == .light ? AppColors.darkGray : .orange)
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .onAppear {
                isAnimating = shouldAnimate
                
                if isAnimating {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        isAnimating = false
                    }
                }
            }
        } else {
            /// This gets triggered when the user taps on a cocktail within the Discover scene
            /// before having ever visited the Cocktails scene (and thus loading them to storage)
            if isFetching {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .onAppear {
                        Task {
                            let drink = await viewModel.fetchDrink(name: name)
                            
                            viewModel.addDrinksToCoreData(drinks: [drink], context: moc)
                            
                            isFetching = false
                        }
                    }
                    .navigationBarBackButtonTitleHidden()
            } else {
                Text("Something went horribly wrong here 😱")
                    .onAppear {
                        isShowingMissingCocktailAlert = true
                    }
                    .alert("Could not fetch cocktail named \(name)", isPresented: $isShowingMissingCocktailAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    .navigationBarBackButtonTitleHidden()
            }
        }
    }
    
    
    // MARK: Lifecycle
    
    init(name: String, shouldAnimate: Bool = false) {
        _cocktail = FetchRequest<Cocktail>(sortDescriptors: [], predicate: NSPredicate(format: "\(FilterKey.drinkName.rawValue) \(PredicateFormat.equalsTo.rawValue) %@", name))
        _components = FetchRequest<Component>(sortDescriptors: [], predicate: NSPredicate(format: "\(FilterKey.cocktail.rawValue) \(PredicateFormat.equalsTo.rawValue) %@", name))
        
        self.name = name
        self.shouldAnimate = shouldAnimate
    }
    
    
    // MARK: Private methods
    
    private func actionSheet() {
        guard let cocktail = cocktail.first else { return }
        
        let activityVC = UIActivityViewController(activityItems: [MyActivityItemSource(title: cocktail.unwrappedDrink, text: cocktail.getShareMessageString())], applicationActivities: nil)
        
        UIApplication.shared.currentUIWindow()?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
    private func delete(cocktail: Cocktail) {
        moc.delete(cocktail)
        
        try? moc.save()
    }
}

// MARK: - Extracted Views

struct ImageAndTitleView: View {
    
    // MARK: Public properties
    
    let cocktail: Cocktail
    
    
    // MARK: Body
    
    var body: some View {
        VStack {
            if let image = cocktail.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
                    .padding()
                    .scaledToFill()
            } else {
                LazyImage(url: URL(string: cocktail.unwrappedThumbnail))
                    .frame(width: 150, height: 150)
                    .padding()
            }
            
            Text(cocktail.unwrappedCategory + " | " + cocktail.unwrappedAlcoholic)
                .font(.title)
            
            Text("Served in: " + cocktail.unwrappedGlass)
                .font(.title3)
            
            Divider()
        }
        .padding()
    }
}

// MARK: ComponentsView

struct ComponentsView: View {
    
    // MARK: Environment
    
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: Public properties
    
    var components: [Component]
    
    
    // MARK: Body
    
    var body: some View {
        VStack {
            Text("Ingredients")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            /// I could have iterated over cocktail.ingredients but I wanted a second fetchRequest
            ForEach(components, id: \.self) {
                Text("\($0.unwrappedMeasure) \($0.unwrappedName)")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(colorScheme == .light ? AppColors.getRandomLightColor(with: $0.unwrappedName.getFirstCharacterLowercasedOrNil()) : AppColors.getRandomDarkColor(with: $0.unwrappedName.getFirstCharacterLowercasedOrNil()))
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

// MARK: Preparation View

struct PreparationView: View {
    
    // MARK: Environment
    
    @Environment(\.colorScheme) var colorScheme
    
    
    // MARK: Public properties
    
    let cocktail: Cocktail
    
    
    // MARK: Body
    
    var body: some View {
        VStack {
            Text("Preparation")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            
            Text(cocktail.unwrappedInstructions)
                .padding()
                .frame(maxWidth: .infinity)
                .background(colorScheme == .light ? AppColors.getRandomLightColor(with: cocktail.unwrappedDrink.getFirstCharacterLowercasedOrNil()) : AppColors.getRandomDarkColor(with: cocktail.unwrappedDrink.getFirstCharacterLowercasedOrNil()))
                .lineLimit(nil)
                .cornerRadius(10)
        }
        .padding()
    }
}
