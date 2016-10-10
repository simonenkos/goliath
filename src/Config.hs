module Config where

cellSize = (5,   5)   :: (Int, Int)
plotSize = (500, 500) :: (Int, Int)

cellPadding = 0.5 :: Float
seedDivisor = 10  :: Int

neighbours x y = [(x - 1, y + 1), (x, y + 1), (x + 1, y + 1),
                  (x - 1, y    ),             (x + 1, y    ),
                  (x - 1, y - 1), (x, y - 1), (x + 1, y - 1)]
