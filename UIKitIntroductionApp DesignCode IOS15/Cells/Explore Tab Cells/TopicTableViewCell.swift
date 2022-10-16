//
//  TopicTableViewCell.swift
//  UIKitIntroductionApp DesignCode IOS15
//
//  Created by Sergey Kovalev on 3/28/22.
//

import UIKit

class TopicTableViewCell: UITableViewCell {
    @IBOutlet private var topicIcon: UIImageView!
    @IBOutlet private var topicTitleLabel: UILabel!
    
    var topic: Topic? {
        didSet {
            guard let topic = topic else { return }
            
            topicIcon.image = UIImage(systemName: topic.topicSymbol)
            topicTitleLabel.text = topic.topicTitle
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
