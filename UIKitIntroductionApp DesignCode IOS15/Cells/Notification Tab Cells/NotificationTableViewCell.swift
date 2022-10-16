//
//  NotificationTableViewCell.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 4/4/22.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var notificationIcon: CustomImageView!
    
    var notification: NotificationModel? {
        didSet {
            guard let notification = notification else { return }
            
            titleLabel.text = notification.title
            subtitleLabel.text = notification.subtitle
            messageLabel.text = notification.message
            notificationIcon.image = UIImage(named: notification.image)
            
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
