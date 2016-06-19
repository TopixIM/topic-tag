
(ns topic-tag.component.tag-select
  (:require [hsl.core :refer [hsl]]
            [respo.alias :refer [create-comp div span]]))

(defn render [tag resolve-select]
  (fn [state mutate]
    (div
      {:style
       {:color "white",
        :background-color (hsl 200 80 80),
        :cursor "pointer",
        :padding "0px 8px",
        :display "inline-block",
        :margin "0 8px 8px 0"}}
      (span
        {:event {:click resolve-select},
         :attrs {:inner-text (:text tag)}}))))

(def component-tag-select (create-comp :tag-select render))
