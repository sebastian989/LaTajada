//
//  SearchViewController.swift
//  LaTajada
//
//  Created by Sebastián on 1/11/14.
//  Copyright (c) 2014 Sebastián. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    // Properties
    var data : Array<[String:String]>!
    var filteredData : Array<[String:String]>!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.bounces = true
        self.tableView.delaysContentTouches = true
        
        self.activity.startAnimating()
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.frame = self.loadingView.bounds
        self.loadingView.insertSubview(effectView, atIndex: 0)
        
        Alamofire.request(.GET, "https://dl.dropboxusercontent.com/u/40526502/LaTajada/data.json").responseJSON
        {
            (_, _, JSON, _) in self.handleResponse(JSON!)
        }
    }
    
    func handleResponse(data : AnyObject)
    {
        self.activity.stopAnimating()
        self.loadingView.hidden = true
        self.data = data as Array<[String:String]>
        self.filteredData = self.data
        self.tableView.reloadData()
        self.tableView.hidden = false
    }
    
    // Search methods
    func searchBarTextDidBeginEditing(searchBar: UISearchBar)
    {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.isEmpty {
            self.filteredData = self.data
        }
        else
        {
            filterDataFromSearchText(searchText)
        }
        self.tableView.reloadData()
    }
    
    func filterDataFromSearchText(searchText : String)
    {
        self.filteredData = self.data.filter(
            {
                (item : [String:String]) -> Bool in
                let stringMatch = String(item["nombre"]!).lowercaseString.rangeOfString(searchText.lowercaseString)
                return (stringMatch != nil)
            })
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        self.searchBar.resignFirstResponder()
        self.searchBar.showsCancelButton = false
    }
    
    // Table view methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier = "CellA"
        var cell: CellA! = self.tableView.dequeueReusableCellWithIdentifier(identifier ,forIndexPath: indexPath) as CellA
        if let item = self.filteredData?[indexPath.row]
        {
            var name : String = item["nombre"]!
            if indexPath.row % 2 == 0
            {
                cell.rightImage.hidden = true
                cell.rightLabel.hidden = true
                cell.leftLabel.text   = name
            }
            else
            {
                cell.leftImage.hidden = true
                cell.leftLabel.hidden = true
                cell.rightLabel.text   = name
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.filteredData?.count {
            return self.filteredData.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.searchBar.showsCancelButton = false
        self.searchBar.resignFirstResponder()
        let detailView = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as DetailViewController
        detailView.item = self.filteredData[indexPath.row]
        self.showViewController(detailView, sender: self)
        self.tableView.reloadData()
    }
}
