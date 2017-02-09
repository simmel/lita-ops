# lita-ops

Ops people in your IRC channels.

## Installation

Add lita-ops to your Lita instance's Gemfile:

``` ruby
gem "lita-ops"
```

## Configuration

### Required attributes

* `should_be_oped` (Hash) - A hash of channels with an array of user masks as the value. E.g:
```
  config.handlers.ops.should_be_oped = {
    "#marvintesting" => %w(
      simmel!simmel@auxww.ps
    )
  }
```

## Usage

Add the config and op your bot and it will op the people you want.
