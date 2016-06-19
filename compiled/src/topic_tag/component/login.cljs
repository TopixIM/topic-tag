
(ns topic-tag.component.login
  (:require [hsl.core :refer [hsl]]
            [respo.alias :refer [create-comp div span input button]]
            [topic-tag.style.widget :as widget]
            [topic-tag.component.space :refer [component-space]]))

(defn init-state [] {:password "", :name ""})

(defn update-state [state kind op op-data]
  (case
    kind
    :set!
    (assoc state op op-data)
    :clear!
    {:password "", :name ""}
    state))

(def style-field widget/field-line)

(def style-guide widget/field-guide)

(def style-input widget/textbox)

(def style-button widget/button)

(defn handle-input [mutate state-path]
  (fn [simple-event dispatch]
    (mutate :set! state-path (:value simple-event))))

(defn handle-submit [state mutate]
  (fn [simple-event dispatch]
    (let [username (:name state)]
      (if (> (count username) 2)
        (do (dispatch :user/enter state) (mutate :clear!))))))

(def hint-unstable
 "This app is not stable and this is running in develop mode. Crashes and refreshes frequently. Also you may talk to me on https://www.livecoding.tv/jiyinyiyong/chat")

(defn render []
  (fn [state mutate]
    (div
      {:style
       {:background-color (hsl 0 0 100),
        :width "400px",
        :border (str "1px solid " (hsl 0 0 80))}}
      (div
        {:style
         {:line-height 2,
          :text-align "center",
          :font-size "24px",
          :font-weight "lighter",
          :font-family "Helvetica Neue"}}
        (span {:style {}, :attrs {:inner-text "Enter"}}))
      (div
        {:style
         {:color (hsl 0 0 60), :font-size "12px", :padding "0 16px"}}
        (span {:attrs {:inner-text hint-unstable}}))
      (div
        {:style style-field}
        (div
          {:style style-guide}
          (span {:attrs {:inner-text "Name:"}}))
        (input
          {:style style-input,
           :event {:input (handle-input mutate :name)},
           :attrs {:placeholder "a name?", :value (:name state)}}))
      (div
        {:style style-field}
        (div
          {:style style-guide}
          (span {:attrs {:inner-text "Password:"}}))
        (input
          {:style style-input,
           :event {:input (handle-input mutate :password)},
           :attrs
           {:placeholder "this app is built for fun, so...",
            :value (:password state)}}))
      (div
        {:style
         {:padding "8px 16px",
          :justify-content "flex-end",
          :display "flex"}}
        (button
          {:style style-button,
           :event {:click (handle-submit state mutate)},
           :attrs {:inner-text "Start"}}))
      (component-space nil "40px"))))

(def component-login
 (create-comp :login init-state update-state render))
