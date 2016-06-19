
(ns topic-tag.component.tag-rm
  (:require [hsl.core :refer [hsl]]
            [respo.alias :refer [create-comp div span]]
            [topic-tag.component.space :refer [component-space]]))

(defn render [tag resolve-remove]
  (fn [state mutate]
    (div
      {:style
       {:line-height 1.6,
        :color "white",
        :background-color (hsl 240 80 70),
        :padding "0px 8px",
        :display "inline-block",
        :margin "0 8px 8px 0"}}
      (span {:style {}, :attrs {:inner-text (:text tag)}})
      (component-space "8px" 0)
      (span
        {:style
         {:color (hsl 0 80 70), :font-size "12px", :cursor "pointer"},
         :event {:click resolve-remove},
         :attrs {:inner-text "rm"}}))))

(def component-tag-rm (create-comp :tag-rm render))
