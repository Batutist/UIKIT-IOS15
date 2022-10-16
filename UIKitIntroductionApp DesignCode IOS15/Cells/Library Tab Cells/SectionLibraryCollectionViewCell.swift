//
//  SectionCollectionViewCell.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 4/1/22.
//

import UIKit

class SectionLibraryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var bannerImage: UIImageView!
    @IBOutlet private var logoImage: CustomImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    
    // Setup all labels and logos
    var section: Section? {
        didSet {
            guard let section = section else { return }
            
            titleLabel.text = section.sectionTitle
            subtitleLabel.text = section.sectionSubtitle
            logoImage.image = section.sectionIcon
            bannerImage.image = section.sectionBanner
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        super.layoutIfNeeded()
    }
    
//    override public func prepareForReuse() {
//        prepareForReuse()
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellShadow()
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
}
