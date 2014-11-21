//
//  CellA.swift
//  LaTajada
//
//  Created by Sebastián on 12/11/14.
//  Copyright (c) 2014 Sebastián. All rights reserved.
//

import UIKit

class CellB: UITableViewCell {
  
  @IBOutlet weak var rightImage: UIImageView!
  @IBOutlet weak var rightLabel: UILabel!
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
