//
//  Topic.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 3/28/22.
//

import Foundation

class Topic {
    
    var topicTitle: String
    var topicSymbol: String
    
    init(topicTitle: String, topicSymbol: String) {
        self.topicTitle = topicTitle
        self.topicSymbol = topicSymbol
    }
}

let topics: [Topic] = [
    Topic(topicTitle: "IOS Development", topicSymbol: "iphone"),
    Topic(topicTitle: "UIDesign", topicSymbol: "eyedropper"),
    Topic(topicTitle: "Web Development", topicSymbol: "desktopcomputer"),
    Topic(topicTitle: "App Architecdture", topicSymbol: "platter.2.filled.iphone")
]

let librarySettings = [
    
    Topic(topicTitle: "History", topicSymbol: "clock.fill"),
    Topic(topicTitle: "Favorites", topicSymbol: "star.fill"),
    Topic(topicTitle: "Downloads", topicSymbol: "square.and.arrow.down.fill"),
    Topic(topicTitle: "Recommendations", topicSymbol: "text.badge.plus")
    
]
