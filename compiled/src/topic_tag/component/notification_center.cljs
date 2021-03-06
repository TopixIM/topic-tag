
(ns topic-tag.component.notification-center
  (:require [hsl.core :refer [hsl]]
            [respo.alias :refer [create-comp div span]]))

(defn render [notifications] (fn [simple-event dispatch] (div {})))

(def comp-notification-center (create-comp :notification-center render))
