# Riak::YzQuery

***EXPERIMENTAL! DO NOT USE IN PRODUCTION! THERE ARE SECURITY HOLES!***

Riak 2.0 will feature [Yokozuna](https://github.com/basho/yokozuna/), a 
distributed search system built on Apache Solr. `Riak::YzQuery` aims to provide
[Arel-style](http://guides.rubyonrails.org/active_record_querying.html#limit-and-offset)
querying for Yokozuna.

## Installation

Add this line to your application's Gemfile:

    gem 'riak-yz-query'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install riak-yz-query

## Usage

You've already got a Riak bucket full of JSON documents as such:

```json
{
  name_t: "Bryce Kerley",
  title_t: "Cosmopolitan Space Emperor",
  created_dt: "2007-12-13T23:59:59Z"
}
```

To create a blank query, pull it from the `Riak::Bucket`:

```ruby
q = @bucket.query
```

Let's look for Bryce:

```ruby
q = @bucket.query.where name_t: 'Bryce'
q.keys #=> ['Hswdh9zli0CDcnPSKmEGeIcd6tU']
q.values #=> {"Hswdh9zli0CDcnPSKmEGeIcd6tU"=> #<Riak::RObject {user,Hswdh...}>}
```

In the above example, `q` is a `Riak::YzQuery::QueryBuilder` instance. As the
name implies, and much like Active Record, you can build up more complex queries 
by chaining constraints.

```ruby
q = @bucket.query.where name_t: 'Andrew'
q.keys #=> ["PtgA5YsxWpSg7RzTY2eJVJ81hDQ", "OL1quOfOKiYEmxYsqvjf9cyRmH3"]
q2 = q.where name_t: 'Stone'
q2.keys #=> ["OL1quOfOKiYEmxYsqvjf9cyRmH3"]
```

`where` clauses are ANDed together. To OR together two values, use a string:

```ruby
q = @bucket.query.where 'name_t:Andrew OR name_t:Drew'
q.keys #=> ["Z0tsBudxTQp50pBlTNeBw6CtwZx", "OL1quOfOKiYEmxYsqvjf9cyRmH3", "PtgA5YsxWpSg7RzTY2eJVJ81hDQ"]
```

If you don't want to concatenate the string yourself, use an array.


***WARNING: THIS DOES NOT ADEQUATELY ESCAPE THINGS!*** Your application 
could host the first Yokozuna-injection exploit!

```ruby
q = @bucket.query.where ['name_t:? OR name_t:?', 'Drew', 'Andrew']
q.keys #=> ["Z0tsBudxTQp50pBlTNeBw6CtwZx", "OL1quOfOKiYEmxYsqvjf9cyRmH3", "PtgA5YsxWpSg7RzTY2eJVJ81hDQ"]
```

You can sort:

```ruby
q = @bucket.query.where(name_t: 'Andrew').order(created_dt: 'asc').keys
#=> ["OL1quOfOKiYEmxYsqvjf9cyRmH3", "PtgA5YsxWpSg7RzTY2eJVJ81hDQ"]
q = @bucket.query.where(name_t: 'Andrew').order('created_dt desc').keys
#=> ["PtgA5YsxWpSg7RzTY2eJVJ81hDQ", "OL1quOfOKiYEmxYsqvjf9cyRmH3"]
```

And you can paginate:

```ruby
q = @bucket.query.
        where(name_t: '*e*').
        order(created_dt: 'asc').
        limit(5).
        offset(5)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
