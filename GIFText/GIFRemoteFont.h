//
//  GIFRemoteFont.h
//  GIFTextView
//
//  Created by Eric Young on 2/1/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^AFHTTPRequestFailureBlock)(AFHTTPSessionManager *operation, NSError *error);


AFHTTPSessionManager * LoadWebFont(NSString *family, NSString *uri, void (^completionBlock)(void),
                                     AFHTTPRequestFailureBlock failureBlock);

/*
 * Returns nil if the font is already downloaded so that the setBlock is called immediately. Returns the underling
 * AFHTTPRequestOperation if it is being loaded from a remote server.
 */
AFHTTPSessionManager * SetWebFont(NSString *family, CGFloat fontSize, NSString *uri, void (^setBlock)(UIFont *font),
                                    AFHTTPRequestFailureBlock failureBlock);

void RegisterFont(NSData *data);
void SaveFontData(NSData *data, NSString *name);
void LoadAllFontsFromDisk();

NSArray *GetAllShippedFontsFromDisk();

NSString *DownloadedFontFolderPath();
