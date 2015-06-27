module Proof (plugin) where

import Text.Pandoc.Builder
import Network.Gitit.Interface

plugin :: Plugin
plugin = mkPageTransformM transBlock

qed :: Blocks
qed = divWith ("", ["qed"], []) (fromList [])

transBlock :: Block -> PluginM Block
transBlock (Div (_, classes, _) contents)
    | "proof" `elem` classes = do
        let contents' = fromList contents
        let icon = rawBlock "html" "<button class='proof-icon plus'>+</button>"
        let header = icon <> divWith ("", ["header plus"], []) (plain $ (strong . emph . str) "Proof:")
        let pane = header <> divWith ("", ["pane hidden"], []) (contents' <> qed)
        return $ Div ("", ["proof"], []) (toList pane)
transBlock x = return x
