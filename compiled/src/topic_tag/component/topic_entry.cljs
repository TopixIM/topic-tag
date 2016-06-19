
(ns topic-tag.component.topic-entry
  (:require [hsl.core :refer [hsl]]
            [respo.alias :refer [create-comp div span]]
            [topic-tag.component.tag-select :refer [component-tag-select]]
            [topic-tag.component.space :refer [component-space]]))

(defn handle-click [topic]
  (fn [simple-event dispatch]
    (dispatch :state/route [:chat-room (:id topic)])))

(defn handle-select [tag]
  (fn [simple-event dispatch]
    (dispatch :state/route [:topics (:id tag)])))

(defn render [topic]
  (fn [state mutate]
    (div
      {:style
       {:line-height 2,
        :cursor "pointer",
        :padding "6px 16px",
        :border-bottom (str "1px solid " (hsl 0 0 90))},
       :event {:click (handle-click topic)}}
      (span
        {:attrs
         {:inner-text
          (let [text (:text topic)]
            (if (> (count text) 0) text "[empty]"))}})
      (component-space "16px" nil)
      (span
        {:style
         {:color "white",
          :background-color (hsl 0 60 80),
          :padding "0 8px",
          :border-radius "8px"},
         :attrs {:inner-text (:messages-count topic)}})
      (component-space "16px" nil)
      (div
        {:style {:display "inline-block"}}
        (->>
          (:tags topic)
          (map
            (fn [tag] [(:id tag)
                       (component-tag-select
                         tag
                         (handle-select tag))]))
          (into (sorted-map)))))))

(def component-topic-entry (create-comp :topic-entry render))
