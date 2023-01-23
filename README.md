# flutter-jsonreading
show various category objects ( provided in json format ) in the application. The categories will be provided as an unsorted list of json objects. Some of these categories are children of other parent categories.

The assignment is to show various category objects ( provided in json format ) in the
application. The categories will be provided as an unsorted list of json objects. Some of
these categories are children of other parent categories.
The task is to show the parent categories on the main screen ( Screen A ). When the user
clicks on one of the categories the application will check if the selected category has children
categories associated with it or not. If yes, the application will navigate to the second screen
( Screen B ) to display those child categories. If there are more child categories for the
category selected on the Screen B then navigate again to the Screen B with its child
categories. Finally when the last category is selected and there are no more child categories
for it then navigate to the last screen ( Screen C ).
The categories will be related to each other based on their ID parameter in the json object.
The children categories’ json object will have a parent parameter as the ID of the parent
category.

example of an object:

{
"id": 1,
"name": "Clothes",
"slug": "clothes",
"parent": 0,
}
