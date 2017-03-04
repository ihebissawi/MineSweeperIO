//
//  FirstUseViewController.swift
//  Minesweeper
//
//  Created by IHEB ISSAWI on 3/3/17.
//  Copyright © 2017 iheb.issawi. All rights reserved.
//

import UIKit

class FirstUseViewController: UIPageViewController, UIPageViewControllerDataSource {

    var arrPageTitle: NSArray = NSArray()
    var arrPagePhoto: NSArray = NSArray()
    var arrBtnTitle: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrPageTitle = ["Use the slider to set the difficulty", "double tap to place a flag", "if you press on a bomb you loose","if you revealed all the squares without pressing a bomb you win"];
        arrPagePhoto = ["1.png", "2.png", "3.png","4.png"];
        arrBtnTitle = ["Skip", "Skip","Skip", "Start"];

        self.dataSource = self
        self.setViewControllers([getViewControllerAtIndex(index: 0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
   
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        var index = pageContent.pageIndex
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        index -= 1;
        return getViewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        var index = pageContent.pageIndex
        if (index == NSNotFound)
        {
            return nil;
        }
        index += 1;
        if (index == arrPageTitle.count)
        {
            return nil;
        }
        return getViewControllerAtIndex(index: index)
    }
    
    
    func getViewControllerAtIndex(index: NSInteger) -> PageContentViewController
    {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController
        pageContentViewController.strTitle = "\(arrPageTitle[index])"
        pageContentViewController.strPhotoName = "\(arrPagePhoto[index])"
        pageContentViewController.strBtnTitle = "\(arrBtnTitle[index])"
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return arrPageTitle.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

    
}
