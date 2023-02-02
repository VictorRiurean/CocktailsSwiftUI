//
//  MyActivityItemSource.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 02/02/2023.
//

import LinkPresentation

class MyActivityItemSource: NSObject, UIActivityItemSource {
    
    // MARK: Private properties
    
    private var title: String
    private var text: String
    
    
    // MARK: Lifecycle
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
        
        super.init()
    }
    
    
    // MARK: Delegate methods
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return text
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return text
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return title
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        
        metadata.title = title
        metadata.iconProvider = NSItemProvider(object: UIImage(systemName: "wineglass")!)
        //This is a bit ugly, though I could not find other ways to show text content below title.
        //https://stackoverflow.com/questions/60563773/ios-13-share-sheet-changing-subtitle-item-description
        //You may need to escape some special characters like "/".
        metadata.originalURL = URL(fileURLWithPath: text)
        
        return metadata
    }
}
