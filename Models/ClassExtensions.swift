//
//  ClassExtensions.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/19/20.
//

import Foundation
import UIKit
import ImageIO

extension UIColor {
    static var deepSeaBlue: UIColor {
        return UIColor(displayP3Red: 37/255, green: 92/255, blue: 153/255, alpha: 1.0)
    }
    static var seaFoamBlue: UIColor {
        return UIColor(displayP3Red: 8/255, green: 178/255, blue: 227/255, alpha: 1.0)
    }
    static var goldenSun: UIColor {
        return UIColor(displayP3Red: 249/255, green: 220/255, blue: 92/255, alpha: 1.0)
    }
    static var urchintPurple: UIColor {
        return UIColor(displayP3Red: 134/255, green: 22/255, blue: 187/255, alpha: 1.0)
    }
    static var coralRed: UIColor {
        return UIColor(displayP3Red: 168/255, green: 32/255, blue: 26/255, alpha: 1.0)
    }
    static var gameplayBlue: UIColor {
        return UIColor(displayP3Red: 64/255, green: 154/255, blue: 212/255, alpha: 1.0)
    }
    static var starCommandBlue: UIColor {
        return UIColor(displayP3Red: 0/255, green: 124/255, blue: 190/255, alpha: 1.0)
    }
    static var mediumTurqouise: UIColor {
        return UIColor(displayP3Red: 117/255, green: 221/255, blue: 221/255, alpha: 1.0)
    }
    static var middlePurple: UIColor {
        return UIColor(displayP3Red: 206/255, green: 132/255, blue: 173/255, alpha: 1.0)
    }
    static var byzantiumPurple: UIColor {
        return UIColor(displayP3Red: 122/255, green: 48/255, blue: 108/255, alpha: 1.0)
    }
    static var ceriseRed: UIColor {
        return UIColor(displayP3Red: 209/255, green: 52/255, blue: 91/255, alpha: 1.0)
    }
    static var beauBlue: UIColor {
        return UIColor(displayP3Red: 196/255, green: 224/255, blue: 249/255, alpha: 1.0)
    }
    static var imperialRed: UIColor {
        return UIColor(displayP3Red: 255/255, green: 0/255, blue: 53/255, alpha: 1.0)
    }
    static var pastelGReen: UIColor {
        return UIColor(displayP3Red: 32/255, green: 191/255, blue: 85/255, alpha: 1.0)
    }
    static var purpleOrchid: UIColor {
        return UIColor(displayP3Red: 175/255, green: 43/255, blue: 191/255, alpha: 1.0)
    }
    static var peach: UIColor {
        return UIColor(displayP3Red: 255/255, green: 225/255, blue: 168/255, alpha: 1.0)
    }
    class func randomColor() -> UIColor {

           let hue = CGFloat(arc4random() % 100) / 100
           let saturation = CGFloat(arc4random() % 100) / 100
           let brightness = CGFloat(arc4random() % 100) / 100

           return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
       }
    
    //V2theme
    
    static var midnightPurps: UIColor {
        return UIColor(displayP3Red: 116/255, green: 0/255, blue: 184/255, alpha: 1.0)
    }
    static var roxyClubPurple: UIColor {
        return UIColor(displayP3Red: 105/255, green: 48/255, blue: 195/255, alpha: 1.0)
    }
    static var niceNight: UIColor {
        return UIColor(displayP3Red: 94/255, green: 96/255, blue: 1206/255, alpha: 1.0)
    }
    static var polarCapBlue: UIColor {
        return UIColor(displayP3Red: 83/255, green: 144/255, blue: 217/255, alpha: 1.0)
    }
    static var whaleBlue: UIColor {
        return UIColor(displayP3Red: 78/255, green: 168/255, blue: 222/255, alpha: 1.0)
    }
    
    static var sharkBlueGreen: UIColor {
        return UIColor(displayP3Red: 72/255, green: 191/255, blue: 227/255, alpha: 1.0)
    }
    static var sharkGreen: UIColor {
        return UIColor(displayP3Red: 86/255, green: 207/255, blue: 225/255, alpha: 1.0)
    }
    static var greenLandOcean: UIColor {
        return UIColor(displayP3Red: 100/255, green: 223/255, blue: 223/255, alpha: 1.0)
    }
    static var foamGreen: UIColor {
        return UIColor(displayP3Red: 114/255, green: 239/255, blue: 221/255, alpha: 1.0)
    }
    static var discoDayGReen: UIColor {
        return UIColor(displayP3Red: 128/255, green: 255/255, blue: 219/255, alpha: 1.0)
    }
    
}



extension UIImageView {

    public func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(name: name)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

    @available(iOS 9.0, *)
    public func loadGif(asset: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(asset: asset)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

}//For the circle cropped image
extension UIImage {
    var isPortrait:  Bool    { size.height > size.width }
    var isLandscape: Bool    { size.width > size.height }
    var breadth:     CGFloat { min(size.width, size.height) }
    var breadthSize: CGSize  { .init(width: breadth, height: breadth) }
    var breadthRect: CGRect  { .init(origin: .zero, size: breadthSize) }
    var circleMasked: UIImage? {
        guard let cgImage = cgImage?
                .cropping(to: .init(origin: .init(x: isLandscape ? ((size.width-size.height)/2).rounded(.down) : 0,
                                                  y: isPortrait  ? ((size.height-size.width)/2).rounded(.down) : 0),
                                    size: breadthSize)) else { return nil }
        let format = imageRendererFormat
        format.opaque = false
        return UIGraphicsImageRenderer(size: breadthSize, format: format).image { _ in
            UIBezierPath(ovalIn: breadthRect).addClip()
            UIImage(cgImage: cgImage, scale: format.scale, orientation: imageOrientation)
                .draw(in: .init(origin: .zero, size: breadthSize))
        }
    }
    
}

extension UIImage {
    
    public class func gifImageWithName(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }

        guard let imageData = NSData(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }

        return gifImageWithData(data: imageData)
    }
    public class func ImageWithName(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "png") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }

        guard let imageData = NSData(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }

        return gifImageWithData(data: imageData)
    }
    
    public class func gifImageWithData(data: NSData) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data, nil) else {
            print("image doesn't exist")
            return nil
        }

        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gif(data: Data) -> UIImage? {
        // Create source from data
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("SwiftGif: Source for the image does not exist")
            return nil
        }

        return UIImage.animatedImageWithSource(source)
    }

    public class func gif(url: String) -> UIImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            print("SwiftGif: This image named \"\(url)\" does not exist")
            return nil
        }

        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
            return nil
        }

        return gif(data: imageData)
    }

    public class func gif(name: String) -> UIImage? {
        // Check for existance of gif
        guard let bundleURL = Bundle.main
          .url(forResource: name, withExtension: "gif") else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }

        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }

        return gif(data: imageData)
    }

    @available(iOS 9.0, *)
    public class func gif(asset: String) -> UIImage? {
        // Create source from assets catalog
        guard let dataAsset = NSDataAsset(name: asset) else {
            print("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
            return nil
        }

        return gif(data: dataAsset.data)
    }

    internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        // Get dictionaries
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        defer {
            gifPropertiesPointer.deallocate()
        }
        let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
        if CFDictionaryGetValueIfPresent(cfProperties, unsafePointer, gifPropertiesPointer) == false {
            return delay
        }

        let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)

        // Get delay time
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }

        if let delayObject = delayObject as? Double, delayObject > 0 {
            delay = delayObject
        } else {
            delay = 0.1 // Make sure they're not too fast
        }
        return delay
    }

    internal class func gcdForPair(_ lhs: Int?, _ rhs: Int?) -> Int {
        var lhs = lhs
        var rhs = rhs
        // Check if one of them is nil
        if rhs == nil || lhs == nil {
            if rhs != nil {
                return rhs!
            } else if lhs != nil {
                return lhs!
            } else {
                return 0
            }
        }

        // Swap for modulo
        if lhs! < rhs! {
            let ctp = lhs
            lhs = rhs
            rhs = ctp
        }

        // Get greatest common divisor
        var rest: Int
        while true {
            rest = lhs! % rhs!
            if rest == 0 {
                return rhs! // Found it
            } else {
                lhs = rhs
                rhs = rest
            }
        }
    }

    internal class func gcdForArray(_ array: [Int]) -> Int {
        if array.isEmpty {
            return 1
        }
        var gcd = array[0]

        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        return gcd
    }

    internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        // Fill arrays
        for index in 0..<count {
            // Add image
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                images.append(image)
            }

            // At it's delay in cs
            let delaySeconds = UIImage.delayForImageAtIndex(Int(index),
                source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        // Calculate full duration
        let duration: Int = {
            var sum = 0

            for val: Int in delays {
                sum += val
            }
            return sum
            }()
        // Get frames
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()

        var frame: UIImage
        var frameCount: Int
        for index in 0..<count {
            frame = UIImage(cgImage: images[Int(index)])
            frameCount = Int(delays[Int(index)] / gcd)

            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        // Heyhey
        let animation = UIImage.animatedImage(with: frames,
            duration: Double(duration) / 1000.0)

        return animation
    }

}

extension UIDevice {
        var modelName: String {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            return identifier
        }
    }

extension Array where Element: Equatable {

    @discardableResult mutating func remove(object: Element) -> Bool {
        if let index = firstIndex(of: object) {
            self.remove(at: index)
            return true
        }
        return false
    }

    @discardableResult mutating func remove(where predicate: (Array.Iterator.Element) -> Bool) -> Bool {
        if let index = self.firstIndex(where: { (element) -> Bool in
            return predicate(element)
        }) {
            self.remove(at: index)
            return true
        }
        return false
    }

}

extension UILabel {
    func blink() {
        self.alpha = 0.0;
        UIView.animate(withDuration: 0.8, //Time duration you want,
            delay: 0.0,
            options: .repeat,
            animations: { [weak self] in self?.alpha = 1.0 },
            completion: { [weak self] _ in self?.alpha = 0.0 })
    }
    func blink2() {
      let animation = CABasicAnimation(keyPath: "opacity")
      animation.isRemovedOnCompletion = false
      animation.fromValue           = 1
      animation.toValue             = 0
      animation.duration            = 0.8
      animation.autoreverses        = true
      animation.repeatCount         = 3
      animation.beginTime           = CACurrentMediaTime() + 0.5
      self.layer.add(animation, forKey: nil)
      }
}
