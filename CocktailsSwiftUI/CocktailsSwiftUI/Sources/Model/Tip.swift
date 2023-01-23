//
//  Tip.swift
//  CocktailsSwiftUI
//
//  Created by Victor on 23/01/2023.
//

import SwiftUI

struct Tip: Identifiable {
    let id = UUID()
    let image: Image
    let shortDescription: String
    let longDescription: String
    
    static let tips: [Tip] = [
        Tip(image: Image("qualityDrinks"), shortDescription: "Use premium liquors.", longDescription: """
                It cannot be overstated how important premium liquor is for a quality cocktail. We’re not saying you need to mix Macallan 25 year old scotch into that Dry Rob Roy, but don’t scrape the bottom of barrel, either.
                """),
        Tip(image: Image("iceCold"), shortDescription: "Chill your glasses ahead of time.", longDescription: """
                Either chill them in your fridge or fill it with ice and water. By chilling the glass you help ensure the cocktail remains refreshingly cool to the very last sip.
                """),
        Tip(image: Image("jigger"), shortDescription: "Use a high quality jigger.", longDescription: """
                This lets you accurately measure cocktails with ease. Many cocktails which include numerous ingredients can be ruined with an uneven balance of booze. For shame.
                """),
        Tip(image: Image("lotsOfIce"), shortDescription: "When shaking, use lots of ice.", longDescription: """
                More ice helps chill the cocktail further. Always add the ice last as it can dilute the drink if left there too long.
                """),
        Tip(image: Image("shake"), shortDescription: "Shake, shake, and shake some more!", longDescription: """
                Shake the cocktails vigorously until you notice condensation on the outside of the jigger. This lets the cold fully permeate the drink and delivers a cool, crisp finish to the cocktail.
                """),
        Tip(image: Image("smallGlasses"), shortDescription: "Use small glasses.", longDescription: """
                Yes, it will be more work in the long run, but – unless you’re Arthur – large glasses leave you with a warm cocktail.
                """),
        Tip(image: Image("sample"), shortDescription: "Sample before serving.", longDescription: """
                Fruit juices can vary in sweetness from fruit to fruit; try every drink (through a straw of course!) before serving it to unsuspecting patrons.
                """),
        Tip(image: Image("freshIngredients"), shortDescription: "Use fresh ingredients.", longDescription: """
                Fresh squeezed juice goes a long way with cocktails. If you can’t squeeze it yourself, purchase quality juices instead. Rose’s Lime Juice is your best bet if you can’t get fresh limes.
                """),
        Tip(image: Image("barTools"), shortDescription: "Get a solid set of bar tools.", longDescription: """
                Like a chef’s knives, you’ll want a quality jigger, shaker, stirrer, muddler, etc. There are several bar sets available , including this one and this travel bar kit.
                """),
        Tip(image: Image("qualityGlasses"), shortDescription: "Quality glassware ...", longDescription: """
                Every respectable home bar needs a proper cocktail shaker, mojito glasses, old fashioned glasses and the obligatory whiskey glasses.
                """),
        Tip(image: Image("bubbles"), shortDescription: "Keep the buzz!", longDescription: """
                When mixing cocktails with sparkling ingredients – sparkling wine, club soda or sparkling water – be sure to add them at the last second.
                """),
        Tip(image: Image("stirr"), shortDescription: "Shaken or stirred?", longDescription: """
                It’s an honest question, and mostly up to personal preference. The only exception, to this, however, is when the cocktail includes heavy ingredients like cream… in which case heavy shaking is required to fully mix the ingredients.
                """)
    ]
    
    init(image: Image, shortDescription: String, longDescription: String) {
        self.image = image
        self.shortDescription = shortDescription
        self.longDescription = longDescription
    }
}
