//
//  LibrarySettingsTableViewCell.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 4/1/22.
//

import UIKit

class LibrarySettingsTableViewCell: UITableViewCell {
    @IBOutlet private var settingIcon: UIImageView!
    @IBOutlet private var settingTitleLabel: UILabel!
    
    var librarySetting: Topic? {
        didSet {
            guard let librarySetting = librarySetting else { return }
            
            settingIcon.image = UIImage(systemName: librarySetting.topicSymbol)
            settingTitleLabel.text = librarySetting.topicTitle
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
