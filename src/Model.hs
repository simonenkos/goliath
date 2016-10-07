{-# LANGUAGE ScopedTypeVariables #-}

module Model where

import Control.Monad.Random
import Control.Monad

import Data.Set

import Config

data Cell = Cell { xNumber :: Int,
                   yNumber :: Int,
                   isAlive :: Int } deriving (Show, Eq)

instance Ord Cell where
    cella <= cellb = (xNumber cella == xNumber cellb && yNumber cella == yNumber cellb) ||
                     (xNumber cella == xNumber cellb && yNumber cella  < yNumber cellb) ||
                     (xNumber cella  < xNumber cellb && yNumber cella == yNumber cellb) ||
                     (xNumber cella  < xNumber cellb && yNumber cella  < yNumber cellb)


data Field = Field { cells :: Set Cell,
                     xMax  :: Int,
                     yMax  :: Int } deriving Show

makeField :: MonadRandom m => m Field
makeField = fmap constructor $ sequence $ generateCells xCount yCount where
    xCount = div (fst plotSize) $ fst cellSize
    yCount = div (snd plotSize) $ snd cellSize
    constructor cells = Field (Data.Set.fromList cells) xCount yCount

generateCells :: MonadRandom m => Int -> Int -> [m Cell]
generateCells xCount yCount = do
    x <- [0 .. xCount]
    y <- [0 .. yCount]
    return (makeCell x y)

makeCell :: MonadRandom m => Int -> Int -> m Cell
makeCell x y = fmap (cellConstructor . aliveFunction) getRandom where
    aliveFunction seed = mod seed seedDivisor
    cellConstructor = Cell x y

update :: Field -> Float -> Field
update model step = model
