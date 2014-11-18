//
//  DetailViewController.swift
//  LaTajada
//
//  Created by Sebastián on 15/11/14.
//  Copyright (c) 2014 Sebastián. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var gramsLabel: UILabel!
    @IBOutlet weak var fiberLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    
    
    // Properties
    var item : [String:String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fillView()
    }
    
    func fillView()
    {
        // Set main image
        var url = NSURL(string: ("https://dl.dropboxusercontent.com/u/40526502/LaTajada/exampleImage.pdf"))
        self.mainImage.sd_setImageWithURL(NSURL(string: "https://dl.dropboxusercontent.com/u/40526502/LaTajada/exampleImage.pdf" as String))
        
        self.typeLabel.text = self.item!["tipo"]
        self.descriptionLabel.text = self.item!["descripcion"]
        self.amountLabel.text = self.item!["cantidad"]
        
        // Custom calories label
        var calories : String = self.item!["calorias"]!
        var caloriesFull = calories + " kcal"
        var caloriesAttributedString = NSMutableAttributedString(string: caloriesFull)
        caloriesAttributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "billy", size: 36)!, range: NSMakeRange(0, countElements(calories)))
        self.caloriesLabel.attributedText = caloriesAttributedString
        
        // Custom grams label
        var grams : String = self.item!["gramos"]!
        var gramsFull = grams + " gr"
        var gramsAttributedString = NSMutableAttributedString(string: gramsFull)
        gramsAttributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "billy", size: 36)!, range: NSMakeRange(0, countElements(grams)))
        self.gramsLabel.attributedText = gramsAttributedString
        
        // Custom fiber label
        var fiber : String = self.item!["fibra"]!
        var fiberFull = fiber + " gr"
        var fiberAttributedString = NSMutableAttributedString(string: fiberFull)
        fiberAttributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "billy", size: 36)!, range: NSMakeRange(0, countElements(fiber)))
        self.fiberLabel.attributedText = fiberAttributedString
    }
    
    @IBAction func backToList(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
}
