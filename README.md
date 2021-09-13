# Classifile

![status](https://github.com/kurehajime/classifile/actions/workflows/main_test.yml/badge.svg?branch=main)

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
$ classifile --dsl dsl.rb --from "/temp/from/*"  --to "/temp/to" 
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

## Options

Command line options are here.

|  Sort option  |  Long option  | Description  |
| ---- | ---- |---- |
|  -d  *PATH* |  --dsl *PATH*  |DSL path  |
|  -f *PATH* |  --from *PATH*  |Source directory path  |
|  -t *PATH* |  --to *PATH*  |Output directory path  |
|  -p  |  --preview  |Preview Mode(don't move,don't copy)  |
|  -c  |  --copy  |Copy Mode(don't move)  |
|  -h  |  --help  |Show this help  |

## Syntax

### Classifile rules.

1. The hierarchy of the dir block represents the directory hierarchy.
2. If the check fails, exit the block.
3. When It complete a block to the end, it will be saved in that directory.

### Block methods

#### dir block

`dir` block represents a directory.
A dir block can also be nested.

```ruby
dir "Images" do
   image?
   dir "Dogs" do
      include? "dog"
   end
end
```

`dog.png -> /Images/Dogs/dog.png`

#### group block

`group` block is a group that does not have a directory.

```ruby
group "Animals" do
   dir "Dogs" do
      include? "dog"
   end
end
```

`dog.png -> /Dogs/dog.png`

### Check methods

The check method checks if the file should be stored in that directory.
If it does not pass the check, it will leave the block immediately.

#### include?

`include?` method checks if the file name contains one of the strings.

```ruby
dir "Dogs" do
   include? "dog"
end

dir "Cats" do
   include? "cat" , "kitten"
end
```

`dog.png -> /Dogs/dog.png`
`cat.png -> /Cats/cat.png`
`kitten.png -> /Cats/kitten.png`


#### end_with?

`end_with?` method checks if the file name ends with one of the string.

```ruby
dir "Archives" do
   end_with? ".zip" , ".gz"
end
```

`doc.zip -> /Archives/doc.zip`

#### image? / sound? / movie?

`image?` method checks if a file is an image or not.

`sound?` method checks if a file is an sound or not.

`movie?` method checks if a file is an movie or not.

```ruby
dir "Images" do
   image?
end

dir "Movies" do
   image?
end
```

`cat.png -> /Images/cat.png`
`dog.avi -> /Movies/dog.avi`


#### assert / assert_nil / assert_includes ...

You can also use the [minitest](https://docs.ruby-lang.org/ja/2.1.0/class/MiniTest=3a=3aAssertions.html)
methods.

```ruby
dir "Archives" do |file|
   assert_includes %w[.zip .gz], file.extname
end
```

`doc.zip -> /Archives/doc.zip`


### Other methods

#### empty_dir!

If `empty_dir!` is executed, the file will not be saved directly under that directory.

In this example, `dog.png` will be saved in `Images/Dogs`. In this example, `dog.png` will be saved in `Images/Dogs`, but `cat.png` will not be saved anywhere.

```ruby
dir "Images" do
   empty_dir!
   image?
   dir "Dogs" do
      include? "dog"
   end
end
```

`doc.png -> /Images/Dogs/dog.png`
`cat.png ->  (not saved) `

#### after_save

Execute the method after the save is complete.

```ruby
dir "Markdown" do |_file|
  end_with? ".md"
  after_save :hello
  
  def hello
    puts "hello"
  end
end
```

`hello.md -> /Markdown/hello.md`

and 

The output is "hello".


### Block argument

File information can be obtained by block argument.

```ruby
dir "Archives" do |file|
   assert_includes %w[.zip .gz], file.extname
end
```

|  Property  |  Description  |
| ---- | ---- |
|  dirname  |  The directory before the move  |
|  basename  |  File name  |
|  pure_basename  |  File name without extension  |
|  extname  |  Extension  |
|  atime  |  Date and time of made  |
|  ctime  |  Date and time of change  |
|  size  |  File size  |
|  to_path  |  Paths that will be saved  |



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kurehajime/classifile. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/classifile/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Classifile project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/classifile/blob/main/CODE_OF_CONDUCT.md).
