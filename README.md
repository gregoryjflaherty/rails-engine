
# Rails Engine



## Table of Contents

  - [Author](#author)
  - [Utilizing This Repository](#utilizing-this-repository)
  - [API End Points](#api-end-points)
  - [Collaboration](#collaboration)
  - [Built With](#built-with)


## Author

   ### Greg Flaherty <br>
   [![Linkedin](https://i.stack.imgur.com/gVE0j.png) LinkedIn](https://www.linkedin.com/gregoryjflaherty)<br>
   [![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/gregjflaherty.svg?style=social&label=Follow%20%40gregjflaherty)](https://twitter.com/gregjflaherty)


![alt text](https://user-images.githubusercontent.com/87443686/161275037-2fcb9079-ea22-41f7-84b2-e217c10f06fe.png)


</div>



## Utilizing This Repository

- Fork this repo and clone down to local computer
- CD into repository 
- Run rails s to start your server
- In browser - go to localhost:3000 and enter in your end point of choice 
- Relational database of content goes as follows: 
![alt text](https://user-images.githubusercontent.com/87443686/161279206-3b5b3d68-0d5c-4760-8d0f-a08f93f4feb5.png)
  
## API End Points

#### Items
* GET all items `http://localhost:3000/api/v1/items` 
* GET a single item `http://localhost:3000/api/v1/merchants/:id`
* POST create an item `localhost:3000/api/v1/items` --- use with JSON body
* UPDATE an item `localhost:3000/api/v1/items/:id` --- use with JSON body
* DESTROY an item `localhost:3000/api/v1/items/:id` NOTE ** if this item is the only item left on a particular invoice, that invoice will also be destroyed

#### Merchants
* GET all merchants `http://localhost:3000/api/v1/merchants` 
* GET a single merchant `http://localhost:3000/api/v1/merchants/:id`

#### Item/Merchant Relationship

* GET all items belonging to a merchant `http://localhost:3000/api/v1/merchants/:id/items`
* GET the merchant belonging to an item `http://localhost:3000/api/v1/items/:id/merchant`

#### Searching 
##### Find
  * Search Item by name `http://localhost:3000/api/v1/items/find?name=`
  * Search Item by min price `http://localhost:3000/api/v1/items/find?min_price=`
  * Search Item by max price `http://localhost:3000/api/v1/items/find?max_price=`
  * Search Item by price range`http://localhost:3000/api/v1/items/find?max_price=10&min_price=1`
  * Search Merchant by name `http://localhost:3000/api/v1/merchants/find?name=`
  

##### Find all - `provides list of first 18`
  * Search All Items by name `http://localhost:3000/api/v1/items/find?name=`
  * Search All Merchants by name `http://localhost:3000/api/v1/merchants/find?name=`

## Collaboration

- If feedback, ideas to improve or general comments arise feel free to message me via the platforms listed above
- If improvements in code arise, feel free to create a branch, implement such code, and create a PR request


## Built With

<p>
  <img src="https://img.shields.io/badge/Ruby-CC0000.svg?&style=flaste&logo=ruby&logoColor=white" />
  <img src="https://img.shields.io/badge/ActiveRecord-CC0000.svg?&style=flaste&logo=rubyonrails&logoColor=white" />
  <img src="https://img.shields.io/badge/Atom-66595C.svg?&style=flaste&logo=atom&logoColor=white" />  
  <img src="https://img.shields.io/badge/Git-F05032.svg?&style=flaste&logo=git&logoColor=white" />
  <img src="https://img.shields.io/badge/GitHub-181717.svg?&style=flaste&logo=github&logoColor=white" />
  </br>
  <img src="https://img.shields.io/badge/Postman-FF6E4F.svg?&style=flat&logo=postman&logoColor=white" />
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1.svg?&style=flaste&logo=postgresql&logoColor=white" />
</p>

## On

<p>
  <img src="https://img.shields.io/badge/Ruby%20On%20Rails-b81818.svg?&style=flat&logo=rubyonrails&logoColor=white" />
</p>

## Using 
<p>
  <img src="https://img.shields.io/badge/OOP-b81818.svg?&style=flaste&logo=OOP&logoColor=white" />
  <img src="https://img.shields.io/badge/TDD-b87818.svg?&style=flaste&logo=TDD&logoColor=white" />
  <img src="https://img.shields.io/badge/MVC-b8b018.svg?&style=flaste&logo=MVC&logoColor=white" />
  <img src="https://img.shields.io/badge/REST-33b818.svg?&style=flaste&logo=REST&logoColor=white" />  
</p>
