//
//  ElementsDetailViewTableViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/8/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "ElementsDetailViewTableViewController.h"


@interface ElementsDetailViewTableViewController ()
@property (nonatomic) NSMutableArray *favorites;

@end

@implementation ElementsDetailViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.detailNavItem.title = self.name;
    self.guidelinesTitle.text = self.guidelines;
    [self formatTextData];
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"%@", self.elementDetail);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }else if (section ==1) {
        return 1;
    }else if (section ==2){
        return 1;
    }else{
        return 1;
    }
}
- (IBAction)handleCloseButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)formatTextData{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@"];
    NSArray *outcomesArray = [self.desiredOutcomes componentsSeparatedByCharactersInSet:set];
    if (outcomesArray.count >2) {
        NSString * outcomesString = [outcomesArray componentsJoinedByString:@" - "];
        self.desiredOutcomesTitle.text = outcomesString;
    }else{
        NSString *originalString = [outcomesArray componentsJoinedByString:@" "];
        self.desiredOutcomesTitle.text = originalString;
    }
    
    
    NSArray *variationsArray = [self.variations componentsSeparatedByString:@"@"];
    NSString * variationsString = [variationsArray componentsJoinedByString:@".\n"];
    self.variationsTitle.numberOfLines = variationsArray.count*2;
    self.variationsTitle.text = variationsString;
    
   
    NSArray *questionsArray = [self.reflectionQuestions componentsSeparatedByString:@"?"];
    NSString * questionsString = [questionsArray componentsJoinedByString:@"?\n"];
    self.reflectionQuestionsTitle.numberOfLines = questionsArray.count*2;
    self.reflectionQuestionsTitle.text = questionsString;
    
}

-(void)scrollViewDidScroll: (UIScrollView*)scrollView
{
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    
    if (scrollOffset == 0)
    {
        NSLog(@"We are at the top");
    }
    else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
    {
        // then we are at the end
        NSLog(@"We are at the bottom");
    }
}


@end
