//
//  NotificationsViewController.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 4/4/22.
//

import UIKit
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class NotificationsViewController: UIViewController {

    @IBOutlet var notificationsTableView: UITableView!
    @IBOutlet var cardView: CustomView!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!

    // Diffable DataSourse and Snapshot for it
    var dataSource: UITableViewDiffableDataSource<TBSection, NotificationModel>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<TBSection, NotificationModel>! = nil
    
    private var tokens: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardView.alpha = 0
        tableViewSetup()
    }
    // Set TableView properties
    private func tableViewSetup() {
        
        // Set publisher to listen changes of Table View size
        notificationsTableView.publisher(for: \.contentSize)
            .sink { newContentSize in
                self.tableViewHeightConstraint.constant = newContentSize.height
            }
            .store(in: &tokens)

        notificationsTableView.delegate = self
        // setting the DataSource to DiffableDataSource
        self.dataSource = UITableViewDiffableDataSource<TBSection, NotificationModel>(tableView: notificationsTableView) {
            (tableView: UITableView, indexPath: IndexPath, notification: NotificationModel) -> NotificationTableViewCell in
            let cellID = "NotificationTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? NotificationTableViewCell else {
                fatalError("Could not create a new cell")
            }
            cell.notification = notification
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        
        Task {
            do {
                try await loadData()
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    // Async load func to get data from the Firestore database
    private func loadData() async throws {
        
        currentSnapshot = NSDiffableDataSourceSnapshot<TBSection, NotificationModel>()
        currentSnapshot.appendSections([.main])
        
        let dbID = "notifications"
        let orderKey = "sentAt"
        // creating reference to dataBase
        let db = Firestore.firestore()
            // retrieve documents from DB
        let documents = try await db.collection(dbID)
            .order(by: orderKey, descending: true) // sorting them by timeStamp
            .getDocuments()
        // local collection of DB notifications
        var notifications = [NotificationModel]()
        // Adding documents from DB to local notifications variable
        for snapshot in documents.documents {
            if let data = try? snapshot.data(as: NotificationModel.self){
                notifications.append(data)
            }
        }
        // adding local notifications to currentSnapshot
        currentSnapshot.appendItems(notifications, toSection: .main)
        // applying current SnapShot to dataSource
        await dataSource.apply(currentSnapshot, animatingDifferences: true)
        
        // present cardView only when data is loaded
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                self.cardView.alpha = 1
            }
        }
    }
}

extension NotificationsViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
