The detail view is a view that shows more info about a given activity, item, or anything. On full width browser it will be a sidebar in the right rail. On mobile/tablet it will be a collapsible full-wdith view, which when collapsed may show a status bar at the bottom.

The DetailView is unopinionated about what the content is within it but it has opinions about the structure: it expects
* `Maybe Activity`
* `Maybe Preview`
* `activityIsExpanded` 
* How to render Activity, StatusBar, and Preview.

## Right rail
The sidebar on the right hand side, only able to be viewed from browser view.

## Status bar
This is a short bar spanning either the width of the screen (in mobile view) or the width of the right rail (in browser view). It shows the current activity, including the name, icon, and maybe some other info we can decide later. And the Timer if applicable. 

# Data model
There are many states DetailView can be in:

* No Activity, No Preview
    * Mobile view: show nothing
    * Browser view: empty sidebar
* Yes Activity (isExpanded: TRUE), No Preview
    * Mobile view: show activity full screen
    * Browser view: show activity in right rail
* Yes Activity (isExpanded: FALSE), No Preview
    * Mobile view: show status bar
    * Browser view: show activity as status bar in right rail, empty otherwise
* Yes Activity (isExpanded: TRUE), Yes Preview
    * Mobile view: show preview (preview always covers activity)
    * Browse view: 
* Yes Activity (isExpanded: FALSE), Yes Preview
    * Mobile view: show preview full screen
    * Browser view: show preview in right rail with status bar at bottom
* No Activity, Yes Preview