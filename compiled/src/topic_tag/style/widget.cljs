
(ns topic-tag.style.widget
  (:require [hsl.core :refer [hsl]]))

(def textbox
 {:line-height 2,
  :box-shadow (str "0 0 1px " (hsl 0 0 40)),
  :font-size "16px",
  :width "100%",
  :padding "0 8px",
  :outline "none",
  :border "none"})

(def button
 {:line-height 2,
  :color "white",
  :font-size "14px",
  :background-color (hsl 200 80 50),
  :cursor "pointer",
  :padding "0 8px",
  :outline "none",
  :border "none"})

(def field-line {:padding "8px 16px"})

(def field-guide {:line-height 2, :color (hsl 0 0 50)})

(def toolbar
 {:align-items "flex-end",
  :padding "8px 16px",
  :justify-content "flex-end",
  :display "flex"})
