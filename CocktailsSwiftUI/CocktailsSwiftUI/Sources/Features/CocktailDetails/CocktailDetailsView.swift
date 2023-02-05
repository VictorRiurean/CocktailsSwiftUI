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
    
    
    // MARK: FetchRequests
    
    @FetchRequest var cocktail: FetchedResults<Cocktail>
    @FetchRequest var components: FetchedResults<Component>
    
    
    // MARK: State
    
    @State var isFetching = true
    @State var isShowingAlert = false
    
    
    // MARK: Private properties
    
    private let viewModel = CocktailDetailsViewModel()
    private let name: String
    
    
    // MARK: Body
    
    var body: some View {
        if let cocktail = cocktail.first {
            ScrollView {
                VStack {
                    VStack {
                        LazyImage(url: URL(string: cocktail.unwrappedThumbnail))
                            .frame(width: 150, height: 150)
                            .padding()
                        
                        Text(cocktail.unwrappedCategory + " | " + cocktail.unwrappedAlcoholic)
                            .font(.title)
                        
                        Text("Served in: " + cocktail.unwrappedGlass)
                            .font(.title3)
                        
                        Divider()
                    }
                    .padding()
                    
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
                                .background(colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor())
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    
                    VStack {
                        Text("Preparation")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        
                        Text(cocktail.unwrappedInstructions)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(colorScheme == .light ? AppColors.getRandomLightColor() : AppColors.getRandomDarkColor())
                            .lineLimit(nil)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Spacer()
                }
                .navigationTitle(cocktail.unwrappedDrink)
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationBarBackButtonTitleHidden()
            .toolbar {
                Button {
                    cocktail.isFavourite.toggle()
                    
                    try? moc.save()
                } label: {
                    cocktail.isFavourite ? Image(systemName: "heart.fill") : Image(systemName: "heart")
                }
                .buttonStyle(PlainButtonStyle())
                
                /// ShareLink is normally used in SwiftUI, but as of iOS 16
                /// toolbars do not support it, so we have to go for this instead
                Button(action: actionSheet) {
                    Image(systemName: "square.and.arrow.up")
                }
                .buttonStyle(PlainButtonStyle())
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
            } else {
                Text("Something went horribly wrong here 😱")
                    .onAppear {
                        isShowingAlert = true
                    }
                    .alert("Could not fetch cocktail named \(name)", isPresented: $isShowingAlert) {
                        Button("OK", role: .cancel) { }
                    }
            }
        }
    }
    
    
    // MARK: Lifecycle
    
    init(name: String) {
        _cocktail = FetchRequest<Cocktail>(sortDescriptors: [], predicate: NSPredicate(format: "\(FilterKey.drinkName.rawValue) \(PredicateFormat.equalsTo.rawValue) %@", name))
        _components = FetchRequest<Component>(sortDescriptors: [], predicate: NSPredicate(format: "\(FilterKey.cocktail.rawValue) \(PredicateFormat.equalsTo.rawValue) %@", name))
        
        self.name = name
    }
    
    
    // MARK: Private methods
    
    private func actionSheet() {
        guard let cocktail = cocktail.first else { return }
        
        let activityVC = UIActivityViewController(activityItems: [MyActivityItemSource(title: cocktail.unwrappedDrink, text: cocktail.unwrappedInstructions)], applicationActivities: nil)
        
        UIApplication.shared.currentUIWindow()?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}
