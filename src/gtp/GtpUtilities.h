// -----------------------------------------------------------------------------
// Copyright 2011-2012 Patrick Näf (herzbube@herzbube.ch)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// -----------------------------------------------------------------------------


@class GtpEngineProfile;


// -----------------------------------------------------------------------------
/// @brief The GtpUtilities class is a container for various utility functions
/// related to the GTP module.
///
/// @ingroup gtp
///
/// All functions in GtpUtilities are class methods, so there is no need to
/// create an instance of GtpUtilities.
// -----------------------------------------------------------------------------
@interface GtpUtilities : NSObject
{
}

+ (void) submitCommand:(NSString*)commandString target:(id)aTarget selector:(SEL)aSelector waitUntilDone:(bool)wait;
+ (GtpEngineProfile*) activeProfile;
+ (void) setupComputerPlayer;
+ (void) startPondering;
+ (void) stopPondering;
+ (void) restorePondering;

@end
