# Madoka

A model based on ActiveModel that provides mass assignment with role support.

## Installation

Add this line to your application's Gemfile:

    gem 'madoka'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install madoka

## Usage

An example from spec:

    class MadokaModel
      include Madoka::Model
      attr_accessor :accessible_by_default, :protected_by_default
      attr_accessor :accessible_by_admin
      attr_accessible :accessible_by_default
      attr_protected :protected_by_default
      attr_accessible :accessible_by_admin, as: :admin

      attr_accessor :flow

      before_save :run_before_save
      after_save :run_after_save

      def run_before_save
        @flow = [:before_save]
      end

      def run_after_save
        @flow << :after_save
      end
    end

## Todo

* Work with multiparameter

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
