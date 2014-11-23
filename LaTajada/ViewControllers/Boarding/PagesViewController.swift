//
//  PagesViewController.swift
//  LaTajada
//
//  Created by Sebastián on 26/10/14.
//  Copyright (c) 2014 Sebastián. All rights reserved.
//

import Foundation
import UIKit

class PagesViewController : UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: StyledPageControl!
    @IBOutlet weak var facebookButton: UIButton!
    
    override func viewDidLoad()
    {
        self.setStylesToPageControl()
        self.collectionView!.registerNib(UINib(nibName: "BoardingDetailA", bundle: nil), forCellWithReuseIdentifier: "Cell")
        self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "onBoarding")!)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell : BoardingDetailA = self.collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as BoardingDetailA
        
        if indexPath.row == 0
        {
            self.facebookButton.enabled = false
            var image = UIImage(named: "onBoardingA")
            cell.informationImageView.image = image
            return cell;
        }
        
        if indexPath.row == 1
        {
            self.facebookButton.enabled = false
            var image = UIImage(named: "onBoardingB")
            cell.informationImageView.image = image
            return cell;
        }
        
        if indexPath.row == 2
        {
            self.facebookButton.enabled = true
            var image = UIImage(named: "onBoardingC")
            cell.informationImageView.image = image
            return cell;
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        for cell in self.collectionView.visibleCells()
        {
            let index : NSIndexPath = self.collectionView.indexPathForCell(cell as UICollectionViewCell)!
            self.pageControl.currentPage = Int32(index.indexAtPosition(1))
        }
    }
    
    func setStylesToPageControl()
    {
        self.pageControl.setPageControlStyl(PageControlStyleStrokedCircle)
        self.pageControl.setNumbersOfPages(3)
        var color: UIColor                   = UIColor(red: CGFloat(0.79), green: CGFloat(0.15), blue: CGFloat(0.48), alpha: CGFloat(1))
        self.pageControl.coreNormalColor     = color
        self.pageControl.coreSelectedColor   = color
        self.pageControl.strokeSelectedColor = color
        self.pageControl.strokeNormalColor   = color
        self.pageControl.gapWidth            = 30
        self.pageControl.diameter            = 22
        self.pageControl.strokeWidth         = 2
    }
    
    @IBAction func close(sender: AnyObject)
    {
        let searchView = self.storyboard?.instantiateViewControllerWithIdentifier("searchView") as SearchViewController
        self.showViewController(searchView, sender: self)
    }
    
    @IBAction func openFacebook(sender: AnyObject)
    {
        var url : NSURL
        url = NSURL(string: "https://www.facebook.com/latajadaescucha")!
        UIApplication.sharedApplication().openURL(url)
    }
}
