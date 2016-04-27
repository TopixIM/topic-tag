
ns topic-tag.component.tags-manager $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span input
  [] topic-tag.style.widget :as widget
  [] topic-tag.component.tag-rm :refer $ [] component-tag-rm
  [] topic-tag.component.tag-select :refer $ [] component-tag-select
  [] topic-tag.component.space :refer $ [] component-space

defn init-state ()
  , |

defn update-state (state text)
  , text

def style-textbox widget/textbox

defn handle-input (mutate)
  fn (simple-event dispatch)
    let
      (query $ :value simple-event)
      mutate query
      dispatch :query/tags query

defn handle-keydown (state mutate)
  fn (simple-event dispatch)
    if
      = 13 $ :key-code simple-event
      if
        > (count state)
          , 0
        do (dispatch :tag/submit state)
          mutate |

defn render (tags results)
  fn (state mutate)
    div
      {} :style $ {} (:width |100%)
        :height |100%
        :justify-content |center
        :align-items |center
        :display |flex
      div
        {} :style $ {} (:width |400px)
          :padding |16px
          :background-color |white
          :border $ str "|1px solid "
            hsl 0 0 80

        div
          {} :style $ {} (:font-family "|Helvetica Neue")
            :font-weight |lighter
            :line-height 2
            :font-size |24px
          span $ {} :attrs ({} :inner-text "|Some tags to describe yourself :)")

        div ({})
          ->> tags
            map $ fn (tag)
              [] (:id tag)
                component-tag-rm tag

            into $ sorted-map

        div ({})
          input $ {} :style style-textbox :event
            {} :input (handle-input mutate)
              , :keydown
              handle-keydown state mutate
            , :attrs
            {} :placeholder "|hit Enter to submit tag..." :value state

        component-space nil |20px
        div ({})
          ->> results
            map $ fn (tag)
              [] (:id tag)
                component-tag-select tag

            into $ sorted-map

def component-tags-manager $ create-comp :tags-manager init-state update-state render
