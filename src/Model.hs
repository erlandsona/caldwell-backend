{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module Model where

import ClassyPrelude.Yesod
import Database.Persist.Sql

-- You can define all of your database entities in the entities file.
-- You can find more information on persistent and how to declare entities
-- at:
-- http://www.yesodweb.com/book/persistent/
share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|

Account
    -- This is a name field
    identifier Text
    password Text Maybe
    UniqueAccount identifier
    deriving Typeable

Email
    email Text
    accountId AccountId
    verkey Text Maybe
    UniqueEmail email
    deriving Show

Comment json -- Adding "json" causes ToJSON and FromJSON instances to be derived.
    message Text
    accountId AccountId Maybe
    deriving Eq Show


Gig json
    date UTCTime
    venueId VenueId
    deriving Eq Show

Venue json
    name Text
    -- Consider adding for Maps or something.
    -- street Text
    -- city Text
    -- state Text
    -- zip Integer
    deriving Show


 -- By default this file is used in Model.hs (which is imported by Foundation.hs)
|]
