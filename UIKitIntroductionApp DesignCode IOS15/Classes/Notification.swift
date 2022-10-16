//
//  Notification.swift
//  UIKit for iOS 15
//
//  Created by Sai Kambampati on 1/9/22.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

enum TBSection: CaseIterable {
    case main
}

struct NotificationModel: Codable, Hashable {
    @DocumentID var id: String?
    var title: String!
    var subtitle: String!
    var message: String!
    var image: String!
    var sentAt: Timestamp!
}

let sampleNotifications = [
    NotificationModel(id: "0x1", title: "New Release", subtitle: "SwiftUI", message: "A new release of the SwiftUI course has been released", image: "Logo SwiftUI", sentAt: Timestamp()),
    NotificationModel(id: "0x2", title: "Content Update", subtitle: "React Hooks", message: "The React Hooks course has been updated", image: "React", sentAt: Timestamp()),
    NotificationModel(id: "0x3", title: "New Release", subtitle: "UIKit for iOS 15", message: "A new release by Sai Kambampati has been pushed", image: "SwiftUI", sentAt: Timestamp()),
    NotificationModel(id: "0x4", title: "Black Friday Deal", subtitle: "Design+Code", message: "Purchase your subscription for 20% off only today", image: "Design+Code", sentAt: Timestamp())/*,
    NotificationModel(id: "0x5", title: "Treat yourself", subtitle: "Figma design", message: "New Figma design course. Learn how to creat UI design for Undroid", image: "Design+Code", sentAt: Timestamp()),
    NotificationModel(id: "0x6", title: "Teeterboard action", subtitle: "Cirque du Soleil", message: "Iconic show Mystere on your screen", image: "Logo SwiftUI", sentAt: Timestamp()),
    NotificationModel(id: "0x7", title: "LetMeCode academy", subtitle: "LetMeCode", message: "Do you want to know how to code?", image: "SwiftUI", sentAt: Timestamp()),
    NotificationModel(id: "0x8", title: "New MacBook availible", subtitle: "MacBook for professionals", message: "Purchase your new powerful machine for all your needs", image: "Logo React", sentAt: Timestamp()),
    NotificationModel(id: "0x9", title: "New AUDI Q7", subtitle: "Upgrade your car today", message: "Great deals on new AUDI Q7 only this week.", image: "Play", sentAt: Timestamp())*/
]
