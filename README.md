# flutter_pixabay
> Developed using [Pixabay Api](https://pixabay.com/zh/service/about/api/). App includes picture download and video download.There is also a picture and video search function


# How to use App?
1. download project
2. terminal run  flutter pub get
3. find the constants file after opening the utils folder and modify the constant kApiKey to your apikey
4. run project

# App content
1. [ ] Image Page
   1. [ ] Search Result Filte
   2. [x] Sort Result
   3. [x] Load more
2. [ ] Video Page
   1. [ ] Search Result Filte
3. [ ] Search Page
   1.  [ ] Search Result Filte
   2.  [x] Load More
4. [ ] Category Page
   1. [ ] Search Result Filte
5. [ ] Setting Page
   1. [x] Theme Page
      1. [x] Toggle Theme Mode
      2. [x] Select Theme Color
   2. [ ] About Page
   3. [ ] Cache Page
      1. [ ] Toggle Cache (Default Open)
   4. [ ] Feedback Page
      1. [ ] Send Email
   5. [ ] Sponsor Page
      1. [ ] QRcode
6. [ ] Image Details Page
   1. [x] Download Image
   2. [x] Origin Image
   3. [ ] Set Wallpaper
7. [ ] Video Details Page
   1. [ ] Download Video
   2. [ ] Video Play
   
# Library
[provider: ^6.0.5]()

[shared_preferences: ^2.0.18]()

[dio: ^5.0.1]()

[extended_nested_scroll_view: ^6.0.0]()

[flutter_staggered_grid_view: ^0.6.2]()

[image_gallery_saver: ^1.7.1]()