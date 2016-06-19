
(ns topic-tag.component.chat-room
  (:require [hsl.core :refer [hsl]]
            [topic-tag.style.widget :as widget]
            [respo.alias :refer [create-comp div span button input]]
            [topic-tag.component.message :refer [component-message]]))

(defn init-state [topic] "")

(defn update-state [state text] text)

(defn handle-input [mutate state]
  (fn [simple-event dispatch]
    (dispatch :state/buffer (:value simple-event))
    (mutate (:value simple-event))))

(defn handle-submit [mutate state]
  (fn [simple-event dispatch]
    (dispatch :message/create state)
    (mutate "")))

(defn handle-keydown [mutate state]
  (fn [simple-event dispatch]
    (if (= 13 (:key-code simple-event))
      (do (dispatch :message/create state) (mutate "")))))

(defn handle-edit [topic-id]
  (fn [simple-event dispatch] (dispatch :topic/open-editor topic-id)))

(defn render [topic buffers]
  (fn [state mutate]
    (div
      {:style
       {:background-color (hsl 0 0 100),
        :width "100%",
        :display "flex",
        :flex-direction "column",
        :height "100%"}}
      (div
        {:style
         {:line-height 2,
          :align-items "center",
          :font-size "24px",
          :font-weight "lighter",
          :padding "0 16px",
          :justify-content "space-between",
          :display "flex",
          :font-family "Helvetica Neue"}}
        (span {:attrs {:inner-text (:text topic)}})
        (button
          {:style widget/button,
           :event {:click (handle-edit (:id topic))},
           :attrs {:inner-text "Edit"}}))
      (div
        {:style
         {:overflow "auto",
          :flex 1,
          :display "flex",
          :padding-bottom "200px",
          :flex-direction "column"}}
        (->>
          (:messages topic)
          (sort
            (fn [entry-1 entry-2]
              (compare (:time (val entry-1)) (:time (val entry-2)))))
          (map-indexed
            (fn [index entry]
              (let [message (val entry)]
                [(:id message)
                 (div
                   {:style {:order (inc index)}}
                   (component-message message))])))
          (into (sorted-map))))
      (div
        {:style {:max-height "200px", :overflow "auto"}}
        (->>
          buffers
          (map-indexed
            (fn [index buffer-message] [index
                                        (component-message
                                          buffer-message)]))))
      (div
        {:style {:display "flex"}}
        (input
          {:style widget/textbox,
           :event
           {:keydown (handle-keydown mutate state),
            :input (handle-input mutate state)},
           :attrs {:placeholder "type in here...", :value state}})
        (button
          {:style widget/button,
           :event {:click (handle-submit mutate state)},
           :attrs {:inner-text "Submit"}})))))

(def component-chat-room
 (create-comp :chat-room init-state update-state render))
