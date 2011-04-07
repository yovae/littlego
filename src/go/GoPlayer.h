// -----------------------------------------------------------------------------
// Copyright 2011 Patrick Näf (herzbube@herzbube.ch)
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


// -----------------------------------------------------------------------------
/// @brief The GoPlayer class represents one of the two players of a Go game.
///
/// @ingroup go
// -----------------------------------------------------------------------------
@interface GoPlayer : NSObject
{
}

+ (GoPlayer*) blackPlayer;
+ (GoPlayer*) whitePlayer;

/// @brief The color taken by this GoPlayer object.
@property(getter=isBlack) bool black;
/// @brief True if this GoPlayer represents a human player, false if it
/// represents a computer player.
@property(getter=isHuman) bool human;
/// @brief The player's name. This is displayed in the GUI.
@property(retain) NSString* name;

@end