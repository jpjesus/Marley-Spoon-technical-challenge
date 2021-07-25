# Marley Spoon Challenge

Simple app that lists recipes and show their detail using MVVM architecture.

## Architecture

``MVVM``
- Mainly uses the structure from MVVM.
- Aims to keep everything simple, but modular and reusable.
- Views more made programmatically without using Xib or storyboards to avoid any problems with conflicts if someone wants to work on parallel
- Unit test added for ViewModels and also a minor integration test
- The list of recipes view support portrait and landscape mode
- Use the contentful pod to fetch the recipes
- A separate class was created to handle the contentful pod

## Pods Used

- [Contentful](https://github.com/contentful/contentful.swift)

### Images

- Recipe list VC
 
 *Portrait mode
 
<img width="343" alt="Screen Shot 2021-07-24 at 8 45 23 PM" src="https://user-images.githubusercontent.com/17602606/126885365-145a1738-cc55-41ae-b8d1-321c88fa747b.png">

*Landscape mode

<img width="744" alt="Screen Shot 2021-07-24 at 8 45 16 PM" src="https://user-images.githubusercontent.com/17602606/126885372-c5412923-76e9-417c-a47b-5bfd94954bf0.png">

- Recipe detail VC

<img width="331" alt="Screen Shot 2021-07-24 at 8 45 40 PM" src="https://user-images.githubusercontent.com/17602606/126885388-d5dd6c36-f07f-4f55-9556-bb386cbbcbb4.png">


