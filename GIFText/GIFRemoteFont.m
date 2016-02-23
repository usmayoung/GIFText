//
//  GIFRemoteFont.m
//  GIFTextView
//
//  Created by Eric Young on 2/1/16.
//  Copyright © 2016 Eric Young. All rights reserved.
//

#import "GIFRemoteFont.h"
#import <CoreText/CoreText.h>

AFHTTPSessionManager * LoadWebFont(NSString *family, NSString *uri, void (^completionBlock)(void),
                                     AFHTTPRequestFailureBlock failureBlock)
{
    if (!family || !uri) {
        completionBlock();
        return nil;
    }
    
    //NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:uri]];
    NSLog(@"Loading webfont: %@, uri: %@", family, uri);
    AFHTTPSessionManager *fontRequest = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:uri]];
    [fontRequest GET:@"" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        RegisterFont(responseObject);
        SaveFontData(responseObject, [NSString stringWithFormat:@"%@.%@", family, [uri pathExtension]]);
        
        if (completionBlock) {
            completionBlock();
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    return fontRequest;
    
}

AFHTTPSessionManager * SetWebFont(NSString *family, CGFloat fontSize, NSString *uri, void (^setBlock)(UIFont *font),
                                    AFHTTPRequestFailureBlock failureBlock)
{
    if (!family) {
        setBlock(nil);
        return nil;
    }
    
    UIFont *f = [UIFont fontWithName:family size:fontSize];
    
    if (f) {
        setBlock(f);
        
        return nil;
    } else {
        AFHTTPSessionManager *operation = LoadWebFont(family, uri, ^{
            UIFont *f = [UIFont fontWithName:family size:fontSize];
            setBlock(f);
        }, failureBlock);
        
        return operation;
    }
}

void RegisterFont(NSData *data)
{
    CFErrorRef error = NULL;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    CGFontRef font = CGFontCreateWithDataProvider(provider);
    
    
    if (! CTFontManagerRegisterGraphicsFont(font, &error)) {
        CFStringRef errorDescription = CFErrorCopyDescription(error);
        NSLog(@"Failed to load font: %@", errorDescription);
        CFRelease(errorDescription);
        CFRelease(error);
    }
    
    CFRelease(font);
    CFRelease(provider);
}

void SaveFontData(NSData *data, NSString *name)
{
    NSString *fontsFolder = DownloadedFontFolderPath();
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *fontFullPath = [NSString stringWithFormat:@"%@/%@", fontsFolder, name];
    [fm createFileAtPath:fontFullPath contents:data attributes:nil];
    
    NSLog(@"Saving font file: %@", fontFullPath);
}

NSString *DownloadedFontFolderPath()
{
    static NSString *path = nil;
    if (path == nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
        NSString *applicationSupportDirectory = [paths objectAtIndex:0];
        NSLog(@"Application Support2: %@", applicationSupportDirectory);
        path = [[applicationSupportDirectory stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] stringByAppendingPathComponent:@"Fonts"];
        
        NSFileManager *fm = [NSFileManager defaultManager];
        NSError *err;
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&err];
    }
    
    return path;
}

void LoadAllFontsFromDisk()
{
    // Shipped fonts
    //NSBundle *fontsBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"GIFFonts.bundle" ofType:nil]];
    NSArray *fonts = GetAllShippedFontsFromDisk();
    CTFontManagerRegisterFontsForURLs((__bridge CFArrayRef)(fonts), kCTFontManagerScopeNone, NULL);
    
    // Downloaded fonts
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *fontsFolder = DownloadedFontFolderPath();
    
    NSArray *fontFiles = [fm subpathsAtPath:fontsFolder];
    
    NSMutableArray *fontURLs = [NSMutableArray arrayWithCapacity:20];
    for (NSString *filename in fontFiles) {
        [fontURLs addObject:[NSURL fileURLWithPath:[fontsFolder stringByAppendingPathComponent:filename]]];
    }
    
    CTFontManagerRegisterFontsForURLs((__bridge CFArrayRef)(fontURLs), kCTFontManagerScopeNone, NULL);
    
}

NSArray *GetAllShippedFontsFromDisk()
{
    NSBundle *fontsBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"GIFFonts.bundle" ofType:nil]];
    NSArray *fonts = [fontsBundle URLsForResourcesWithExtension:@".ttf" subdirectory:nil];
    return fonts;
}
