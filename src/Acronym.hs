module Acronym (abbreviate) where

import Data.Char (toUpper, isUpper, isLower, isPunctuation, isLetter)

abbreviate :: String -> String
abbreviate xs = abbreviater Nothing xs ""

space :: Char
space = ' '

predicate :: Maybe Char -> Char -> Bool
predicate Nothing _ = True 
predicate (Just a) b = result
  where
    isASpace = a == space
    isBUpper = isUpper b
    isALower = isLower a
    isAPunctuation = isPunctuation a
    isBLetter = isLetter b
    isANotApostrophe = (==) False $ (==) a '\''
    result = isANotApostrophe && isBLetter && ((isBUpper && (isASpace || isALower)) || isASpace || isAPunctuation)

abbreviater :: Maybe Char -> String -> String -> String
abbreviater _ [] accumulation = accumulation
abbreviater previous [x] accumulation = result
  where
    _predicate = predicate previous x
    justX = Just x
    defaultResult = abbreviater justX [] accumulation
    upperX = toUpper x
    accumulationWithUpperX = accumulation ++ [upperX]
    result = case _predicate of
      True -> abbreviater justX [] accumulationWithUpperX
      False -> defaultResult
abbreviater previous (x:xs) accumulation = result
  where
    _predicate = predicate previous x
    justX = Just x
    defaultResult = abbreviater justX xs accumulation
    upperX = toUpper x
    accumulationWithUpperX = accumulation ++ [upperX]
    result = case _predicate of
      True -> abbreviater justX xs accumulationWithUpperX
      False -> defaultResult
