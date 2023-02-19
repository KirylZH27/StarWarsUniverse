//
//  TabBarController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 6.02.23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

   //     self.ChangeRadiusOfTabbar()
    }
    
/*    func ChangeRadiusOfTabbar(){
        
            self.tabBar.layer.masksToBounds = true
            self.tabBar.isTranslucent = true
            self.tabBar.layer.cornerRadius = 40
            self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    */
 /*   func ChangeHeightOfTabbar(){
       
           if UIDevice().userInterfaceIdiom == .phone {
               var tabFrame            = tabBar.frame
               tabFrame.size.height    = 100
               tabFrame.origin.y       = view.frame.size.height - 100
               tabBar.frame            = tabFrame
           }
    }
  */
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      //  self.ChangeHeightOfTabbar()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.SimpleAnnimationWhenSelectItem(item)
    }
    
    func SimpleAnnimationWhenSelectItem(_ item: UITabBarItem){
            guard let barItemView = item.value(forKey: "view") as? UIView else { return }

            let timeInterval: TimeInterval = 0.5
            let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.4, y: 1.4)
            }
            propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
            propertyAnimator.startAnimation()
    }
}
