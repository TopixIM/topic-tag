
(ns topic-tag.component.tags-overview
  (:require [hsl.core :refer [hsl]]
            [respo.alias :refer [create-comp div span]]
            [topic-tag.component.tag-select :refer [component-tag-select]]))

(defn handle-select [tag]
  (fn [simple-event dispatch]
    (dispatch :state/route [:topics (:id tag)])))

(defn render [tags]
  (fn [state mutate]
    (div
      {:style
       {:min-height "400px",
        :background-color (hsl 0 0 100),
        :width "400px",
        :padding "16px"}}
      (div
        {}
        (->>
          tags
          (map
            (fn [tag] [(:id tag)
                       (component-tag-select
                         tag
                         (handle-select tag))]))
          (into (sorted-map)))))))

(def component-tags-overview (create-comp :tags-overview render))
