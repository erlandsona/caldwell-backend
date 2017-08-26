{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}

module Handler.Home where

import Yesod.Core.Widget (whamlet)

import Import

getHomeR :: Handler Html
getHomeR = do
    defaultLayout $ do
        setTitle "Caldwell"
        addStylesheet $ StaticR fonts_font_awesome_4_7_0_css_font_awesome_min_css
        addScript $ StaticR js_union_types_union_type_js
        $(widgetFile "homepage/_")


socialLink :: Text -> Text -> Text -> Widget
socialLink siteDomain userName icon = [whamlet|
<a href="https://www.#{siteDomain}.com/#{userName}" target="_blank" rel="noopener">
    <i class="fa fa-#{icon}" aria-hidden="true">
|]

hpNavA :: Text -> Widget
hpNavA text = [whamlet|
<a.homepage-Nav_a>
    <span.homepage-Nav_span>
        #{text}
|]
