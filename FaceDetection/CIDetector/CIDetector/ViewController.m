//
//  ViewController.m
//  CIDetector
//
//  Created by Chauyan Wang on 9/22/16.
//  Copyright © 2016 upshotech. All rights reserved.
//

#import "ViewController.h"
#import <ImageIO/ImageIO.h>


#define mainScreen [UIScreen mainScreen].bounds
#define viewWidth 250
#define imageViewHeight 406
#define labelHeight 30
#define buttonHeight 40


@interface ViewController () {
    UIImageView *hunmanImageView;
    UILabel *faceNumbers;
    UIButton *checkButton;
    
    UIImage *hunmanImage;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    hunmanImage = [UIImage imageNamed:@"face1.jpg"];
    hunmanImageView = [[UIImageView alloc] initWithFrame:CGRectMake((mainScreen.size.width - viewWidth)/2, 30, viewWidth, imageViewHeight)];
    [hunmanImageView setImage:hunmanImage];
    
    faceNumbers = [[UILabel alloc] initWithFrame:CGRectMake((mainScreen.size.width - viewWidth)/2, hunmanImageView.frame.size.height + 40, viewWidth, labelHeight)];
    [faceNumbers setTextColor:[UIColor blackColor]];
    [faceNumbers setText:@"How many faces : "];
    
    checkButton = [[UIButton alloc] initWithFrame:CGRectMake((mainScreen.size.width - viewWidth)/2, mainScreen.size.height - 60, viewWidth, buttonHeight)];
    [checkButton addTarget:self action:@selector(checkHumanFace:) forControlEvents:UIControlEventTouchUpInside];
    [checkButton setBackgroundColor:[UIColor grayColor]];
    [checkButton setTitle:@"check faces" forState:UIControlStateNormal];
    
    [self.view addSubview:hunmanImageView];
    [self.view addSubview:faceNumbers];
    [self.view addSubview:checkButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma make - 
#pragma IBActions
- (IBAction) checkHumanFace:(id)sender {
    // check faces
    [self checkFaces];
}


#pragma mark -
#pragma mark private functions 
- (void) checkFaces {
    
    CIContext *context = [CIContext context];
    NSDictionary *opts = @{ CIDetectorAccuracy : CIDetectorAccuracyHigh };
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:context
                                              options:opts];
    CIImage *rawImage = [CIImage imageWithCGImage:hunmanImage.CGImage];
    NSArray *features = [detector featuresInImage:rawImage options:opts];
    
    CGSize imageViewSize = hunmanImageView.bounds.size;
    CGSize rawImageSize = rawImage.extent.size;
    CGAffineTransform transform = CGAffineTransformMakeScale(1, -1);
    transform = CGAffineTransformTranslate(transform, 0, -rawImageSize.height);
    
    
    for ( CIFaceFeature *faceFeature in features) {
        
        // transform to correct position
        CGRect faceRect = CGRectApplyAffineTransform(faceFeature.bounds, transform);
        
        // calculate correct size
        
        float scale = MIN(imageViewSize.width/rawImageSize.width,
                              imageViewSize.height/rawImageSize.height);
        float offsetX = (imageViewSize.width - rawImageSize.width * scale) / 2;
        float offsetY = (imageViewSize.height - rawImageSize.height * scale) / 2;
        
        faceRect = CGRectApplyAffineTransform(faceRect, CGAffineTransformMakeScale(scale, scale));
        faceRect.origin.x += offsetX;
        faceRect.origin.y += offsetY;
        
        UIView *faceView = [[UIView alloc] initWithFrame:faceRect];
        faceView.layer.borderColor = [UIColor redColor].CGColor;
        faceView.layer.borderWidth = 1.4;
        
        [hunmanImageView addSubview:faceView];
    }
    
    [faceNumbers setText:[NSString stringWithFormat:@"How many faces : %d", (int) features.count]];
}

@end
