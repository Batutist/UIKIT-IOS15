//
//  LibraryViewController.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 4/1/22.
//

import UIKit
import Combine
import SwiftUI

class LibraryViewController: UIViewController {

    @IBOutlet var sectionsCollectionView: UICollectionView!
    @IBOutlet var librarySettingsTableView: UITableView!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
   
    private var tokens: Set<AnyCancellable> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sectionsCollectionView.delegate = self
        sectionsCollectionView.dataSource = self
        sectionsCollectionView.layer.masksToBounds = false
        
        librarySettingsTableView.delegate = self
        librarySettingsTableView.dataSource = self
        librarySettingsTableView.layer.masksToBounds = false
        // Set the height of TableView depends of it's content
        librarySettingsTableView.publisher(for: \.contentSize)
            .sink { newContentSize in
                self.tableViewHeightConstraint.constant = newContentSize.height
            }
            .store(in: &tokens)
    }
    
//    @IBSegueAction func createCertificatesView(_ coder: NSCoder) -> UIViewController? {
//        print("Action performs")
//        return UIHostingController(coder: coder, rootView: EmptyView().background(.blue))
//    }
    
    @IBSegueAction func createCertificatesView(_ coder: NSCoder) -> UIViewController? {
        guard let viewController = UIHostingController(coder: coder, rootView: CertificateView()) else { return nil }
        viewController.view.backgroundColor = .clear
        
        return viewController
    }
}

// MARK: CollectionView Delegate and DataSourse extension
extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = "SectionCell"
        // Define each section depends on IndexPath
        let section = sections[indexPath.item]
        // Creating a reusable cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SectionLibraryCollectionViewCell
        
        cell.section = section
        
        return cell
    }
}

// MARK: TableView Delegate and DataSourse extension
extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        librarySettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celID = "SettingsCell"
        let setting = librarySettings[indexPath.row]
        // Creating a reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: celID, for: indexPath) as! LibrarySettingsTableViewCell
        
        cell.librarySetting = setting
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
