module Render where

import Model
import Config

import Data.Maybe

import Graphics.Gloss.Data.Picture
import Graphics.Gloss.Data.Color

render :: Field -> Picture
render = pictures . mapMaybe renderCell

-- render = pictures . map (\cell -> color blue (rectangleSolid (xCellPos cell) (yCellPos cell)))
--     where xCellPos cell = fromIntegral (x cell) * fromIntegral (fst cellSize)
--           yCellPos cell = fromIntegral (y cell) * fromIntegral (snd cellSize)

renderCell :: Cell -> Maybe Picture
renderCell cell | isAlive cell == 1 = Just (translate xPos yPos (rectangleSolid xSize ySize))
                | otherwise         = Nothing
                where
                    xPos = xPosition cell + cellPadding
                    yPos = yPosition cell + cellPadding
                    xSize = ((fromIntegral $ fst cellSize) :: Float) - padding
                    ySize = ((fromIntegral $ snd cellSize) :: Float) - padding
                    padding = cellPadding * 2