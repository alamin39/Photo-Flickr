# Photo-Flickr

Photo-Flickr application written in Swift. This project searches for images using Flickr API and displays in a list and provides endless scrolling. Also, pressing on a image will take you to details page. You can share, save and zoom in/out images. NetworkManager takes care of fetching data from Flickr service. The application uses MVVM architecture.

### Technology:

Swift, MVVM, Cocoapods, Kingfisher, Xcode 14.3



### Flickr API:

Images are retrieved by hitting the [Flickr API](https://www.flickr.com/services/api/flickr.photos.search.html).



### Features:
1. Home screen: shows a list of searched pictures based on keywords
2. Details screen: shows a selected picture from results screens
3. Searches persisted between launches
4. Save picture in Photos
5. Share picture
6. Zoom in, zoom out 
7. Unit tests
8. UI tests

### Decisions 

* Used MVVM for better testability and separation of concern.
* Used Kingfisher for caching images. So that i don't have to retrieve same images again.
* Used Timer for debounce. So that it reduce repetitive network calls. 
* Used UserDefault for persisted between launches. As the app is simple that's why i choose UserDefault instead of CoreData.

### Screens


<img src="https://user-images.githubusercontent.com/39402639/234469933-ab6161e3-51a8-4529-a13c-868aefcf5eec.png" width="500" height="800">


<img src="https://user-images.githubusercontent.com/39402639/234469994-1940771a-8a1c-44cc-8e8f-2713ca542091.png" width="500" height="800">

