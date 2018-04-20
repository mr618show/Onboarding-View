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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 40)
        return label
    }()
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.bodyLabel])
    lazy var content: [(title: String, description: String)] = [
        ("Welcome to Gratitudine", "Your everyday personal gratitude journal" ),
        ("Customize your own journal book", "Tired of looking at the same background everyday? Try our custom themes that match your mood everyday!🌈"),
        ("Safty is important", "Now you can set up a password or using touchID to make your journal private 🔐"),
        ("Have questions?","We are here to help! 🙋‍♂️🙋 In the meantime we welcome all the suggestion that will make Gratitudine better."),
        ("We are grateful", "Thanks so much for downloading our app and giving us a try. Make sure to leave us a good review in the AppStore!❤️")
    ]
    
    private var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        setupGestures()
        setupLabels(withPage: currentPage)
        if let firstViewController = viewControllerLists.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerLists.index(of: viewController) else {return nil}
        setupLabels(withPage: currentPage)
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard viewControllerLists.count > previousIndex else {return nil}
        return viewControllerLists[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerLists.index(of: viewController) else {return nil}
        setupLabels(withPage: currentPage)
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
    
    fileprivate func setupLabels(withPage page: Int){
        let appearance = UIPageControl.appearance()
        appearance.currentPage = page
        titleLabel.text = content[page].title
        bodyLabel.text = content[page].description
        titleLabel.numberOfLines = 0
        bodyLabel.numberOfLines = 0
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        if !stackView.isDescendant(of: view){
            view.addSubview(stackView)
        }
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -120).isActive = true
        self.view.layoutIfNeeded()
        
    }
    func setupGestures(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimations))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func handleTapAnimations(){
        //first animation
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.titleLabel.alpha = 0.8
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -550)
            }, completion: nil)
        }
        //second animation
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.bodyLabel.alpha = 0.8
            self.bodyLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.bodyLabel.alpha = 0
                self.bodyLabel.transform = CGAffineTransform(translationX: 0, y: -550)
            }, completion: { _ in
                self.stackView.removeFromSuperview()
                self.titleLabel.alpha = 1
                self.titleLabel.transform = .identity
                self.bodyLabel.alpha = 1
                self.bodyLabel.transform = .identity
                self.currentPage += 1
//                if self.currentPage < self.content.count {
//                    self.setupLabels(withPage: self.currentPage)
//                }
            })
        }
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        setupPageControl()
        return self.viewControllerLists.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
