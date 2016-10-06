module Render where

import Model
import Config

import Data.Maybe

import Graphics.Gloss.Data.Picture
import Graphics.Gloss.Data.Color

render :: Field -> Picture
render = pictures . mapMaybe renderCell

renderCell :: Cell -> Maybe Picture
renderCell cell | isAlive cell == 1 = Just (color blue $ translate xPos yPos (rectangleSolid xPadSize yPadSize))
                | otherwise         = Nothing
                where
                    --
                    xPos = xCellPos * xCellSize + cellPadding - xWindSize / 2
                    yPos = yCellPos * yCellSize + cellPadding - yWindSize / 2
                    xPadSize = xCellSize - cellPadding
                    yPadSize = yCellSize - cellPadding
                    --
                    xCellPos  = fromIntegral $ xNumber cell :: Float
                    yCellPos  = fromIntegral $ yNumber cell :: Float
                    xCellSize = fromIntegral $ fst cellSize :: Float
                    yCellSize = fromIntegral $ snd cellSize :: Float
                    xWindSize = fromIntegral $ fst windSize :: Float
                    yWindSize = fromIntegral $ snd windSize :: Float