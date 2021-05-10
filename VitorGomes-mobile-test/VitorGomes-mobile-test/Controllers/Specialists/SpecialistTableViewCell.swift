//
//  SpecialistTableViewCell.swift
//  VitorGomes-mobile-test
//
//  Created by Vitor Gomes on 06/05/21.
//

import UIKit

class SpecialistTableViewCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDistance: UILabel!
    @IBOutlet weak var lbDetails: UILabel!
    @IBOutlet weak var lbInitialLetter: UILabel! // Since project doesn't use real images only first letter of the name, decided make it as label.
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func chat(_ sender: UIButton) {
        
    }
    
    @IBAction func call(_ sender: UIButton) {
        
    }
    
}
