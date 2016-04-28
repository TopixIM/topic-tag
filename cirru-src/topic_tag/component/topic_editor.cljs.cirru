
ns topic-tag.component.topic-editor $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp create-element div span input button
  [] topic-tag.component.tag-rm :refer $ [] component-tag-rm
  [] topic-tag.component.tag-select :refer $ [] component-tag-select
  [] topic-tag.style.widget :as widget

defn init-state (default-topic results)
  if (some? default-topic)
    {} :text (:text default-topic)
      , :tags
      :tags default-topic
      , :query |
    {} :text | :tags (hash-set)
      , :query |

defn update-state (state op op-data)
  case op
    :text $ assoc state :text op-data
    :query $ assoc state :text op-data
    :add-tag $ update state :tags
      fn (tags)
        conj tags op-data

    :rm-tag $ update state :tags
      fn (tags)
        ->> tags
          filter $ fn (tag)
            not= (:id tag)
              , op-data

          into $ hash-set

    , state

defn handle-remove (mutate tag)
  fn (simple-event dispatch)
    mutate :rm-tag $ :id tag

defn handle-input (mutate data-path)
  fn (simple-event dispatch)
    mutate data-path $ :value simple-event

defn handle-query (mutate)
  fn (simple-event dispatch)
    dispatch :query/tags $ :value simple-event
    mutate :query $ :value simple-event

defn handle-add (mutate tag)
  fn (simple-event dispatch)
    mutate :add-tag tag

defn handle-submit (state)
  fn (simple-event dispatch)
    let
      (topic-data $ {} (:text $ :text state) (:tag-ids $ ->> (:tags state) (map :id) (into $ hash-set)))

      dispatch :topic/create topic-data

defn render (default-topic results)
  fn (state mutate)
    div
      {} :style $ {} (:width |500px)
        :background-color $ hsl 0 0 100
        :padding "|20px 0"
      div ({} :style widget/field-line)
        ->> (:tags state)
          map $ fn (tag)
            [] (:id tag)
              component-tag-rm tag $ handle-remove mutate tag

          into $ sorted-map

      div ({} :style widget/field-line)
        input $ {} :style widget/textbox :event
          {} :input $ handle-query mutate

      div ({} :style widget/field-line)
        ->> results
          map $ fn (tag)
            [] (:id tag)
              component-tag-select tag $ handle-add mutate tag

          into $ sorted-map

      div ({} :style widget/field-line)
        div ({} :style widget/field-guide)
          span $ {} :attrs ({} :inner-text |Title)

        input $ {} :style widget/textbox :event
          {} :input $ handle-input mutate :text

      div ({} :style widget/toolbar)
        button $ {} :style widget/button :event
          {} :click $ handle-submit state
          , :attrs
          {} :inner-text |Submit

def component-topic-editor $ create-comp :topic-editor init-state update-state render
