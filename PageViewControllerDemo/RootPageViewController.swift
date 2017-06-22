//
//  RootPageViewController.swift
//  PageViewControllerDemo
//
//  Created by Rui Mao on 6/19/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class RootPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var viewControllerLists: [UIViewController] = {
        
        let sb = UIStoryboard(name: "Main" , bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "profileVC")
        let vc2 = sb.instantiateViewController(withIdentifier: "groupVC")
        let vc3 = sb.instantiateViewController(withIdentifier: "requestVC")
        let vc4 = sb.instantiateViewController(withIdentifier: "scheduleVC")
        let vc5 = sb.instantiateViewController(withIdentifier: "chatVC")
        
        return [vc1, vc2, vc3, vc4, vc5]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        
        if let firstViewController = viewControllerLists.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerLists.index(of: viewController) else {return nil}
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard viewControllerLists.count > previousIndex else {return nil}
        return viewControllerLists[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerLists.index(of: viewController) else {return nil}
        let nextIndex = vcIndex + 1
        guard viewControllerLists.count != nextIndex else {return nil}
        guard viewControllerLists.count > nextIndex else {return nil}
        return viewControllerLists[nextIndex]
    }
    
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.darkGray
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        setupPageControl()
        return self.viewControllerLists.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    /*func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return viewControllerLists.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
 */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
