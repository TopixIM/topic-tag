
(ns topic-tag.component.topics
  (:require [hsl.core :refer [hsl]]
            [respo.alias :refer [create-comp div span button]]
            [topic-tag.style.widget :as widget]
            [topic-tag.component.topic-entry :refer [component-topic-entry]]))

(defn handle-add [simple-event dispatch]
  (dispatch :state/route :add-topic))

(defn render [topics]
  (fn [state mutate]
    (div
      {:style
       {:background-color (hsl 0 0 100),
        :width "100%",
        :height "100%"}}
      (div
        {:style widget/toolbar}
        (button
          {:style widget/button,
           :event {:click handle-add},
           :attrs {:inner-text "Add topic"}}))
      (div
        {:style {:display "flex", :flex-direction "column"}}
        (->>
          topics
          (sort
            (fn [topic-a topic-b]
              (compare (:time topic-a) (:time topic-b))))
          (map-indexed
            (fn [index topic] [(:id topic)
                               (div
                                 {:style {:order (inc index)}}
                                 (component-topic-entry topic))]))
          (into (sorted-map)))))))

(def component-topics (create-comp :topics render))
