//
//  Section.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 3/23/22.
//

//import Foundation  
import UIKit

class Section {
    var sectionTitle: String
    var sectionSubtitle: String
    var sectionDescription: String
    var sectionIcon: UIImage
    var sectionBanner: UIImage

    init(title: String!, subtitle: String!, description: String!, icon: UIImage!, banner: UIImage!) {
        self.sectionTitle = title
        self.sectionSubtitle = subtitle
        self.sectionDescription = description
        self.sectionIcon = icon
        self.sectionBanner = banner
    }
}

let sections = [
    Section(title: "Advanced Custom Layout", subtitle: "SwiftUI for iOS 15", description: "Build an iOS app for iOS 15 with custom layouts.", icon: UIImage(named: "Logo SwiftUI"), banner: UIImage(named: "Illustration 3")),
    Section(title: "Coding the Home View", subtitle: "SwiftUI Concurrency", description: "Learn about the formatted(date:time:) method and AsyncImage", icon: UIImage(named: "Logo SwiftUI"), banner: UIImage(named: "Illustration 4")),
    Section(title: "Colors and Shadows", subtitle: "Flutter for Designers", description: "Read about the design guidelines and how you can use color to maximize your best views", icon: UIImage(named: "Logo Flutter"), banner: UIImage(named: "Illustration 1")),
    Section(title: "Basics of UI Kit in Swift", subtitle: "UI Kit for begginers", description: "Built a buitiful and modern app usig native Swift language UI Kit", icon: UIImage(named: "Logo SwiftUI"), banner: UIImage(named: "Illustration 3"))
]
