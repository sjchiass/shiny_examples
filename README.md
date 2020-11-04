# A few Shiny examples

I started using R Shiny heavily in the summer of 2020. Since those memories are still fresh in my mind, I've prepared a few examples of what I consider the building blocks of Shiny.

  * The convenient HTML tags
  * The pre-fabricated user interface elements
  * The reactive environment in the server

## HTML

### 001-html

[001-html](/001-html/app.R) is simply an app with some text in it. It does nothing else.

Shiny lets you put HTML in your app. You can use this to customize your app's appearance and behaviour.

### 002-styling

[002-styling](/002-styling/app.R) is the same app as above, but it adds some CSS styling to some of the text.

While this is still simple, this kind of HTML is useful when you need to adjust Shiny's default style.

In this Stack Overflow question, you can see someone wanting to reduce the padding of the dropdown menus: <https://stackoverflow.com/questions/43689281/rshiny-reduce-bottom-padding-shiny-dashboard-box>.

## UI

### 003-ui

[003-ui](/003-ui/app.R) shows you how a UI in Shiny is built. You pick the UI elements that you want and lay them out on the page.

This R Shiny cheatsheet can help you find the inputs and layouts that are best for your app: <https://shiny.rstudio.com/images/shiny-cheatsheet.pdf>

## Reactivity

### 004-dataframe

[004-dataframe](/004-dataframe/app.R) is a simple example of how inputs are read by the server and outputs are served back to the user.

The server is able to react to the input thanks to reactivity. Reactivity is a core feature in R Shiny that lets you quickly create dynamic variables.

I was at first baffled by reactivity in R Shiny. I had not seen something like it in programming before. Eventually I started seeing it as just another abstraction.

### 005-dplyr

[005-dplyr](/005-dplyr/app.R) shows how ubiquitous reactivity can be in a Shiny app. One of the UI elements is dynamic, and the server keeps a few reactive values that it recalculates when needed. The app also shows how you have to use dplyr a bit differently in Shiny, especially if you're selecting variables dynamically.

If you would like to visualize reactivity in action, be sure to check out reactlog: <https://rstudio.github.io/reactlog/>
