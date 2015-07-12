module Icon (plugin) where

import Text.Pandoc
import Text.Pandoc.Builder
import Network.Gitit.Interface

plugin :: Plugin
plugin = PageTransform prepend

prepend :: Pandoc -> PluginM Pandoc
prepend doc@(Pandoc m blks) = do
    meta <- askMeta
    case lookup "icon" meta of
      Just s -> return $ Pandoc m (icon s <> blks)
      _      -> return doc

icon :: String -> [Block]
icon filePath = toList $ rawBlock "html" ("<img id='toc-icon' src='" ++ filePath ++ "' />")

