
(ns topic-tag.component.container
  (:require [hsl.core :refer [hsl]]
            [respo.alias :refer [create-comp div span]]
            [topic-tag.component.sidebar :refer [component-sidebar]]
            [topic-tag.component.login :refer [component-login]]
            [topic-tag.component.tags-manager :refer [component-tags-manager]]
            [topic-tag.component.profile :refer [component-profile]]
            [topic-tag.component.topics :refer [component-topics]]
            [topic-tag.component.chat-room :refer [component-chat-room]]
            [topic-tag.component.topic-editor :refer [component-topic-editor]]
            [topic-tag.component.tags-overview :refer [component-tags-overview]]
            [topic-tag.component.members-overview :refer [component-members-overview]]
            [topic-tag.component.notification-center :refer [comp-notification-center]]))

(def style-layout
 {:width "100%", :display "flex", :position "absolute", :height "100%"})

(def style-sidebar {:background-color (hsl 0 0 96), :width "300px"})

(defn render-store [store]
  (div
    {:style
     {:line-height "1.5em",
      :color "white",
      :font-size "12px",
      :top "100px",
      :overflow "auto",
      :width "400px",
      :background (hsl 0 0 10 0.24),
      :padding "4px",
      :right "0px",
      :position "absolute",
      :pointer-events "none",
      :font-family "Menlo",
      :height "300px"}}
    (span {:attrs {:inner-text (pr-str (:state store))}})))

(def style-container
 {:align-items "center",
  :background-color (hsl 200 70 90),
  :flex 1,
  :justify-content "center",
  :display "flex"})

(defn render [store]
  (fn [state mutate]
    (let [session (:state store)
          logged-in? (some? (:user-id session))
          router (:router session)
          live-users (:live-users store)]
      (if logged-in?
        (div
          {:style style-layout}
          (div
            {:style style-sidebar}
            (component-sidebar (first router) (count live-users)))
          (div
            {:style style-container}
            (case
              (first router)
              :my-tags
              (let [tags (:my-tags store)
                    results (:tags (:results session))]
                (component-tags-manager tags results))
              :profile
              (component-profile (:user store))
              :topics
              (component-topics (:topics store))
              :my-topics
              (component-topics (:my-topics store))
              :add-topic
              (let [results (:tags (:results session))]
                (component-topic-editor nil results))
              :topic-editor
              (let [topic-data (get router 1)
                    results (:tags (:results session))]
                (component-topic-editor topic-data results))
              :chat-room
              (component-chat-room
                (:current-topic store)
                (:buffers store))
              :all-tags
              (component-tags-overview (:tags store))
              :live-users
              (component-members-overview live-users)
              nil))
          (render-store store)
          (comp-notification-center (:notifications session)))
        (div
          {:style
           {:align-items "center",
            :background-color (hsl 200 90 70),
            :width "100%",
            :justify-content "center",
            :display "flex",
            :position "absolute",
            :height "100%"}}
          (component-login)
          (comp-notification-center (:notifications session)))))))

(def component-container (create-comp :container render))
