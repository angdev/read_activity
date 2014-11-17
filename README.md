# ReadActivity

Manages read activities.

This gem supports to get read/unread status (including read_at), read/unread users for a specific readable, etc.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'read_activity'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install read_activity

## Usage example

```ruby

class User < ActiveRecord::Base
  acts_as_reader
end

class Article < ActiveRecord::Base
  acts_as_readable
end

user = User.create!
article = Article.create!

user.read!(article)
# or article.read_by!(user)

user.read?(article) # == true
# or article.read_by?(user) == true

user.read_at(article)
# or article.read_by_at(user)

article.readers # == [user]
# or user.read_articles == [article]
# user.read_#{reader_table_name} (the plural form)

article.unreaders # == []
# or user.unread_articles == []
# user.unread_#{readable_table_name} (the plural form)

reader = article.readers.first
reader.read_at # no required params when you have fetched readers using #readers

read_article = user.read_articles.first
read_article.read_by_at

User.find_who_read(article)
User.find_who_unread(article)

Article.find_read_by(user)
Article.find_unread_by(user)

```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/read_activity/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
