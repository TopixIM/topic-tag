
ns topic-tag.component.container $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span
  [] topic-tag.component.sidebar :refer $ [] component-sidebar
  [] topic-tag.component.login :refer $ [] component-login
  [] topic-tag.component.tags-manager :refer $ [] component-tags-manager

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
  :background $ hsl 0 0 10 0.3
  :color |white
  :left |10px
  :top |200px
  :font-family |Menlo
  :padding |4px
  :font-size |12px
  :line-height |1.5em

def style-container $ {}
  :background-color $ hsl 200 70 90
  :flex 1

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
          if (not logged-in?)
            component-login
          if logged-in? $ let
            (tags $ :tags store)
              results $ :tags (:results session)

            component-tags-manager tags results

        div ({} :style style-store)
          span $ {} :attrs
            {} :inner-text $ pr-str store

def component-container $ create-comp :container render
