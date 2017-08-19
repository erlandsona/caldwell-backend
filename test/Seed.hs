{-# LANGUAGE NoImplicitPrelude, OverloadedStrings #-}

import Import
import Model
import Control.Monad.Logger (runStderrLoggingT)
import Database.Persist.Postgresql (pgConnStr, withPostgresqlConn, runSqlConn, rawExecute)

austin = Account "Austin Erlandson" (Just "password")
emily = Account "Emily Kroll" (Just "password")

-- emails :: [Email]
emails =
    [ Email "austin@erlandson.com"
    , Email "krollemily@ymail.com"
    ]

main :: IO ()
main = do
    settings <- loadYamlSettingsArgs [configSettingsYmlValue] useEnv
    let conn = (pgConnStr $ appDatabaseConf settings)
    runStderrLoggingT . withPostgresqlConn conn $ runSqlConn $ do
        runMigration migrateAll
        austinId <- insert austin
        emilyId <- insert emily
        mapM_ insert_ $ zipWith (($)) (zipWith (($)) emails [austinId, emilyId]) [Nothing, Nothing]
