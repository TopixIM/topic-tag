
(ns topic-tag.component.space
  (:require [respo.alias :refer [create-comp div]]))

(defn render [w h]
  (fn [state mutate]
    (div
      {:style
       {:vertical-align "middle",
        :-webkit-flex-grow 0,
        :flex-grow 0,
        :width (or w "100%"),
        :flex-shrink 0,
        :-webkit-flex-shrink 0,
        :display (if (some? w) "inline-block" "block"),
        :height (or h "1em")}})))

(def component-space (create-comp :space render))
