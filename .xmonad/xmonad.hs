import XMonad

main :: IO ()
main = do
     xmproc0 <- spawnPipe "polybar top"
     xmonad defaultConfig
        { modMask = mod4Mask -- Use Super instead of Alt
        , terminal = "st"
        -- more changes
        }
