//
//  Button_.swift
//  Switiflities
//
//  Created by Yariv on 1/23/15.
//  Copyright (c) 2015 Yariv. All rights reserved.
//

import UIKit

class UIButton_: UIButton {
  
  override func tintColorDidChange() {
    updateImage()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    updateImage()
  }
  
  private func updateImage() {
    if let tintColor = tintColor {
      let normalImage = imageForState(.Normal)?.imageWithTint(tintColor, alpha: 0.3)
      let selectedImage = imageForState(.Selected)?.imageWithTint(tintColor, alpha: 0.3)
      
      // Make the button look like a UIBarButtonItem when highlighted
      setImage(normalImage, forState: .Normal | .Highlighted)
      setImage(selectedImage, forState: .Selected | .Highlighted)
    }
  }
}

private extension UIImage {
  
  func imageWithTint(color: UIColor, alpha: CGFloat) -> UIImage {
    let image = self.imageWithRenderingMode(.AlwaysTemplate)
    
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIBezierPath(rect: CGRect(origin: CGPointZero, size: size)).fill()
    image.drawAtPoint(CGPointZero, blendMode: kCGBlendModeDestinationIn, alpha: alpha)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
}
