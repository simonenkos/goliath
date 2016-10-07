module Render where

import Model
import Config

import Data.Maybe
import Data.Set hiding (map)

import Graphics.Gloss.Data.Picture
import Graphics.Gloss.Data.Color

render :: Field -> Picture
render = pictures . map renderCell . toList . cells

renderCell :: Cell -> Picture
renderCell cell | isAlive cell == 1 = color blue  rect
                | otherwise         = color black rect
                where
                    rect = translate xPos yPos (rectangleSolid xPadSize yPadSize)
                    --
                    xPos = xCellPos * xCellSize + cellPadding - xPlotSize / 2
                    yPos = yCellPos * yCellSize + cellPadding - yPlotSize / 2
                    xPadSize = xCellSize - cellPadding
                    yPadSize = yCellSize - cellPadding
                    --
                    xCellPos  = fromIntegral $ xNumber cell :: Float
                    yCellPos  = fromIntegral $ yNumber cell :: Float
                    xCellSize = fromIntegral $ fst cellSize :: Float
                    yCellSize = fromIntegral $ snd cellSize :: Float
                    xPlotSize = fromIntegral $ fst plotSize :: Float
                    yPlotSize = fromIntegral $ snd plotSize :: Float