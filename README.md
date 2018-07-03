# alias_has_many

Aliases ActiveRecord's `has_many` as `direct` and `indirect`.

ActiveRecord's `has_many` has two distinct usages:

 - Setting up a direct association between two tables, e.g. in the case of a
   one-to-many. In this case, relevant options include `:foreign_key`,
   `:class_name`, etc.

 - Setting up an indirect association between two tables, e.g. in the case of a
   many-to-many. In this case, relevant options include `:through`, `:source`,
   etc.

This library provides aliases `direct` and `indirect` to make this distinction
explicit (in the spirit of
[SRP](https://en.wikipedia.org/wiki/Single_responsibility_principle)).

After including this gem, the following pairs would be equivalent:

```ruby
class Movie < ActiveRecord::Base
  has_many :roles,
           # has_many options
end

class Movie < ActiveRecord::Base
  direct_association :method_name => "roles",
                     # has_many options
end
```

```ruby
class Movie < ActiveRecord::Base
  has_many :roles

  has_many :cast,
           :through => "roles",
           :source => "actor",
           # has_many options
end

class Movie < ActiveRecord::Base
  direct_association :method_name => "roles"

  indirect_association :method_name => "cast",
                       :through => "roles",
                       :source => "actor",
                       # has_many options
end
```

You can use symbols rather than strings for the values, if you prefer.

`has_one` is supported with the `only_one: true` option:

```ruby
class Casting < ActiveRecord::Base
  belongs_to :movie

  has_one :director,
          :through => "movie",
          # has_one options
end

class Casting < ActiveRecord::Base
  belongs_to :movie

  indirect_association :method_name => "director",
                       :through => "movie",
                       :only_one => true,
                       # has_one options
end
```

You can use `:first_hop` rather than `:through` and `:second_hop` rather than
`:source`:

```ruby
class Movie < ActiveRecord::Base
  direct_association :method_name => "roles"
  
  indirect_association :method_name => "cast",
                       :first_hop => "roles",
                       :second_hop => "actor",
                       # has_many options
end
```

## Copyright

Copyright (c) 2018 Raghu Betina. See LICENSE.txt for further details.
