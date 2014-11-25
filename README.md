# Ruby on Rails Tutorial: sample application

This is the sample application for
the [*Ruby on Rails Tutorial*](http://railstutorial.org/)
by [Michael Hartl](http://michaelhartl.com/).

It follows the version [Rails 4.0](http://rails-4-0.railstutorial.org/book/) of the book

Done as  refresher of Rails

### Deployed on Heroku as https://dry-reef-5808.herokuapp.com/

As a comment when deploy  on  heroku , the application does not run and do next:


```
 $ heroku logs

2014-05-15T08:20:31.044847+00:00 heroku[router]: at=error code=H14 desc="No web processes running" method=GET
```

````
$ heroku ps:scale web=1
````
