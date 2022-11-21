# README

## GraphQL
GraphQL is a powerful tool that helps save precious time. Like the REST API, GraphQL fetches some information, or data, in the database. The main difference is the GraphQL will only fetch what we want, so there won't be unnecessary data. It will also fetches our information in one query, which makes GraphQL faster when we deal with a big database.

### Install
The installation of GraphQL is really simple, it's a command in the terminal. We installed also GraphiQL which is a visual representation of the commands we can do to fetch data, working similarly to Postamn. We can find the data we want directly on GraphiQL.

We defined our endpoints in routes.rb to link GraphiQL and Postman to our database.

In order to make GraphQL works we needed to create some types. These types were the files where we entered the fields we needed in the database. It is also the place where we linked two or more tables. For instance to fetch the address of a building in our database, we added building in our `interventionType` class, which made the building's info available with an intervention query. 
Here's the example I'm talking about:
```
query{
  intervention(id:18){
        id
        interventionStartAt
        interventionEndAt
        buildingId
        building{
            id
            buildingAddress
        }
    }
}
```

### Note
we have integrated the graphql API in the program of our website. So we used the same repo for the site and the graphql API
