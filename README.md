# RussianWordforms

Gem detects wordforms. It uses russian ispell dictionary written by Alexander I. Lebedev

You can find last versions of dictionary at author's website http://scon155.phys.msu.su/~swan/orthography.html

## Installation

Add this line to your application's Gemfile:

    gem 'russian_word_forms'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install russian_word_forms

## Usage

base_form=RussianWordForms.get_base_form("облаками")
=> ["ОБЛАКО"]
RussianWordForms.inflect(base_form.first)
=> ["ОБЛАКА", "ОБЛАКУ", "ОБЛАКОМ", "ОБЛАКЕ", "ОБЛАКАМ", "ОБЛАКАМИ", "ОБЛАКАХ"]


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
