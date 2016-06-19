
(ns topic-tag.component.sidebar
  (:require [hsl.core :refer [hsl]]
            [respo.alias :refer [create-comp div span]]))

(def style-root
 {:justify-content "center",
  :display "flex",
  :flex-direction "column",
  :height "100%"})

(defn style-entry [selected?]
  {:line-height 2,
   :font-size "24px",
   :font-weight "lighter",
   :font-family "Helvetica Neue"})

(defn handle-route [router-name]
  (fn [simple-event dispatch] (dispatch :state/route router-name)))

(defn render-route [router-name this-name guide]
  (div
    {:style
     {:text-align "right",
      :background-color
      (if (= router-name this-name) (hsl 180 70 80 0.5) (hsl 0 0 0 0)),
      :width "100%",
      :cursor "pointer",
      :padding "0 16px"},
     :event {:click (handle-route this-name)}}
    (span
      {:style (style-entry (= router-name this-name)),
       :attrs {:inner-text guide}})))

(defn render [router-name count-online]
  (fn [state mutate]
    (div
      {:style style-root}
      (render-route router-name :my-topics "My Topics")
      (render-route router-name :topics "All Topics")
      (render-route router-name :my-tags "My Tags")
      (render-route router-name :all-tags "All Tags")
      (render-route
        router-name
        :live-users
        (str count-online " online users"))
      (render-route router-name :profile "Profile"))))

(def component-sidebar (create-comp :sidebar render))
