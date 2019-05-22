//
//  TableViewCell.swift
//  todoApp
//
//  Created by RIVER on 2019/05/22.
//  Copyright © 2019 kwtkMe. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var taskCompletionButton: UIButton!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
