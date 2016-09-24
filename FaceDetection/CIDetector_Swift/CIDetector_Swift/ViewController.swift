//
//  ViewController.swift
//  CIDetector_Swift
//
//  Created by Chauyan Wang on 9/24/16.
//  Copyright © 2016 upshotech. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    let viewWidth = 250
    let imageViewHeight = 406
    let labelHeight = 30
    let buttonHeight = 40
    
    let mainScreen = UIScreen.main.bounds
    
    var humanImage:UIImage?
    var humanImageView:UIImageView?
    var faceNumbers:UILabel?
    var checkButton:UIButton?

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        humanImage = UIImage(named: "face1.jpg");
        humanImageView = UIImageView(frame: CGRect(x: (Int(mainScreen.size.width) - viewWidth)/2, y: 30, width: viewWidth, height: imageViewHeight))
        
        humanImageView!.image = humanImage
        
        faceNumbers = UILabel(frame: CGRect(x: (Int(mainScreen.size.width) - viewWidth)/2, y: Int(humanImageView!.frame.size.height) + 40, width: viewWidth, height:labelHeight))
        faceNumbers!.text = "How many faces : "
        
        checkButton = UIButton(frame: CGRect(x: (Int(mainScreen.size.width) - viewWidth)/2, y: Int(mainScreen.size.height) - 60, width: viewWidth, height: buttonHeight))
        checkButton!.addTarget(self, action: #selector(checkHumanFace(_:)), for: UIControlEvents.touchUpInside)
        checkButton!.setTitle("Check Faces", for: UIControlState.normal)
        checkButton!.backgroundColor = UIColor.gray
        
        self.view.addSubview(humanImageView!)
        self.view.addSubview(faceNumbers!)
        self.view.addSubview(checkButton!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // IBActions 
    @IBAction func checkHumanFace (_ button : UIButton) {
        checkFaces()
    }
    
    private func checkFaces() {
        
        guard let rawImage = CIImage(image : humanImage!) else {
            return
        }
        
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let context  = CIContext()
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: accuracy)
        let features = detector!.features(in: rawImage)
        
        let rawImageSize = rawImage.extent.size
        let imageViewSize = humanImageView!.bounds.size
        var transform = CGAffineTransform.init(scaleX: 1, y: -1)
        
        transform = transform.translatedBy(x: 0, y: -rawImageSize.height)
        for faceFeature in features as! [CIFaceFeature] {
            
            var faceRect = faceFeature.bounds.applying(transform)
            
            let scale = min(imageViewSize.width/rawImageSize.width,
                            imageViewSize.height/rawImageSize.height)
            
            let offsetX = (imageViewSize.width - rawImageSize.width * scale)/2
            let offsetY = (imageViewSize.height - rawImageSize.height * scale)/2
            
            faceRect = faceRect.applying(CGAffineTransform.init(scaleX: scale, y: scale))
            faceRect.origin.x += offsetX
            faceRect.origin.y += offsetY
            
            let faceView = UIView(frame: faceRect)
            faceView.layer.borderColor = UIColor.red.cgColor
            faceView.layer.borderWidth = 1.4
            
            humanImageView?.addSubview(faceView)
        }
        
        faceNumbers!.text = "How many faces : \(features.count)"
    }
}

