//
//  SectionTableViewCell.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 3/25/22.
//

import UIKit

class SectionTableViewCell: UITableViewCell {

    @IBOutlet private var courseLogoImage: CustomImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
//    @IBOutlet private var progressBar: UIProgressView!
    
    var section: Section? {
        didSet {
            guard let section = section else { return }

            courseLogoImage.image = section.sectionIcon
            titleLabel.text = section.sectionTitle
            subtitleLabel.text = section.sectionSubtitle
            descriptionLabel.text = section.sectionDescription
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
