//
//  LearnMoreViewController.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 3/17/22.
//

import UIKit
import Combine
import Firebase

class FeaturedViewController: UIViewController {
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var handbooksCollectionView: UICollectionView!
    @IBOutlet var coursesTableView: UITableView!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    
    private var tokens: Set<AnyCancellable> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handbooksCollectionView.delegate = self
        handbooksCollectionView.dataSource = self
        handbooksCollectionView.layer.masksToBounds = false
        
        coursesTableView.dataSource = self
        coursesTableView.delegate = self
        coursesTableView.layer.masksToBounds = false
        
        // Set the height of TableView depends of it's content
        coursesTableView.publisher(for: \.contentSize)
            .sink { newContentSize in
                self.tableViewHeightConstraint.constant = newContentSize.height
            }
            .store(in: &tokens)
        
        scrollView.delegate = self
    }
    
    // Sending the selectedCourse to the detailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVS = segue.destination as? CoursesViewController, let course = sender as? Course {
            detailsVS.course = course
        }
    }
    
    private func goToLogInScreen() {
        let vcID = "LoginViewController"
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: vcID) as! LoginViewController
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true) {
        }
    }
    
    // MARK: IBActions
    
    
    @IBAction func onLogOffButtonTapped(_ sender: Any) {
        print("Tap on the button")
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Your sign out complete succsessfully")
            
                self.goToLogInScreen()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }

    }
}

// MARK:  Collection View Delegate and Data Source extension
extension FeaturedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        handbooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = "CourseCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HandbookCollectionViewCell
        
        cell.handbook = handbooks[indexPath.item]
        
        return cell
    }
}

// MARK: TableView Delegate and DataSource extension

extension FeaturedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        courses.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    // Each row in the new section to make a space between rows.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "CoursesTableCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CoursesTableViewCell
        
        cell.course = courses[indexPath.section]
        
        return cell
    }
    
    // Set the height of Header and Footer in the TableView
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
    
    // Prepare for segue and pass the selectedCourse to the new View
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let segueID = "presentCourseSegue"
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCourse = courses[indexPath.section]
        performSegue(withIdentifier: segueID, sender: selectedCourse)
    }
}

// MARK: ScrollView Delegate extension

// Changing Title depends on ScrollView position
extension FeaturedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let contentOffsetY = scrollView.contentOffset.y
        
        let percentage = (contentOffsetY * 100) / contentHeight
        
        if percentage < 15.5 {
            self.title = "Featured"
        } else if percentage >= 15.5 && percentage < 32.5 {
            self.title = "Handbooks"
        } else {
            self.title = "Courses"
        }
    }
}
