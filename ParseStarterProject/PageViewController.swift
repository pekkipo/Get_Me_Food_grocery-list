//
//  PageViewController.swift
//  PerfectList
//
//  Created by Created by PekkiPo (Aleksei Petukhov) on 09/02/16.
//  Copyright © 2016 PekkiPo. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController
{
    
    
    
    /*
    var pageHeaders = [NSLocalizedString("tutheaderintro", comment: ""), NSLocalizedString("tutheader1", comment: ""), NSLocalizedString("tutheader2", comment: ""), NSLocalizedString("tutheader3", comment: ""), NSLocalizedString("tutheader4", comment: ""), NSLocalizedString("tutheader5", comment: ""), NSLocalizedString("tutheader6", comment: ""), NSLocalizedString("tutheader7", comment: ""), NSLocalizedString("tutheader8", comment: "")]
    
    var pageImages = [NSLocalizedString("tutimintro", comment: ""), NSLocalizedString("tutim1", comment: ""), NSLocalizedString("tutim2", comment: ""), NSLocalizedString("tutim3", comment: ""), NSLocalizedString("tutim4", comment: ""), NSLocalizedString("tutim5", comment: ""), NSLocalizedString("tutim6", comment: ""), NSLocalizedString("tutim7", comment: ""), "Tutorial8"]
    var pageDescriptions = ["", "", "", "", "", "", "", "", ""]
    */
    
    var pageHeaders = [NSLocalizedString("tutheaderintro", comment: ""), NSLocalizedString("tutheader1", comment: ""), NSLocalizedString("tutheader2", comment: ""), NSLocalizedString("tutheader3", comment: ""), NSLocalizedString("tutheader4", comment: ""), NSLocalizedString("tutheader5", comment: "")]
    
    //var pageImages = [NSLocalizedString("tutimintro", comment: ""), NSLocalizedString("tutim1", comment: ""), NSLocalizedString("tutim2", comment: ""), NSLocalizedString("tutim3", comment: ""), NSLocalizedString("tutim4", comment: ""), "Tutorial5"]
    
     var pageImages = [NSLocalizedString("tutintro1", comment: ""), NSLocalizedString("tutintro1", comment: "")]
    
    var pageDescriptions = ["", ""]
    //var pageDescriptions = ["", "", "", "", "", ""]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this class is the page view controller's data source itself
        self.dataSource = self
        
        // create the first walkthrough vc
        if let startWalkthroughVC = self.viewControllerAtIndex(0) {
            setViewControllers([startWalkthroughVC], direction: .Forward, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Navigate
    
    func nextPageWithIndex(index: Int)
    {
        if let nextWalkthroughVC = self.viewControllerAtIndex(index+1) {
            setViewControllers([nextWalkthroughVC], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    func viewControllerAtIndex(index: Int) -> WalkthroughViewController?
    {
        if index == NSNotFound || index < 0 || index >= self.pageDescriptions.count {
            return nil
        }
        
        // create a new walkthrough view controller and assing appropriate date
        if let walkthroughViewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughViewController") as? WalkthroughViewController {
            
            walkthroughViewController.imageName = pageImages[index]
           // walkthroughViewController.headertext = pageHeaders[index]
            //walkthroughViewController.descriptiontext = pageDescriptions[index]
            walkthroughViewController.index = index
            
            return walkthroughViewController
        }
        
        return nil
    }
}

/*
extension PageViewController : UIPageViewControllerDataSource
{
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! WalkthroughViewController).index
        index++
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughViewController).index
        index--
        return self.viewControllerAtIndex(index)
    }
}
*/

