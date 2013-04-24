//
//  ViewController.m
//  readium-arc
//
//  Created by Vincent Daubry on 24/04/13.
//  Copyright (c) 2013 Youboox. All rights reserved.
//

#import "ViewController.h"
#import "RDContainer.h"
#import "RDPackage.h"
#import "RDSpineItem.h"
#import "SpineItemController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)awakeFromNib {
    NSString *resPath = [NSBundle mainBundle].resourcePath;
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    for (NSString *fileName in [fm contentsOfDirectoryAtPath:resPath error:nil]) {
        if ([fileName.lowercaseString hasSuffix:@".epub"]) {
            NSString *src = [resPath stringByAppendingPathComponent:fileName];
            NSString *dst = [docsPath stringByAppendingPathComponent:fileName];
            
            if (![fm fileExistsAtPath:dst]) {
                [fm copyItemAtPath:src toPath:dst error:nil];
            }
        }
    }

}


- (void)viewDidLoad
{
    [super viewDidLoad];
}


-(void)viewDidAppear:(BOOL)animated {
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    
    
    NSString *path =   [docsPath stringByAppendingPathComponent:@"childrens-literature-20120722.epub"];
    RDContainer* container = [[RDContainer alloc] initWithPath:path];
    RDPackage *currentPackage = [container.packages objectAtIndex:0];
    
    RDSpineItem *spineItem = [currentPackage.spineItems objectAtIndex:0];
	SpineItemController *c = [[SpineItemController alloc] initWithPackage:currentPackage spineItem:spineItem];
    c.delegate = self;
	[self presentViewController:c animated:YES completion:^{
        //
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
