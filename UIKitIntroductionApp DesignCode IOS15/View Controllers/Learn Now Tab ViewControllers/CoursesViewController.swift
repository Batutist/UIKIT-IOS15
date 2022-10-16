//
//  CoursesViewController.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 3/23/22.
//

import UIKit
import Combine

class CoursesViewController: UIViewController {
    
    @IBOutlet var courseTitleLabel: UILabel!
    @IBOutlet var courseSubtitleLabel: UILabel!
    @IBOutlet var courseDescriptionLabel: UILabel!
    @IBOutlet var courseAuthorNameLabel: UILabel!
    @IBOutlet var courseAuthorAvatarImage: CustomImageView!
    @IBOutlet var courseBackgroundImage: UIImageView!
    @IBOutlet var courseBannerImage: UIImageView!
    @IBOutlet var courseIconImage: CustomImageView!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var menuButton: UIButton!
    
    
    @IBOutlet var sectionsTableView: UITableView!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    
    private var tokens: Set<AnyCancellable> = []
    
    var course: Course?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetup()
        courseInfoSetup()
        menuSheetSetup()
    }
    
    //MARK: IBActions
    @IBAction func onClossButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    //MARK: View Setup
    // Set TableView properties
    private func tableViewSetup() {
        sectionsTableView.dataSource = self
        sectionsTableView.delegate = self
        
        sectionsTableView.publisher(for: \.contentSize)
            .sink { newContentSize in
                self.tableViewHeightConstraint.constant = newContentSize.height
            }
            .store(in: &tokens)
    }
    
    // Set labels and images
    private func courseInfoSetup () {
        guard let course = course else { return }
        
        courseTitleLabel.text = course.courseTitle
        courseSubtitleLabel.text = course.courseSubtitle
        courseDescriptionLabel.text = course.courseDescription
        courseAuthorNameLabel.text = "Taught by \(course.courseAuthor?.formatted(.list(type: .and, width: .standard)) ?? "Design+Code")"
        courseBackgroundImage.image = course.courseBackground
        courseBannerImage.image = course.courseBanner
        courseIconImage.image = course.courseIcon
    }
    
    // Creating menu sheet
    private func menuSheetSetup() {
        
        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
            // Share course
        }
        let takeTestAction = UIAction(title: "Take Test", image: UIImage(systemName: "highlighter")) { _ in
            // take test
        }
        let downloadAction = UIAction(title: "Download Course", image: UIImage(systemName: "square.and.arrow.down")) { _ in
            // Download course
        }
        let forumsAction = UIAction(title: "Forums", image: UIImage(systemName: "chevron.left.forwardslash.chevron.right")) { _ in
            // Go to forum
        }
        
        let actions = [shareAction, takeTestAction, downloadAction, forumsAction]
        
        let menu = UIMenu(
            title: "Course Options",
            options: .displayInline,
            children: actions
        )
        
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
    }
}

// MARK: TableView Delegate and DataSource Extension

extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        course?.courseSections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "SectionTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SectionTableViewCell
        
        if let selectedCourse = course {
            if let selectedSection = selectedCourse.courseSections?[indexPath.row] {
                print("You are here")
                cell.section = selectedSection
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        UITableView.automaticDimension
    //    }
}
