# Classifile

Classifile is a tool for classifying files by Ruby DSL.

## Installation

    $ gem install classifile

## Usage


1. Write a DSL.

    ```ruby
   # dsl.rb 
   
    dir "Images" do
      image?
      dir "Dogs" do
        include? "dog"
      end
    
      dir "Cats" do
        dir "Kittens" do
          include? "kitten"
        end
        include? "cat"
      end
    end
    
    dir "Movies" do
      movie?
    end
    ```

2. Prepare the files.

```shell
temp/
├from/
│ ├─wild_dog.jpg
│ ├─beautiful_cat.png
│ ├─cute_kitten.gif
│ └─dancing_cat.mpg
└to/
```

3. Run the command

```shell
$ classifile dsl.rb -from "/temp/from/*" -to "/temp/to" 
```

4. Done!

```shell
temp/
├from/
└to/
　├Images/
　│　├Dogs/
　│　│　└─wild_dog.jpg
　│　└Cats/
　│　　│└─beautiful_cat.png
　│　　└Kittens/
　│　　　└─cute_kitten.gif
　└Movies/
　　└─dancing_cat.mpg
```

## Syntax

(TODO)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kurehajime/classifile. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/classifile/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Classifile project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/classifile/blob/main/CODE_OF_CONDUCT.md).
