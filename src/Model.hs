module Model where

data Cell = Cell { x :: Int, y :: Int, isAlive :: Bool } deriving Show

type Field = [Cell]

makeField :: (Int, Int) -> (Int, Int) -> Field
makeField (xFieldSize, yFieldSize) (xCellSize, yCellSize) =
    [ Cell x y False | x <- [0 .. xCount],
                       y <- [0 .. yCount] ] where
                       xCount = div xFieldSize xCellSize
                       yCount = div yFieldSize yCellSize