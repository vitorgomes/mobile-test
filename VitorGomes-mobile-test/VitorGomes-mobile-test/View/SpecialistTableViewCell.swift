//
//  SpecialistTableViewCell.swift
//  VitorGomes-mobile-test
//
//  Created by Vitor Gomes on 15/05/21.
//

import UIKit

class SpecialistTableViewCell: UITableViewCell {

    @IBOutlet weak var ivInitials: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDistance: UILabel!
    @IBOutlet weak var lbDetails: UILabel!
    @IBOutlet weak var btChat: UIButton!
    @IBOutlet weak var btCall: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Setting rounded corners to both buttons
        btChat.layer.cornerRadius = 16
        btCall.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func chatPressed(_ sender: UIButton) {
        //No implementation needed.
    }
    
    @IBAction func callPressed(_ sender: UIButton) {
        //No implementation needed.
    }
}
