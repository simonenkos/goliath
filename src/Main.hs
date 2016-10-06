module Main where

import Graphics.Gloss.Interface.IO.Simulate

import Model
import Render
import Config

main :: IO ()
main = do
    initialModel <- makeField
    simulateIO display bgColor fps initialModel renderModel updateModel
    where
        display = InWindow "Game Of Life" windSize (100, 100)
        bgColor = black
        fps     = 30

        renderModel model     = return (render model)
        updateModel view step = return
