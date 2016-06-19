
(ns topic-tag.component.user
  (:require [hsl.core :refer [hsl]]
            [respo.alias :refer [create-comp img span div]]
            [topic-tag.component.space :refer [component-space]]))

(defn render [user]
  (fn [state mutate]
    (div
      {:style
       {:background-color (hsl 0 0 86),
        :padding "4px 8px",
        :display "inline-block",
        :margin "0 8px 8px 0"}}
      (img
        {:style
         {:vertical-align "middle", :width "32px", :height "32px"},
         :attrs {:src (:avatar user)}})
      (component-space "8px" 0)
      (span
        {:style {:vertical-align "middle", :font-size "20px"},
         :attrs {:inner-text (:name user)}}))))

(def component-user (create-comp :user render))
