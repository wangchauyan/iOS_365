//
//  ViewController.m
//  UpNotificationCenter
//
//  Created by Chauyan Wang on 10/13/16.
//  Copyright © 2016 upshotech. All rights reserved.
//

#import "ViewController.h"
#import "UpNotificationCenter.h"

#define updateNotification @"updateNotification"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *updateLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[UpNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTextLabel) name:updateNotification object:nil];
    
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[UpNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) updateTextLabel {
    _updateLabel.text = @"I receive a notification !!";
}

- (IBAction)sendNotification:(id)sender {
    [[UpNotificationCenter defaultCenter] postNotificationName:updateNotification object:nil];
}

@end
