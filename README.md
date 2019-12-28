# i_did_mean [![Build Status](https://travis-ci.org/shime/i_did_mean.svg?branch=master)](https://travis-ci.org/shime/i_did_mean)

[Did you mean](https://github.com/ruby/did_you_mean)? I did mean!

Autocorrects spelling mistakes reported by DidYouMean. Only attempts to autocorrect when there is a single suggestion from DidYouMean.

## Example

This code:

```ruby
require "i_did_mean"

def bar
  "foo"
end

ba
```

Will get autocorrected to:

```ruby
require "i_did_mean"

def bar
  "foo"
end

bar
```

This code:

```ruby
require "i_did_mean"

first_name = nil
flrst_name
```

Will get autocorrected to:

```ruby
require "i_did_mean"

first_name = nil
first_name
```

This code:

```ruby
require "i_did_mean"

hash = { "foo" => 1, bar: 2 }
hash.fetch(:bax)
```

Will get autocorrected to:

```ruby
require "i_did_mean"

hash = { "foo" => 1, bar: 2 }
hash.fetch(:bar)
```

For more examples, check out the [test directory](https://github.com/shime/i_did_mean/tree/master/test).

## License

Copyright (c) 2019 Hrvoje Simic. See LICENSE for further details.
