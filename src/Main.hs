module Main where

import Graphics.Gloss.Interface.Pure.Simulate

import Model
import Config

main :: IO ()
main =
  simulate display bgColor fps initialModel render update
  where
     display = InWindow "Game Of Life" windSize (100, 100)
     bgColor = black
     fps     = 60

     initialModel           = makeField windSize cellSize
     render           model = color red (text "Hello!")
     update view step model = model
