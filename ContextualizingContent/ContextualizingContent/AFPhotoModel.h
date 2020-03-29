//
//  AFPhotoModel.h
//  ContextualizingContent
//
//  Created by HePing on 2020/3/29.
//  Copyright © 2020 何平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AFPhotoModel : NSObject
@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong) UIImage* iamge;

+ (instancetype)photoModelWithName:(NSString*)name image:(UIImage*)image;
@end

extern const NSUInteger AFSelectionModelNoSelectionIndex;

@interface AFSelectionModel : NSObject
@property (nonatomic, strong, readonly) NSArray *photoModels;
@property (nonatomic, assign) NSInteger selectedPhotoModelIndex;
@property (nonatomic, readonly) BOOL hasBeenSelected;

+ (instancetype)selectionModelWithPhotoModels:(NSArray *)photoModels;
@end
