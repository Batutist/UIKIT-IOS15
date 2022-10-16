//
//  PopularCollectionViewCell.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 3/28/22.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var overlayView: UIView!
    @IBOutlet private var bannerImage: UIImageView!
    @IBOutlet private var logoImage: CustomImageView!
    @IBOutlet private var progressBar: UIProgressView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    // Setup all labels and logos
    var handbook: Course? {
        didSet {
            guard let handbook = handbook else { return }
            
            titleLabel.text = handbook.courseTitle
            subtitleLabel.text = handbook.courseSubtitle
            descriptionLabel.text = handbook.courseDescription
            logoImage.image = handbook.courseIcon
            bannerImage.image = handbook.courseBanner
            gradient.colors = handbook.courseGradient
        }
    }
    
    // Setup gradient to background
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        
        let colors = [UIColor.red.cgColor]
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = colors
        gradient.frame = overlayView.frame
        gradient.cornerCurve = .continuous
        gradient.cornerRadius = 30
        return gradient
    }()
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        super.layoutIfNeeded()
    }
    
    override public func prepareForReuse() {
        prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellShadow()
        // default set of labels and logos in case of some error in model
        defaultImagesSetup()
        defaultLabelsSetup()
        
        overlayView.layer.insertSublayer(gradient, at: 0)
        overlayView.layer.cornerRadius = 30
        overlayView.layer.cornerCurve = .continuous
        
    }
    
    // Set shadow and corner radius to the view
    private func cellShadow () {
        layer.shadowColor = UIColor(named: "Shadow")!.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
        layer.masksToBounds = false
        layer.cornerRadius = 30
        layer.cornerCurve = .continuous
    }
    
    private func defaultLabelsSetup () {
        
        titleLabel.text = "SwiftUI Handbook"
        subtitleLabel.text = "20 HOURS - 30 SECTIONS"
        descriptionLabel.text = "Learn about all basics of SwiftUI"
    }
    
    private func defaultImagesSetup () {
        bannerImage.image = UIImage(named: "Illustration 2")
        logoImage.image = UIImage(named: "Logo React")
    }
}
