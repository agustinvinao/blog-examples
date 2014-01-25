== README

This is an example for [a post in my blog](http://blog.agustinvinao.com/post/74489979042/angularjs-validations-with-rails-model-validations) where I explain how to do an AngularJS form validations using Rails model's validations.

The example is for a new Contact in this appilcation.

To see the example, you need to:

1. git clone git@github.com:agustinvinao/blog-examples.git
2. cd form-validations
3. bundle install
4. rails s

and go to http://localhost:3000/contacts/new

In this form you'll see how the Submit button is disabled until you fill the Contact's name and email, it also checks the emails format.

Contact model has two validations:

```ruby
  validates :name, :presence => true
  validates :email, :presence => true, uniqueness: true, :format => {:with => /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i}
```

This validations are added to our form buy our rails code.