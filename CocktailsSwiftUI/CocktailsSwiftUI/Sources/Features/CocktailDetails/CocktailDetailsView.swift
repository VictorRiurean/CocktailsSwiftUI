//
//  CocktailDetailsView.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 24/01/2023.
//

import NukeUI
import SwiftData
import SwiftUI


struct CocktailDetailsView: View {
    
    // MARK: Environment
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    
    // MARK: Query
    
    @Query var cocktail: [Cocktail]
    @Query var components: [Component]
    
    
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
                    .navigationTitle(cocktail.strDrink)
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
                                dismiss()
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
                            let response = await viewModel.fetchDrink(name: name)
                            
                            modelContext.insert(Cocktail(response: response, modelContext: modelContext))
                            
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
        _cocktail = Query(filter: #Predicate<Cocktail> { $0.strDrink == name })
        _components = Query(filter: #Predicate<Component> { $0.cocktail?.strDrink == name })
        
        self.name = name
        self.shouldAnimate = shouldAnimate
    }
    
    
    // MARK: Private methods
    
    private func actionSheet() {
        guard let cocktail = cocktail.first else { return }
        
        let activityVC = UIActivityViewController(
            activityItems: [MyActivityItemSource(title: cocktail.strDrink, text: cocktail.getShareMessageString())],
            applicationActivities: nil
        )
        
        UIApplication.shared.currentUIWindow()?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
    private func delete(cocktail: Cocktail) {
        modelContext.delete(cocktail)
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
                LazyImage(url: URL(string: cocktail.strDrinkThumb))
                    .frame(width: 150, height: 150)
                    .padding()
            }
            
            Text(cocktail.strCategory + " | " + cocktail.strAlcoholic)
                .font(.title)
            
            Text("Served in: " + cocktail.strGlass)
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
                Text("\($0.measure) \($0.name)")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(colorScheme == .light ? AppColors.getRandomLightColor(with: $0.name.getFirstCharacterLowercasedOrNil()) : AppColors.getRandomDarkColor(with: $0.name.getFirstCharacterLowercasedOrNil()))
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
            
            Text(cocktail.strInstructions)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    colorScheme == .light ? AppColors.getRandomLightColor(with: cocktail.strDrink.getFirstCharacterLowercasedOrNil()) : AppColors.getRandomDarkColor(with: cocktail.strDrink.getFirstCharacterLowercasedOrNil())
                )
                .lineLimit(nil)
                .cornerRadius(10)
        }
        .padding()
    }
}
