{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import qualified GI.Gtk as Gtk
import qualified Data.Text as T
import System.Directory
import System.Process
import System.Posix.User

main :: IO ()
main = do
  Gtk.init Nothing
  
  -- the only window of the app
  win <- Gtk.windowNew Gtk.WindowTypeToplevel
  Gtk.setContainerBorderWidth win 10
  Gtk.setWindowTitle win (T.pack "Log Out")
  Gtk.setWindowResizable win False
  Gtk.setWindowDefaultWidth win 750
  Gtk.setWindowDefaultHeight win 225
  Gtk.setWindowWindowPosition win Gtk.WindowPositionCenter
  Gtk.windowSetDecorated win False 
  
  home <- getHomeDirectory 
  user <- getEffectiveUserName
  
  let cdevDir = "/Documents/Dev/Haskell/logouter/img/"
  
  -- images
  img1 <- Gtk.imageNewFromFile $ home ++ cdevDir ++ "cancel.png"
  img2 <- Gtk.imageNewFromFile $ home ++ cdevDir ++ "logout.png"
  img3 <- Gtk.imageNewFromFile $ home ++ cdevDir ++ "reboot.png"
  img4 <- Gtk.imageNewFromFile $ home ++ cdevDir ++ "shutdown.png"
  img5 <- Gtk.imageNewFromFile $ home ++ cdevDir ++ "suspend.png"
  img6 <- Gtk.imageNewFromFile $ home ++ cdevDir ++ "hibernate.png"
  img7 <- Gtk.imageNewFromFile $ home ++ cdevDir ++ "lock.png"

  
  -- labels
  label1 <- Gtk.labelNew Nothing
  Gtk.labelSetMarkup label1 "<b>ሰርዝ</b>"
  label2 <- Gtk.labelNew Nothing
  Gtk.labelSetMarkup label2 "<b>ውጣ</b>"
  label3 <- Gtk.labelNew Nothing
  Gtk.labelSetMarkup label3 "<b>ክፈት</b>"
  label4 <- Gtk.labelNew Nothing
  Gtk.labelSetMarkup label4 "<b>ጠርቅመው</b>"
  label5 <- Gtk.labelNew Nothing
  Gtk.labelSetMarkup label5 "<b>አፍዝዘው</b>"
  label6 <- Gtk.labelNew Nothing
  Gtk.labelSetMarkup label6 "<b>አስተኛው</b>"
  label7 <- Gtk.labelNew Nothing
  Gtk.labelSetMarkup label7 "<b>ቀርቅረው</b>"

  -- buttons 
  btn1 <- Gtk.buttonNew 
  Gtk.buttonSetRelief btn1 Gtk.ReliefStyleNone
  Gtk.buttonSetImage btn1 $ Just img1 
  Gtk.widgetSetHexpand btn1 False
  Gtk.on btn1 #clicked $ do
    
  btn2 <- Gtk.buttonNew 
  Gtk.buttonSetRelief btn2 Gtk.ReliefStyleNone
  Gtk.buttonSetImage btn2 $ Just img2 
  Gtk.widgetSetHexpand btn2 False
  Gtk.on btn2 #clicked $ do
    callCommand $ "pKill -u " ++ user

  btn3 <- Gtk.buttonNew 
  Gtk.buttonSetRelief btn3 Gtk.ReliefStyleNone
  Gtk.buttonSetImage btn3 $ Just img3 
  Gtk.widgetSetHexpand btn3 False
  Gtk.on btn3 #clicked $ do
    callCommand "reboot"

  btn4 <- Gtk.buttonNew 
  Gtk.buttonSetRelief btn4 Gtk.ReliefStyleNone
  Gtk.buttonSetImage btn4 $ Just img4 
  Gtk.widgetSetHexpand btn4 False
  Gtk.on btn4 #clicked $ do
    callCommand "shutdown -h now"

  btn5 <- Gtk.buttonNew 
  Gtk.buttonSetRelief btn5 Gtk.ReliefStyleNone
  Gtk.buttonSetImage btn5 $ Just img5 
  Gtk.widgetSetHexpand btn5 False
  Gtk.on btn5 #clicked $ do
    

  btn6 <- Gtk.buttonNew 
  Gtk.buttonSetRelief btn6 Gtk.ReliefStyleNone
  Gtk.buttonSetImage btn6 $ Just img6 
  Gtk.widgetSetHexpand btn6 False
  Gtk.on btn6 #clicked $ do

  btn7 <- Gtk.buttonNew 
  Gtk.buttonSetRelief btn7 Gtk.ReliefStyleNone
  Gtk.buttonSetImage btn7 $ Just img7 
  Gtk.widgetSetHexpand btn7 False
  Gtk.on btn7 #clicked $ do
    callCommand "xdg-screensaver lock"
       
  -- create a grid
  grid <- Gtk.gridNew
  Gtk.gridSetColumnSpacing grid 10
  Gtk.gridSetRowSpacing grid 10
  Gtk.gridSetColumnHomogeneous grid True 
  
  -- four values: row number, column number, row span and column span
  #attach grid btn1   0 0 1 1
  #attach grid label1 0 1 1 1
  #attach grid btn2   1 0 1 1
  #attach grid label2 1 1 1 1
  #attach grid btn3   2 0 1 1
  #attach grid label3 2 1 1 1
  #attach grid btn4   3 0 1 1
  #attach grid label4 3 1 1 1
  #attach grid btn5   4 0 1 1
  #attach grid label5 4 1 1 1
  #attach grid btn6   5 0 1 1
  #attach grid label6 5 1 1 1
  #attach grid btn7   6 0 1 1
  #attach grid label7 6 1 1 1
  
  #add win grid 
  
  Gtk.onWidgetDestroy win Gtk.mainQuit 
  
  #showAll win
  Gtk.main
