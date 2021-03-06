{-
Copyright 2015 SlamData, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-}

module Data.Inject1 where

import Prelude
import Data.Either (Either(..), either)
import Data.Maybe (Maybe(..))

class Inject1 a b where
  inj :: a -> b
  prj :: b -> Maybe a

instance inject1Reflexive :: Inject1 a a where
  inj = id
  prj = Just

instance inject1Left :: Inject1 a (Either a b) where
  inj = Left
  prj = either Just (const Nothing)

instance inject1Right :: (Inject1 a b) => Inject1 a (Either c b) where
  inj = Right <<< inj
  prj = either (const Nothing) prj
