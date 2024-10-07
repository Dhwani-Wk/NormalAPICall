//
//  JokeCell.swift
//  xibProject
//
//  Created by admin on 06/09/24.
//

import UIKit

class JokeCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var punchlineLabel: UILabel!
    
    @IBOutlet weak var setupLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
