//
//  ExploreViewController.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 3/26/22.
//

import UIKit
import Combine

class ExploreViewController: UIViewController {

    @IBOutlet var sectionsCollectionView: UICollectionView!
    @IBOutlet var topicsTableView: UITableView!
    @IBOutlet var popularCollectionView: UICollectionView!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
   
    private var tokens: Set<AnyCancellable> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sectionsCollectionView.delegate = self
        sectionsCollectionView.dataSource = self
        sectionsCollectionView.layer.masksToBounds = false
        
        topicsTableView.delegate = self
        topicsTableView.dataSource = self
        topicsTableView.layer.masksToBounds = false
        // Set the height of TableView depends of it's content
        topicsTableView.publisher(for: \.contentSize)
            .sink { newContentSize in
                self.tableViewHeightConstraint.constant = newContentSize.height
            }
            .store(in: &tokens)
        
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        popularCollectionView.layer.masksToBounds = false
    }
}

// MARK: CollectionView Delegate and DataSourse extension
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == sectionsCollectionView {
            return sections.count
        } else {
            return handbooks.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sectionsCollectionView {
            let cellID = "SectionCell"
            // Define each section depends on IndexPath
            let section = sections[indexPath.item]
            // Creating a reusable cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SectionsCollectionViewCell
            
            cell.section = section
            
            return cell
        } else {
            let cellID = "PopularCell"
            let handbook = handbooks[indexPath.item]
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PopularCollectionViewCell
            
            cell.handbook = handbook
            
            return cell
        }
    }
}

// MARK: TableView Delegate and DataSourse extension
extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celID = "TopicCell"
        let topic = topics[indexPath.row]
        // Creating a reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: celID, for: indexPath) as! TopicTableViewCell
        
        cell.topic = topic
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


