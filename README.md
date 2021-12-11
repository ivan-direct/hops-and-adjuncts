<div id="top"></div>

<!-- PROJECT SHIELDS -->
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />

[![Logo][logo]](https://github.com/ivan-direct/hops-and-adjuncts)

<div align="center">
  <h3 align="center">Hops-and-Adjuncts</h3>

  <p align="center">
    A web application that can be used to learn more about hop and adjunct (non-traditional ingredients) trends.
  </p>
  <br/>
</div>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://hops-and-adjuncts.herokuapp.com/)

I am a software developer with a passion for both home brewing and the craft beer scene, so when I decided to build a web application to showcase my abilites I decided to build a React / Ruby on Rails application to display useful information regarding hops and brewing adjuncts.

This project is currently restricted to Colorado at this time but could easily be expanded. 

Why Hops & Adjuncts?:
* To allow beer enthusiasts to find beers that contain their favorite hops. I didn't see a way to do this via Google search or by using beer social media sites.
* Enable homebrewers to find ratings on hop popularity and common hop pairings for recipe design. I often found myself asking questions like, "I have some extra Nelson Sauvin hops lying around; What pairs well with Nelson?"
* I created a hop rating system based on online beer ratings containing these hops. This provides a resource for hobbyists and industry professionals to track emerging trends in craft beer. :beer:

Although the primary focus of this application (and website) is to give me the ability to show job recruiters and prospective employers what I am capable of, I hope it can serve double-duty as a useful tool for both homebrewers and the craft beer industry. That would likely entail obtaining a proper Domain and moving off the free Heroku tier. To fund this I'd need some sponsors. _Yakima Valley give me a holler!_



### Built With

This section should list any major frameworks/libraries used to bootstrap your project. Leave any add-ons/plugins for the acknowledgements section. Here are a few examples.

* [Ruby on Rails](https://rubyonrails.org/)
* [React.js](https://reactjs.org/)



### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/ivan-direct/hops-and-adjuncts
   ```
2. Install Yarn packages
   ```sh
   yarn install
   ```
3. Create a Database and `database.yml` file
4. Run the migrations:
   ```sh
     rake db:migrate
   ```
5. Add some data:
  ```sh
     rake factory_setup:build
  ```
6. Start the server:
  ```sh
     rails server
  ```
7. visit localhost:3000 to see the application in action.



<!-- USAGE EXAMPLES -->
## Usage

Feel free to use any of the code in this repository. Have fun and don't @ me!



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.




<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [Heroku](https://heroku.com)
* [Nokogiri](https://nokogiri.org)
* [Ant Design](https://ant.design)
* [Colorado Brewery List](https://www.coloradobrewerylist.com/brewery/)
* [Img Shields](https://shields.io)



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[license-shield]: https://img.shields.io/github/license/ivan-direct/hops-and-adjuncts.svg?style=for-the-badge
[license-url]: https://github.com/ivan-direct/hops-and-adjuncts/blob/main/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/nate-dipiazza-00644b66/
[product-screenshot]: display_images/hops_and_adjucts_ss.png
[logo]: display_images/logo.png