//
//  CoursesTableViewCell.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 3/23/22.
//

import UIKit

class CoursesTableViewCell: UITableViewCell {
    
    @IBOutlet private var backgroundImage: UIImageView!
    @IBOutlet private var bannerImage: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var logoImage: UIImageView!
    
    // Setup cell labels and logos
    var course: Course? {
        didSet {
            guard let course = course else { return }
            
            titleLabel.text = course.courseTitle
            subtitleLabel.text = course.courseSubtitle
            descriptionLabel.text = course.courseDescription
            logoImage.image = course.courseIcon
            bannerImage.image = course.courseBanner
            backgroundImage.image = course.courseBackground
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        super.layoutIfNeeded()
    }
    
    override public func prepareForReuse() {
        prepareForReuse()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellShadow()
        defaultImagesAndLabelsSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // Set shadow and corner radius to the view
    private func cellShadow () {
        layer.shadowColor = UIColor(named: "Shadow")!.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
        layer.masksToBounds = false
        layer.cornerRadius = 30
        layer.cornerCurve = .continuous
    }
    
    private func defaultImagesAndLabelsSetup () {
        titleLabel.text = "SwiftUI Handbook"
        subtitleLabel.text = "20 HOURS - 30 SECTIONS"
        descriptionLabel.text = "Learn about all basics of SwiftUI"
        bannerImage.image = UIImage(named: "Illustration 2")
        logoImage.image = UIImage(named: "Logo React")
    }
}
