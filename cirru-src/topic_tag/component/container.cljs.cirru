
ns topic-tag.component.container $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span
  [] topic-tag.component.sidebar :refer $ [] component-sidebar
  [] topic-tag.component.login :refer $ [] component-login
  [] topic-tag.component.tags-manager :refer $ [] component-tags-manager
  [] topic-tag.component.profile :refer $ [] component-profile
  [] topic-tag.component.topics :refer $ [] component-topics
  [] topic-tag.component.topic-editor :refer $ [] component-topic-editor

def style-layout $ {} (:width |100%)
  :height |100%
  :position |absolute
  :display |flex

def style-sidebar $ {}
  :background-color $ hsl 0 0 90
  :width |300px

def style-store $ {} (:position |absolute)
  :width |400px
  :height |200px
  :background $ hsl 0 0 10 0.24
  :color |white
  :left |0px
  :top |0px
  :font-family |Menlo
  :padding |4px
  :font-size |12px
  :line-height |1.5em
  :pointer-events |none

def style-container $ {}
  :background-color $ hsl 200 70 90
  :flex 1
  :display |flex
  :justify-content |center
  :align-items |center

defn render (store)
  fn (state mutate)
    let
      (session $ :state store)
        logged-in? $ some? (:user-id session)
        router $ :router session

      div ({} :style style-layout)
        div ({} :style style-sidebar)
          component-sidebar $ first router
        div ({} :style style-container)
          if logged-in?
            case (first router)
              :tags $ let
                (tags $ :tags store)
                  results $ :tags (:results session)

                component-tags-manager tags results

              :profile $ component-profile (:user store)
              :topics $ component-topics (:topics store)
              :add-topic $ let
                (results $ :tags (:results session))

                component-topic-editor nil results

              , nil

            component-login

        div ({} :style style-store)
          span $ {} :attrs
            {} :inner-text $ pr-str store

def component-container $ create-comp :container render
